#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS=(openspec-explore openspec-propose openspec-apply-change openspec-archive-change coherence-audit)

# An adapter carries frontmatter plus one instruction to read the canonical file.
# A canonical skill carries the full procedure. The gap between them is large, so a
# generous threshold separates the two without depending on any skill's wording.
MAX_ADAPTER_LINES=20

for skill in "${SKILLS[@]}"; do
  canonical="$ROOT_DIR/template/modules/agent-skills/.agents/skills/$skill/SKILL.md"
  test -f "$canonical"

  canonical_lines="$(wc -l < "$canonical")"
  if [[ "$canonical_lines" -le "$MAX_ADAPTER_LINES" ]]; then
    echo "Canonical skill $skill is only $canonical_lines lines; the adapter check would be meaningless." >&2
    exit 1
  fi

  for client in .codex .claude .qwen; do
    adapter="$ROOT_DIR/template/modules/agent-skills/$client/skills/$skill/SKILL.md"
    test -f "$adapter"
    grep -qF ".agents/skills/$skill/SKILL.md" "$adapter"

    adapter_lines="$(wc -l < "$adapter")"
    if [[ "$adapter_lines" -gt "$MAX_ADAPTER_LINES" ]]; then
      echo "Adapter $client/$skill is $adapter_lines lines; it should reference the canonical workflow, not restate it." >&2
      exit 1
    fi
  done
done

target="$(mktemp -d)"
"$ROOT_DIR/scripts/init-project.sh" --target "$target" >/dev/null
for skill in "${SKILLS[@]}"; do
  test -f "$target/.agents/skills/$skill/SKILL.md"
  test -f "$target/.codex/skills/$skill/SKILL.md"
  test -f "$target/.claude/skills/$skill/SKILL.md"
  test -f "$target/.qwen/skills/$skill/SKILL.md"
done
rm -rf "$target"

echo "Agent adapters verified."
