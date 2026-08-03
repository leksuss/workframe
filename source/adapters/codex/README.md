# Codex Adapter

Codex uses:

- `AGENTS.md` as the top-level instruction file.
- `.codex/skills/` for local project skills.

The canonical payload for Codex is:

- `template/base/AGENTS.md`
- `template/modules/agent-skills/.agents/skills/` for complete workflows
- `template/modules/agent-skills/.codex/skills/` for Codex discovery adapters
- optionally `template/modules/design-pencil/.codex/skills/design-orchestration/`

The base init script installs this payload by default. Keep Codex-specific discovery details here. Do not put Codex-only syntax in `docs/CONCEPTS.md`.
