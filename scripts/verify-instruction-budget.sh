#!/usr/bin/env bash
set -euo pipefail

WORKFRAME_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAX_ROOT_BYTES=10000
MAX_PAYLOAD_BYTES=10000
MAX_CLAUDE_BYTES=1000

bytes() {
  wc -c < "$1" | tr -d ' '
}

require_phrase() {
  local file="$1"
  local phrase="$2"
  if ! grep -qF "$phrase" "$file"; then
    echo "Missing instruction address in $file: $phrase" >&2
    return 1
  fi
}

require_budget() {
  local file="$1"
  local limit="$2"
  local actual
  actual="$(bytes "$file")"
  if (( actual > limit )); then
    echo "Instruction budget exceeded: $file is $actual bytes; limit is $limit." >&2
    return 1
  fi
}

probe_root() {
  local file="$1"
  require_budget "$file" "$MAX_ROOT_BYTES"
  require_phrase "$file" "Load Detailed Rules Only At Their Trigger"
  require_phrase "$file" "source/canonical-rules/workflow.md"
  require_phrase "$file" "source/canonical-rules/verification.md"
  require_phrase "$file" "source/canonical-rules/coherence.md"
  require_phrase "$file" "Read each named file in full before the listed work"
  require_phrase "$file" "If unsure whether a trigger applies, treat it as applicable"
}

probe_payload() {
  local file="$1"
  require_budget "$file" "$MAX_PAYLOAD_BYTES"
  require_phrase "$file" "Load Detailed Rules Only At Their Trigger"
  require_phrase "$file" "docs/AGENT_WORKFLOW.md"
  require_phrase "$file" "docs/QUALITY.md"
  require_phrase "$file" "docs/checklists/feature-change.md"
  require_phrase "$file" "docs/checklists/release-readiness.md"
  require_phrase "$file" "docs/checklists/coherence-audit.md"
  require_phrase "$file" "docs/checklists/design-change.md"
  require_phrase "$file" "Read each named file in full before the listed work"
  require_phrase "$file" "If unsure whether a trigger applies, treat it as applicable"
}

probe_claude() {
  local file="$1"
  require_budget "$file" "$MAX_CLAUDE_BYTES"
  require_phrase "$file" "AGENTS.md"
  require_phrase "$file" "exact triggers"
}

sum_bytes() {
  local total=0
  local file
  for file in "$@"; do
    total=$((total + $(bytes "$file")))
  done
  printf '%s' "$total"
}

case "${1:-}" in
  --probe-root)
    probe_root "${2:-}"
    exit
    ;;
  --probe-payload)
    probe_payload "${2:-}"
    exit
    ;;
  --probe-claude)
    probe_claude "${2:-}"
    exit
    ;;
  --self-test)
    temp_root="$(mktemp -d)"
    trap 'rm -rf "$temp_root"' EXIT

    cp "$WORKFRAME_ROOT/AGENTS.md" "$temp_root/over-budget.md"
    dd if=/dev/zero bs=10001 count=1 2>/dev/null >> "$temp_root/over-budget.md"
    if "$0" --probe-root "$temp_root/over-budget.md" >/dev/null 2>&1; then
      echo "Over-budget fixture unexpectedly passed." >&2
      exit 1
    fi

    sed 's#docs/AGENT_WORKFLOW.md#docs/MISSING_WORKFLOW.md#g' \
      "$WORKFRAME_ROOT/template/base/AGENTS.md" > "$temp_root/missing-address.md"
    if "$0" --probe-payload "$temp_root/missing-address.md" >/dev/null 2>&1; then
      echo "Missing-address fixture unexpectedly passed." >&2
      exit 1
    fi

    echo "Instruction-budget hostile fixtures rejected."
    exit
    ;;
  "")
    ;;
  *)
    echo "Usage: scripts/verify-instruction-budget.sh [--self-test]" >&2
    exit 1
    ;;
esac

root_entry="$WORKFRAME_ROOT/AGENTS.md"
payload_entry="$WORKFRAME_ROOT/template/base/AGENTS.md"
claude_entry="$WORKFRAME_ROOT/template/base/CLAUDE.md"

probe_root "$root_entry"
probe_payload "$payload_entry"
probe_claude "$claude_entry"

root_on_demand=("$WORKFRAME_ROOT"/source/canonical-rules/*.md)
payload_on_demand=(
  "$WORKFRAME_ROOT/template/base/docs/AGENT_WORKFLOW.md"
  "$WORKFRAME_ROOT/template/base/docs/QUALITY.md"
  "$WORKFRAME_ROOT"/template/base/docs/checklists/*.md
)
canonical_skills=("$WORKFRAME_ROOT"/template/modules/agent-skills/.agents/skills/*/SKILL.md)

printf 'Always-loaded entry points (raw UTF-8 bytes):\n'
printf '  root AGENTS.md: %s / %s\n' "$(bytes "$root_entry")" "$MAX_ROOT_BYTES"
printf '  payload AGENTS.md: %s / %s\n' "$(bytes "$payload_entry")" "$MAX_PAYLOAD_BYTES"
printf '  payload CLAUDE.md: %s / %s\n' "$(bytes "$claude_entry")" "$MAX_CLAUDE_BYTES"
printf 'On-demand corpora (reported, not charged to every request):\n'
printf '  root canonical rules: %s\n' "$(sum_bytes "${root_on_demand[@]}")"
printf '  payload workflow/quality/checklists: %s\n' "$(sum_bytes "${payload_on_demand[@]}")"
printf '  canonical workflow skills: %s\n' "$(sum_bytes "${canonical_skills[@]}")"
echo "Instruction budget verified."
