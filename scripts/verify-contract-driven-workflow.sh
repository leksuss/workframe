#!/usr/bin/env bash
set -euo pipefail

WORKFRAME_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

require_phrase() {
  local file="$1"
  local phrase="$2"
  if ! grep -qF "$phrase" "$file"; then
    echo "Missing contract phrase in $file: $phrase" >&2
    return 1
  fi
}

probe_file() {
  require_phrase "$1" "Contract-Driven Verification"
}

if [[ "${1:-}" == "--probe-file" ]]; then
  probe_file "${2:-}"
  exit
fi

TEMP_ROOT="$(mktemp -d)"
cleanup() {
  rm -rf "$TEMP_ROOT"
}
trap cleanup EXIT

if [[ "${1:-}" == "--self-test" ]]; then
  mutated="$TEMP_ROOT/AGENTS.md"
  sed '/^## Contract-Driven Verification$/d' "$WORKFRAME_ROOT/template/base/AGENTS.md" > "$mutated"
  if "$0" --probe-file "$mutated" >/dev/null 2>&1; then
    echo "Negative mutation unexpectedly passed contract probing." >&2
    exit 1
  fi
  echo "Negative contract fixture rejected."
  exit
fi

if [[ $# -gt 0 ]]; then
  echo "Usage: scripts/verify-contract-driven-workflow.sh [--self-test]" >&2
  exit 1
fi

# Contract presence and acceptance-scenario vocabulary. These checks prove that
# the shipped surfaces carry the agreed gates; they do not replace semantic review.
require_phrase "$WORKFRAME_ROOT/AGENTS.md" "## Contract-Driven Verification"
require_phrase "$WORKFRAME_ROOT/template/base/AGENTS.md" "## Contract-Driven Verification"
require_phrase "$WORKFRAME_ROOT/template/base/AGENTS.md" "docs/checklists/feature-change.md"
require_phrase "$WORKFRAME_ROOT/template/base/AGENTS.md" "docs/checklists/release-readiness.md"
require_phrase "$WORKFRAME_ROOT/template/base/AGENTS.md" "docs/checklists/coherence-audit.md"
require_phrase "$WORKFRAME_ROOT/template/base/docs/AGENT_WORKFLOW.md" "requirement → production ownership path"
require_phrase "$WORKFRAME_ROOT/template/base/docs/QUALITY.md" "release/certification"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "required loopback"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "exact required outcome"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "direct API bypass"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "after full materialization"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "public defaults fail closed"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "independent verifier"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "capability allow-list"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "stalled dependency"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "exact tracked revision"
require_phrase "$WORKFRAME_ROOT/source/canonical-rules/verification.md" "does not erase the first failure"
require_phrase "$WORKFRAME_ROOT/template/base/docs/checklists/feature-change.md" "real production ownership path"
require_phrase "$WORKFRAME_ROOT/template/base/docs/checklists/release-readiness.md" "no tracked commit followed that evidence"
require_phrase "$WORKFRAME_ROOT/template/base/docs/checklists/coherence-audit.md" "Requirement traceability reaches the real production ownership path"
require_phrase "$WORKFRAME_ROOT/template/modules/agent-skills/.agents/skills/openspec-propose/SKILL.md" "Build the verification contract"
require_phrase "$WORKFRAME_ROOT/template/modules/agent-skills/.agents/skills/openspec-apply-change/SKILL.md" "Verify contract traceability"
require_phrase "$WORKFRAME_ROOT/template/modules/agent-skills/.agents/skills/openspec-archive-change/SKILL.md" "Check verification and review readiness"

"$WORKFRAME_ROOT/scripts/verify-agent-adapters.sh" >/dev/null

# Fresh installation must deliver the universal skill plus thin client adapters
# and every addressed checklist used by the contract.
fresh_target="$TEMP_ROOT/fresh"
mkdir -p "$fresh_target"
"$WORKFRAME_ROOT/scripts/init-project.sh" --target "$fresh_target" >/dev/null
require_phrase "$fresh_target/AGENTS.md" "## Contract-Driven Verification"
require_phrase "$fresh_target/docs/AGENT_WORKFLOW.md" "requirement → production ownership path"
require_phrase "$fresh_target/.agents/skills/openspec-apply-change/SKILL.md" "Verify contract traceability"
for client in .codex .claude .qwen; do
  require_phrase "$fresh_target/$client/skills/openspec-apply-change/SKILL.md" ".agents/skills/openspec-apply-change/SKILL.md"
done

# Model an existing project with local policy. The canonical upgrade procedure
# copies canonical files whole but skips project-owned documents and the marker.
upgrade_target="$TEMP_ROOT/upgrade"
owned_backup="$TEMP_ROOT/owned"
mkdir -p "$upgrade_target" "$owned_backup"
"$WORKFRAME_ROOT/scripts/init-project.sh" --target "$upgrade_target" >/dev/null
project_owned=(docs/CONCEPTS.md docs/QUALITY.md docs/DEBT.md docs/PROJECT_RULES.md)
for relative in "${project_owned[@]}"; do
  mkdir -p "$owned_backup/$(dirname "$relative")"
  printf 'project-owned fixture: %s\n' "$relative" > "$upgrade_target/$relative"
  cp "$upgrade_target/$relative" "$owned_backup/$relative"
done
printf '\nstale canonical fixture\n' >> "$upgrade_target/AGENTS.md"

while IFS= read -r template_file; do
  relative="${template_file#"$WORKFRAME_ROOT/template/base/"}"
  case "$relative" in
    .project-workframe-version|docs/CONCEPTS.md|docs/QUALITY.md|docs/DEBT.md|docs/PROJECT_RULES.md)
      continue
      ;;
  esac
  mkdir -p "$upgrade_target/$(dirname "$relative")"
  cp "$template_file" "$upgrade_target/$relative"
done < <(find "$WORKFRAME_ROOT/template/base" -type f | sort)

for payload_dir in .agents .claude .codex .qwen; do
  cp -R "$WORKFRAME_ROOT/template/modules/agent-skills/$payload_dir" "$upgrade_target/"
done

for relative in "${project_owned[@]}"; do
  cmp -s "$owned_backup/$relative" "$upgrade_target/$relative" || {
    echo "Upgrade overwrote project-owned document: $relative" >&2
    exit 1
  }
done

update_report="$("$WORKFRAME_ROOT/scripts/check-workframe-update.sh" --target "$upgrade_target")"
if ! grep -Eq '^Summary: [0-9]+ equal, 0 differ, 0 missing\.$' <<< "$update_report"; then
  echo "Upgrade fixture did not end with a consistent canonical payload." >&2
  printf '%s\n' "$update_report" >&2
  exit 1
fi
for relative in "${project_owned[@]}"; do
  if ! grep -qF "$relative: differs" <<< "$update_report"; then
    echo "Upgrade report did not separate project-owned document: $relative" >&2
    exit 1
  fi
done

echo "Contract-driven workflow verified."
