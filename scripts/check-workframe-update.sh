#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<'USAGE'
Usage: scripts/check-workframe-update.sh --target /path/to/project

Shows a read-only Workframe upgrade brief for an existing project.
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

echo "Workframe checkout: $ROOT_DIR"
echo "Project: $TARGET"
echo "Applied version: $PROJECT_VERSION"
echo "Available version: $CURRENT_VERSION"
echo "Modules: $PROJECT_MODULES"

if [[ "$PROJECT_VERSION" == "$CURRENT_VERSION" ]]; then
  echo "Status: version matches this Workframe checkout."
else
  echo "Status: review an upgrade before changing the project."
fi

echo
echo "Release notes to review:"
awk -v target="$PROJECT_VERSION" '
  /^## [0-9]+\.[0-9]+\.[0-9]+/ {
    version = $2
    if (version == target) exit
    show = 1
  }
  show { print }
' "$ROOT_DIR/CHANGELOG.md"

echo
echo "Base files for review:"
review_files=(
  "AGENTS.md"
  "docs/AGENT_WORKFLOW.md"
  "docs/QUALITY.md"
  "docs/DEBT.md"
  "docs/checklists/feature-change.md"
  "docs/checklists/design-change.md"
  "docs/checklists/release-readiness.md"
  "docs/checklists/coherence-audit.md"
  "openspec/config.yaml"
  ".project-workframe-version"
)

for relative_path in "${review_files[@]}"; do
  source_path="$ROOT_DIR/template/base/$relative_path"
  target_path="$TARGET/$relative_path"
  if [[ ! -e "$target_path" ]]; then
    state="missing"
  elif cmp -s "$source_path" "$target_path"; then
    state="matches template"
  else
    state="differs — review, do not overwrite automatically"
  fi
  printf '%s: %s\n' "$relative_path" "$state"
done

echo
echo "Next step: ask an agent to create project-local OpenSpec change upgrade-workframe-guidance,"
echo "review these differences, apply only relevant updates, and then update .project-workframe-version."
