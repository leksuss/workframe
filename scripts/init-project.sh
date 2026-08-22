#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKFRAME_VERSION="$(< "$ROOT_DIR/VERSION")"

if [[ ! "$WORKFRAME_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid Workframe version in $ROOT_DIR/VERSION: $WORKFRAME_VERSION" >&2
  exit 1
fi

usage() {
  cat <<'USAGE'
Usage:
  scripts/init-project.sh --target /path/to/project [--with design-pencil] [--with frontend-quality]

Examples:
  scripts/init-project.sh --target ../new-bot
  scripts/init-project.sh --target ../web-app --with design-pencil --with frontend-quality

Notes:
  - The target directory must already exist.
  - Files are copied with cp -R and may overwrite files with the same names.
  - Review the result before committing.
USAGE
}

TARGET=""
MODULES=()
MODULE_COUNT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:-}"
      shift 2
      ;;
    --with)
      MODULES+=("${2:-}")
      MODULE_COUNT=$((MODULE_COUNT + 1))
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "Missing --target" >&2
  usage
  exit 1
fi

if [[ ! -d "$TARGET" ]]; then
  echo "Target directory does not exist: $TARGET" >&2
  exit 1
fi

cp -R "$ROOT_DIR/template/base/." "$TARGET/"
# Copy the module payload only. The module README documents the module for whoever
# applies Workframe; it is not part of a generated project.
for payload_dir in .agents .claude .codex .qwen; do
  cp -R "$ROOT_DIR/template/modules/agent-skills/$payload_dir" "$TARGET/"
done

if [[ "$MODULE_COUNT" -gt 0 ]]; then
  for module in "${MODULES[@]}"; do
    case "$module" in
      design-pencil)
        cp -R "$ROOT_DIR/template/modules/$module/.codex" "$TARGET/"
        ;;
      frontend-quality)
        cp -R "$ROOT_DIR/template/modules/$module/docs/." "$TARGET/docs/"
        ;;
      *)
        echo "Unknown module: $module" >&2
        exit 1
        ;;
    esac
  done
fi

if [[ -f "$TARGET/.project-workframe-version" ]]; then
  sed -i.bak "s/workframe: VERSION/workframe: $WORKFRAME_VERSION/" "$TARGET/.project-workframe-version"
  rm -f "$TARGET/.project-workframe-version.bak"
fi

if command -v date >/dev/null 2>&1; then
  applied_at="$(date +%Y-%m-%d)"
  if [[ -f "$TARGET/.project-workframe-version" ]]; then
    sed -i.bak "s/applied-at: YYYY-MM-DD/applied-at: $applied_at/" "$TARGET/.project-workframe-version"
    rm -f "$TARGET/.project-workframe-version.bak"
  fi
fi

echo "Workframe scaffold applied to: $TARGET"
echo "Next: open the project in an AI agent, discuss the product idea, and ask it to record confirmed decisions in docs/CONCEPTS.md."
