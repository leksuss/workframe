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

probe_root_address() {
  require_phrase "$1" "source/canonical-rules/verification.md"
  require_phrase "$1" "Before designing non-atomic tasks"
}

probe_payload_address() {
  require_phrase "$1" "docs/AGENT_WORKFLOW.md"
  require_phrase "$1" "docs/QUALITY.md"
  require_phrase "$1" "docs/checklists/feature-change.md"
}

# The executable-evidence methods, probed by the clause that carries their
# countable requirement. A synonym is not a substitute: each phrase names what a
# reviewer counts, so losing it loses the method.
probe_methods_file() {
  require_phrase "$1" "one hostile case per field"
  require_phrase "$1" "must cite an executed probe"
  require_phrase "$1" "not an adversarial pass"
}

probe_execution_methods_file() {
  require_phrase "$1" "not reasoning about control flow"
  require_phrase "$1" "failing with its guard removed"
}

if [[ "${1:-}" == "--probe-root-address" ]]; then
  probe_root_address "${2:-}"
  exit
fi

if [[ "${1:-}" == "--probe-payload-address" ]]; then
  probe_payload_address "${2:-}"
  exit
fi

if [[ "${1:-}" == "--probe-methods" ]]; then
  probe_methods_file "${2:-}"
  exit
fi

if [[ "${1:-}" == "--probe-execution-methods" ]]; then
  probe_execution_methods_file "${2:-}"
  exit
fi

TEMP_ROOT="$(mktemp -d)"
cleanup() {
  rm -rf "$TEMP_ROOT"
}
trap cleanup EXIT

if [[ "${1:-}" == "--self-test" ]]; then
  mutated="$TEMP_ROOT/root-address.md"
  sed 's#source/canonical-rules/verification.md#source/canonical-rules/missing.md#g' "$WORKFRAME_ROOT/AGENTS.md" > "$mutated"
  if "$0" --probe-root-address "$mutated" >/dev/null 2>&1; then
    echo "Missing root verification address unexpectedly passed." >&2
    exit 1
  fi

  mutated="$TEMP_ROOT/payload-address.md"
  sed 's#docs/AGENT_WORKFLOW.md#docs/MISSING_WORKFLOW.md#g' "$WORKFRAME_ROOT/template/base/AGENTS.md" > "$mutated"
  if "$0" --probe-payload-address "$mutated" >/dev/null 2>&1; then
    echo "Missing payload verification address unexpectedly passed." >&2
    exit 1
  fi
  echo "Negative address fixtures rejected."

  # Each method probe must reject the removal of its own clause. A probe that
  # survives its own mutation certifies nothing.
  method_mutations=(
    "$WORKFRAME_ROOT/source/canonical-rules/verification.md|--probe-methods|one hostile case per field|one plausible case"
    "$WORKFRAME_ROOT/source/canonical-rules/verification.md|--probe-methods|must cite an executed probe|is accepted from documented behavior"
    "$WORKFRAME_ROOT/source/canonical-rules/verification.md|--probe-methods|not an adversarial pass|an adversarial pass"
    "$WORKFRAME_ROOT/template/base/docs/AGENT_WORKFLOW.md|--probe-execution-methods|not reasoning about control flow|accepted from control-flow reasoning"
    "$WORKFRAME_ROOT/template/base/docs/AGENT_WORKFLOW.md|--probe-execution-methods|failing with its guard removed|passing with its guard removed"
  )
  for mutation in "${method_mutations[@]}"; do
    IFS='|' read -r source probe phrase replacement <<< "$mutation"
    mutated="$TEMP_ROOT/AGENTS-method.md"
    sed "s/$phrase/$replacement/g" "$source" > "$mutated"
    if "$0" "$probe" "$mutated" >/dev/null 2>&1; then
      echo "Method mutation unexpectedly passed probing: $phrase" >&2
      exit 1
    fi
  done
  echo "Negative method fixtures rejected."
  exit
fi

if [[ $# -gt 0 ]]; then
  echo "Usage: scripts/verify-contract-driven-workflow.sh [--self-test]" >&2
  exit 1
fi

# Contract presence and acceptance-scenario vocabulary. These checks prove that
# the shipped surfaces carry the agreed gates; they do not replace semantic review.
probe_root_address "$WORKFRAME_ROOT/AGENTS.md"
probe_payload_address "$WORKFRAME_ROOT/template/base/AGENTS.md"
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

# Executable-evidence methods, per surface. Each phrase turns a judgment about
# completeness into something a reviewer can count without knowing the system.
for surface in \
  "$WORKFRAME_ROOT/template/base/docs/AGENT_WORKFLOW.md" \
  "$WORKFRAME_ROOT/source/canonical-rules/verification.md"; do
  probe_methods_file "$surface"
done
for surface in \
  "$WORKFRAME_ROOT/template/base/docs/AGENT_WORKFLOW.md" \
  "$WORKFRAME_ROOT/template/base/docs/checklists/feature-change.md" \
  "$WORKFRAME_ROOT/template/base/docs/checklists/release-readiness.md" \
  "$WORKFRAME_ROOT/source/canonical-rules/verification.md"; do
  probe_execution_methods_file "$surface"
done
require_phrase "$WORKFRAME_ROOT/template/base/docs/checklists/feature-change.md" "one hostile case per field"
require_phrase "$WORKFRAME_ROOT/template/base/docs/checklists/feature-change.md" "not an adversarial pass"
require_phrase "$WORKFRAME_ROOT/template/base/docs/checklists/release-readiness.md" "one hostile case per field"
require_phrase "$WORKFRAME_ROOT/template/base/docs/checklists/release-readiness.md" "not an adversarial pass"
apply_skill="$WORKFRAME_ROOT/template/modules/agent-skills/.agents/skills/openspec-apply-change/SKILL.md"
require_phrase "$apply_skill" "not reasoning about control flow"
require_phrase "$apply_skill" "failing with its guard removed"
require_phrase "$apply_skill" "must cite an executed probe"
require_phrase "$apply_skill" "not an adversarial pass"
require_phrase "$WORKFRAME_ROOT/template/modules/agent-skills/.agents/skills/openspec-propose/SKILL.md" "one hostile case per field"
require_phrase "$WORKFRAME_ROOT/template/modules/agent-skills/.agents/skills/openspec-archive-change/SKILL.md" "instead of executing hostile inputs and naming what was run"

"$WORKFRAME_ROOT/scripts/verify-agent-adapters.sh" >/dev/null
"$WORKFRAME_ROOT/scripts/verify-instruction-budget.sh" >/dev/null

# Fresh installation must deliver the universal skill plus thin client adapters
# and every addressed checklist used by the contract.
fresh_target="$TEMP_ROOT/fresh"
mkdir -p "$fresh_target"
"$WORKFRAME_ROOT/scripts/init-project.sh" --target "$fresh_target" >/dev/null
probe_payload_address "$fresh_target/AGENTS.md"
require_phrase "$fresh_target/docs/AGENT_WORKFLOW.md" "requirement → production ownership path"
require_phrase "$fresh_target/.agents/skills/openspec-apply-change/SKILL.md" "Verify contract traceability"
probe_methods_file "$fresh_target/docs/AGENT_WORKFLOW.md"
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
