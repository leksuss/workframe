# Workframe

Русская версия: [README.ru.md](README.ru.md).

Workframe is reusable operating scaffolding for software projects built with AI agents. It is not an application framework or a commitment to one model provider. It keeps product decisions, change process, and verification rules in the repository so work can continue across AI clients.

## Who It Is For And What It Solves

Workframe is for a technical owner starting or maintaining a project with AI agents.

It helps them:

- start from deliberate product decisions instead of a first random prompt;
- hand one task between agents and use another agent for review;
- preserve values, boundaries, and agreed decisions when changing chats or providers;
- discuss non-trivial changes before implementation and verify their result afterward.

You speak to the agent in ordinary language. The agent explores, records confirmed decisions, proposes the next step, and follows repository rules. You make product decisions and approve implementation.

## Supported AI Clients

Base Workframe rules are available to any agent that can read project files. Tested automatic adapters are available for Codex, Cursor, Claude Code, Qwen Code, and Kimi Code.

Codex, Claude Code, Qwen Code, and Kimi Code also receive shared OpenSpec workflows. Cursor automatically reads `AGENTS.md` and follows common rules; it can read the same workflows from `.agents/skills/` when needed.

A model and an AI client are different things. DeepSeek, GLM, or another model follows the same workflow when it runs through a supported client. For an unlisted client, configure its project instructions to read `AGENTS.md` and `docs/AGENT_WORKFLOW.md`; if it supports skills, point it to `.agents/skills/`.

Several agents can be used on the same project, but handoffs must be sequential: wait for one agent to finish its work before letting another change the same worktree. This makes it safe to alternate providers when limits run out or obtain a cross-client review without conflicting edits.

## Start A New Project

Create an empty project directory and Git repository, then apply Workframe:

```bash
mkdir /path/to/my-project
git init /path/to/my-project

/path/to/workframe/scripts/init-project.sh \
  --target /path/to/my-project
```

Add optional modules only when useful:

```bash
/path/to/workframe/scripts/init-project.sh \
  --target /path/to/my-project \
  --with design-pencil \
  --with frontend-quality
```

The script copies the scaffold into an existing directory and can overwrite same-named files. Review the result and make the initial commit.

## Typical Development Flow

1. Open the project folder in your preferred AI client.
2. Describe the idea: “I want to build …”. Ask the agent not to implement yet and to explore users, their problems, value, boundaries, and anti-goals.
3. The agent leads the conversation and, after your confirmation, records product decisions in the project constitution.
4. The agent proactively offers to prepare the first OpenSpec change: what changes, why, how it works, and its work plan.
5. Review the plan. The agent implements only after your explicit approval.
6. When switching clients, the incoming agent reads the rules, Git status, and OpenSpec state before continuing. Another agent can use the same state for review.

An example first message:

> I want to build a service for … Do not implement yet. Help me understand who it is for, the problem it solves, its value, and what it should not do.

## What Stays In The Project

`init-project.sh` already copies every required item. You do not need to copy anything below manually after running it.

| Area | Purpose |
| --- | --- |
| `AGENTS.md` | Common mandatory AI-agent rules and safe session handoff. |
| `CLAUDE.md` | Claude Code entry point to the same common rules. |
| `docs/CONCEPTS.md` | Product constitution: value, audience, principles, and boundaries. |
| `docs/AGENT_WORKFLOW.md` | Neutral process from idea to verification. |
| `docs/QUALITY.md` and `docs/checklists/` | Contract for project verification. |
| `docs/DEBT.md` | Durable register of divergences and deferred work that outlives an archived change. |
| `openspec/` | OpenSpec configuration for intentional non-trivial changes. |
| `.agents/skills/` | Canonical project workflows: OpenSpec and the coherence audit. |
| `.codex/skills/`, `.claude/skills/`, `.qwen/skills/` | Client entry points to those same workflows. |

`template/` contains this payload. `source/` explains neutral rules and client adapters; `examples/` shows adaptation patterns. Neither is normally copied into a new project.

## Optional Modules

- `design-pencil` — for projects using Pencil, design artifacts, or taste references.
- `frontend-quality` — for a frontend-heavy project.

Design discipline is always available. If Pencil MCP is unavailable, the agent does not edit `.pen` files and instead works from exports, documented decisions, or asks for the required environment.

## Change Rules

Tiny edits can be made directly. Features, behavior changes, integrations, material refactors, contract changes, and redesigns use OpenSpec.

One OpenSpec change maps to one Git branch. OpenSpec artifacts are Russian by default, while technical identifiers stay English where clearer. When a technology surface appears or changes materially, that same change derives the smallest useful quality pipeline and updates `docs/QUALITY.md`.

A long series of changes drifts even when every single change was correct. Before proposing archive, the agent reconciles the artifacts that change touched: no leftover placeholders, no references to removed entities, and unfinished deferred work moved into `docs/DEBT.md` rather than archived away with the change. A full-repository coherence audit runs only when you ask for it, as an ordinary reviewable change. The agent repairs objectively broken things itself and records contradictions for your decision instead of resolving them.

Workframe never auto-updates older projects. An upgrade is a separate, reviewable change inside the project. See [docs/UPGRADING.md](docs/UPGRADING.md).

## Workframe Repository Layout

```text
workframe/
├─ template/base/            # required new-project payload
├─ template/modules/         # optional payload modules
├─ source/canonical-rules/   # neutral source rules
├─ source/adapters/          # client-specific notes
├─ examples/                 # examples, not payload
├─ docs/                     # Workframe documentation
└─ openspec/                 # Workframe's own changes
```

Workframe itself evolves through its root `AGENTS.md`, `docs/CONCEPTS.md`, and `openspec/`; do not confuse those with generated-project files under `template/`.
