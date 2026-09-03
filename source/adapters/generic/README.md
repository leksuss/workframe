# Generic Agent Adapter

For AI tools without a dedicated adapter, use:

- `AGENTS.md` as the automatically loaded operating rules and workflow router.
- `docs/AGENT_WORKFLOW.md` when `AGENTS.md` triggers non-trivial change work.
- `docs/checklists/` at the triggers named in `AGENTS.md`.

If the tool supports its own instruction filename, point it to `AGENTS.md`; do not automatically include every on-demand document. If it supports skills, add a thin adapter that directs the agent to the canonical `.agents/skills/` workflow. Do not duplicate full workflow text.

This adapter is model-neutral. A model such as DeepSeek or GLM receives the same project instructions through the client that hosts it.
