#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS=(openspec-explore openspec-propose openspec-apply-change openspec-archive-change)

for skill in "${SKILLS[@]}"; do
  canonical="$ROOT_DIR/template/modules/agent-skills/.agents/skills/$skill/SKILL.md"
  test -f "$canonical"

  for client in .codex .claude .qwen; do
    adapter="$ROOT_DIR/template/modules/agent-skills/$client/skills/$skill/SKILL.md"
    test -f "$adapter"
    grep -qF ".agents/skills/$skill/SKILL.md" "$adapter"
    ! grep -qF "Implement tasks from an OpenSpec change." "$adapter"
  done
done

target="$(mktemp -d)"
"$ROOT_DIR/scripts/init-project.sh" --target "$target" >/dev/null
test -f "$target/.agents/skills/openspec-explore/SKILL.md"
test -f "$target/.codex/skills/openspec-explore/SKILL.md"
test -f "$target/.claude/skills/openspec-explore/SKILL.md"
test -f "$target/.qwen/skills/openspec-explore/SKILL.md"
rm -rf "$target"

echo "Agent adapters verified."
