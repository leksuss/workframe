# Generic Agent Adapter

For AI tools without a dedicated adapter, use:

- `AGENTS.md` for operating rules.
- `docs/AGENT_WORKFLOW.md` for neutral process guidance.
- `docs/checklists/` for repeatable verification.

If the tool supports its own instruction filename, point it to `AGENTS.md` and `docs/AGENT_WORKFLOW.md` without copying their rules. If it supports skills, add a thin adapter that directs the agent to the canonical `.agents/skills/` workflow. Do not duplicate full workflow text.

This adapter is model-neutral. A model such as DeepSeek or GLM receives the same project instructions through the client that hosts it.
