# Claude Code Adapter

Claude Code loads `CLAUDE.md` as always-on project instructions and discovers project skills from `.claude/skills/`.

The short `CLAUDE.md` points Claude Code to always-loaded `AGENTS.md`; that file names when to load `docs/AGENT_WORKFLOW.md` and checklists. The `.claude/skills/` files installed by `agent-skills` are discovery adapters that load canonical `.agents/skills/` workflows.

Reference: https://code.claude.com/docs/en/slash-commands
