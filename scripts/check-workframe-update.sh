#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<'USAGE'
Usage: scripts/check-workframe-update.sh --target /path/to/project

Shows a read-only Workframe upgrade brief for an existing project: recorded and
available versions, the level the installed content actually matches, and the
state of every payload file against the template.
It never changes the target project.
USAGE
}

TARGET=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$TARGET" || ! -d "$TARGET" ]]; then
  echo "Target directory does not exist: $TARGET" >&2
  exit 1
fi

MARKER="$TARGET/.project-workframe-version"
if [[ ! -f "$MARKER" ]]; then
  echo "Missing Workframe marker: $MARKER" >&2
  exit 1
fi

field_value() {
  awk -F ': ' -v key="$1" '$1 == key { print substr($0, length(key) + 3); exit }' "$MARKER"
}

PROJECT_VERSION="$(field_value workframe)"
PROJECT_MODULES="$(field_value modules)"
CURRENT_VERSION="$(< "$ROOT_DIR/VERSION")"

if [[ -z "$PROJECT_VERSION" ]]; then
  echo "Marker has no workframe version: $MARKER" >&2
  exit 1
fi

if [[ -z "$PROJECT_MODULES" ]]; then
  PROJECT_MODULES="unknown"
fi

# Files the project owns. They ship once and then diverge by design, so their
# state is reported separately and is never a reason to copy the template over.
PROJECT_LOCAL_FILES=(
  "docs/CONCEPTS.md"
  "docs/QUALITY.md"
  "docs/DEBT.md"
  ".project-workframe-version"
)

is_project_local() {
  local candidate="$1"
  local known
  for known in "${PROJECT_LOCAL_FILES[@]}"; do
    if [[ "$candidate" == "$known" ]]; then
      return 0
    fi
  done
  return 1
}

# A module README documents the module for whoever applies Workframe and is not
# installed. A `.gitkeep` only keeps an empty payload directory in Git, and a
# project with real changes or specs deletes it; that is not drift.
is_installed_payload() {
  local template_path="$1"
  case "$template_path" in
    */.gitkeep) return 1 ;;
    template/modules/*/README.md) return 1 ;;
  esac
  return 0
}

project_path_of() {
  local template_path="$1"
  local rest
  case "$template_path" in
    template/base/*)
      printf '%s\n' "${template_path#template/base/}"
      ;;
    template/modules/*)
      rest="${template_path#template/modules/}"
      printf '%s\n' "${rest#*/}"
      ;;
  esac
}

MODULES_SOURCE="marker"
INSTALLED_MODULES="$PROJECT_MODULES"
if [[ "$INSTALLED_MODULES" == "unknown" ]]; then
  MODULES_SOURCE="files"
  INSTALLED_MODULES=""
  if [[ -d "$TARGET/.agents/skills" ]]; then
    INSTALLED_MODULES="agent-skills"
  fi
  if [[ -d "$TARGET/.codex/skills/design-orchestration" ]]; then
    INSTALLED_MODULES="${INSTALLED_MODULES:+$INSTALLED_MODULES,}design-pencil"
  fi
  if [[ -f "$TARGET/docs/checklists/frontend-quality.md" ]]; then
    INSTALLED_MODULES="${INSTALLED_MODULES:+$INSTALLED_MODULES,}frontend-quality"
  fi
fi

PAYLOAD_ROOTS=("template/base")
UNKNOWN_MODULES=""
if [[ -n "$INSTALLED_MODULES" ]]; then
  IFS=',' read -r -a module_list <<< "$INSTALLED_MODULES"
  for module in "${module_list[@]}"; do
    if [[ -d "$ROOT_DIR/template/modules/$module" ]]; then
      PAYLOAD_ROOTS+=("template/modules/$module")
    else
      UNKNOWN_MODULES="${UNKNOWN_MODULES:+$UNKNOWN_MODULES }$module"
    fi
  done
fi

RELEASES=()
if command -v git >/dev/null 2>&1 && git -C "$ROOT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
  while IFS= read -r tag; do
    [[ -n "$tag" ]] && RELEASES+=("$tag")
  done < <(
    git -C "$ROOT_DIR" tag -l 'v[0-9]*.[0-9]*.[0-9]*' |
      sed 's/^v//' |
      sort -t. -k1,1nr -k2,2nr -k3,3nr |
      sed 's/^/v/'
  )
fi

newest_release_matching() {
  local template_path="$1"
  local project_file="$TARGET/$2"
  local tag
  if [[ "${#RELEASES[@]}" -eq 0 || ! -f "$project_file" ]]; then
    return 1
  fi
  for tag in "${RELEASES[@]}"; do
    if git -C "$ROOT_DIR" cat-file -e "$tag:$template_path" 2>/dev/null &&
      git -C "$ROOT_DIR" show "$tag:$template_path" 2>/dev/null | cmp -s - "$project_file"; then
      printf '%s\n' "$tag"
      return 0
    fi
  done
  return 1
}

# A release matches when every canonical file that release shipped is present in
# the project and byte-identical to it.
release_fully_matches() {
  local tag="$1"
  local template_path project_file compared=0
  while IFS= read -r template_path; do
    is_installed_payload "$template_path" || continue
    project_file="$(project_path_of "$template_path")"
    [[ -n "$project_file" ]] || continue
    is_project_local "$project_file" && continue
    compared=$((compared + 1))
    [[ -f "$TARGET/$project_file" ]] || return 1
    git -C "$ROOT_DIR" show "$tag:$template_path" | cmp -s - "$TARGET/$project_file" || return 1
  done < <(git -C "$ROOT_DIR" ls-tree -r --name-only "$tag" -- "${PAYLOAD_ROOTS[@]}" 2>/dev/null)
  [[ "$compared" -gt 0 ]]
}

CANONICAL_REPORT=""
LOCAL_REPORT=""
EQUAL_COUNT=0
DIFFERS_COUNT=0
MISSING_COUNT=0

while IFS= read -r absolute_path; do
  template_path="${absolute_path#"$ROOT_DIR"/}"
  is_installed_payload "$template_path" || continue
  project_file="$(project_path_of "$template_path")"
  [[ -n "$project_file" ]] || continue

  if [[ ! -e "$TARGET/$project_file" ]]; then
    state="missing"
  elif cmp -s "$absolute_path" "$TARGET/$project_file"; then
    state="equal"
  else
    state="differs"
  fi

  if is_project_local "$project_file"; then
    LOCAL_REPORT="${LOCAL_REPORT}$(printf '%s: %s' "$project_file" "$state")
"
    continue
  fi

  case "$state" in
    equal) EQUAL_COUNT=$((EQUAL_COUNT + 1)) ;;
    missing) MISSING_COUNT=$((MISSING_COUNT + 1)) ;;
    differs)
      DIFFERS_COUNT=$((DIFFERS_COUNT + 1))
      if matched_release="$(newest_release_matching "$template_path" "$project_file")"; then
        state="differs — matches $matched_release"
      else
        state="differs — matches no released template"
      fi
      ;;
  esac

  CANONICAL_REPORT="${CANONICAL_REPORT}$(printf '%s: %s' "$project_file" "$state")
"
done < <(
  for root in "${PAYLOAD_ROOTS[@]}"; do
    find "$ROOT_DIR/$root" -type f
  done | sort
)

CONTENT_LEVEL=""
if [[ "$DIFFERS_COUNT" -eq 0 && "$MISSING_COUNT" -eq 0 && "$EQUAL_COUNT" -gt 0 ]]; then
  CONTENT_LEVEL="$CURRENT_VERSION"
elif [[ "${#RELEASES[@]}" -gt 0 ]]; then
  for tag in "${RELEASES[@]}"; do
    if release_fully_matches "$tag"; then
      CONTENT_LEVEL="${tag#v}"
      break
    fi
  done
fi

echo "Workframe checkout: $ROOT_DIR"
echo "Project: $TARGET"
echo "Applied version (marker): $PROJECT_VERSION"
if [[ -n "$CONTENT_LEVEL" ]]; then
  echo "Content level: $CONTENT_LEVEL"
else
  echo "Content level: mixed — no released template matches every canonical file"
fi
echo "Available version: $CURRENT_VERSION"
if [[ -z "$INSTALLED_MODULES" ]]; then
  echo "Modules: none (detected from files)"
else
  echo "Modules: $INSTALLED_MODULES (from $MODULES_SOURCE)"
fi
if [[ -n "$UNKNOWN_MODULES" ]]; then
  echo "Modules not present in this Workframe checkout, not compared: $UNKNOWN_MODULES"
fi
if [[ "${#RELEASES[@]}" -eq 0 ]]; then
  echo "Comparable releases: none tagged in this checkout"
else
  echo "Comparable releases: ${RELEASES[*]}"
fi

if [[ -n "$CONTENT_LEVEL" && "$CONTENT_LEVEL" != "$PROJECT_VERSION" ]]; then
  echo "Note: the marker records $PROJECT_VERSION, the installed content matches $CONTENT_LEVEL."
fi

if [[ "$PROJECT_VERSION" == "$CURRENT_VERSION" && "$CONTENT_LEVEL" == "$CURRENT_VERSION" ]]; then
  echo "Status: version and content match this Workframe checkout."
else
  echo "Status: review an upgrade before changing the project."
fi

NOTES_FROM="$PROJECT_VERSION"
NOTES_SOURCE="the version recorded in the marker"
if [[ -n "$CONTENT_LEVEL" ]]; then
  NOTES_FROM="$CONTENT_LEVEL"
  NOTES_SOURCE="the level of the installed content"
fi

echo
echo "Release notes to review (from $NOTES_FROM, $NOTES_SOURCE):"
awk -v target="$NOTES_FROM" '
  /^## [0-9]+\.[0-9]+\.[0-9]+/ {
    version = $2
    if (version == target) exit
    show = 1
  }
  show { print }
' "$ROOT_DIR/CHANGELOG.md"

echo
echo "Canonical files against the current template:"
printf '%s' "$CANONICAL_REPORT"
printf 'Summary: %s equal, %s differ, %s missing.\n' "$EQUAL_COUNT" "$DIFFERS_COUNT" "$MISSING_COUNT"

echo
echo "Project-local files, divergence expected:"
printf '%s' "$LOCAL_REPORT"

echo
echo "Next step: ask an agent to create project-local OpenSpec change upgrade-workframe-guidance,"
echo "review these differences, apply only relevant updates, and then update .project-workframe-version."
echo "A canonical file is copied whole, never restated; the change ends with every canonical file equal."
