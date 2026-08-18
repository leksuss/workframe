# Portable Agent Skills Module

This module is installed automatically by `init-project.sh`.

For a manual copy of the payload — this file is documentation and does not belong in a project:

```bash
cp -R /path/to/workframe/template/modules/agent-skills/.agents \
      /path/to/workframe/template/modules/agent-skills/.claude \
      /path/to/workframe/template/modules/agent-skills/.codex \
      /path/to/workframe/template/modules/agent-skills/.qwen \
      /path/to/project/
```

The complete project workflows live once in `.agents/skills/` — the OpenSpec workflows and the coherence audit. Codex, Claude Code and Qwen Code receive small discovery adapters that load those canonical instructions; Kimi Code discovers `.agents/skills/` directly. Cursor uses the common root `AGENTS.md` rules.

The module supports sequential handoff between clients, not simultaneous edits in one worktree. It requires the `openspec` CLI for the OpenSpec workflows; the coherence audit needs only the project checklist.
