# Workframe

Reusable workflow scaffolding for AI-assisted projects.

Russian version: [README.ru.md](README.ru.md).

Workframe is not an application framework. It is a project operating frame: concepts, agent rules, OpenSpec workflow, design discipline, and upgrade policy that can be copied into a new software project and adapted to its domain.

## What It Is For

Use Workframe when starting or regularizing a project where AI agents will help with planning, implementation, design, review, or maintenance.

It is meant to work for different project shapes: Telegram bots, Django applications, scraping services, frontend apps, libraries, infrastructure tools, and similar software projects.

## Repository Layout

```text
workframe/
├─ README.md
├─ CHANGELOG.md
├─ template/
│  ├─ base/                  # files copied into every new project
│  └─ modules/               # optional payloads copied when needed
├─ source/
│  ├─ canonical-rules/       # neutral source-of-truth guidance
│  ├─ adapters/              # AI-client-specific projections
│  └─ profiles/              # project-type notes
└─ examples/                 # examples only; do not copy by default
```

The `template/` directory is the payload. The other directories explain, adapt, or demonstrate it.

## Quick Start

1. Create the new project repository.
2. Apply the base scaffold and selected modules.
3. Fill `docs/CONCEPTS.md` for the actual product.
4. Commit the initial workflow scaffold.
5. Start the first real product change through OpenSpec.

Example:

```bash
/path/to/workframe/scripts/init-project.sh \
  --target /path/to/new-project \
  --with codex-skills \
  --with design-pencil
```

You can also copy files manually if you prefer a slower, fully visible setup.

## What To Copy

Copy these into most new projects:

- `template/base/AGENTS.md`
- `template/base/docs/CONCEPTS.md`
- `template/base/docs/AGENT_WORKFLOW.md`
- `template/base/docs/checklists/`
- `template/base/openspec/config.yaml`
- `template/base/.project-workframe-version`

Copy optional modules only when they fit:

- `template/modules/codex-skills/` for Codex-specific local skills.
- `template/modules/design-pencil/` when the project uses design artifacts, Pencil, or taste references.
- `template/modules/frontend-quality/` for frontend-heavy projects.

When copying manually, copy the payload inside each module, not the module's own README:

- `template/modules/codex-skills/.codex/`
- `template/modules/design-pencil/.codex/`
- `template/modules/frontend-quality/docs/`

Do not copy these into new projects by default:

- `source/`
- `examples/`
- this repository's own `CHANGELOG.md`

## Core Rules

- `docs/CONCEPTS.md` is the project constitution when it exists.
- Non-trivial behavior changes, integrations, and refactors go through OpenSpec.
- OpenSpec artifacts are written in Russian by default.
- Technical identifiers, commands, filenames, branch names, API names, and code symbols stay in English where appropriate.
- One OpenSpec change maps to one git branch.
- Existing user changes are never reverted unless explicitly requested.
- Design workflow is available by default; Pencil MCP is optional and disabled unless the runtime provides it.

## Updating Existing Projects

Workframe does not auto-update projects that were created from older versions. Keep old projects stable.

To upgrade an existing project, create a normal OpenSpec change inside that project, compare its `.project-workframe-version` with this repository, apply the desired workflow changes, and commit the result in that project's history.

Detailed upgrade guide: [docs/UPGRADING.md](docs/UPGRADING.md).

## Version Marker

Each generated project should keep:

```text
.project-workframe-version
```

This file records which Workframe version was applied. It is intentionally simple so future upgrades can be reviewed manually.

## Design Layer

Workframe includes a design discipline by default, but does not require Pencil MCP to be available in every session.

If Pencil MCP is unavailable, agents must not edit `.pen` files. They may work from exported screenshots, documented design decisions, or ask the user to enable Pencil MCP in a refreshed session.

## Status

Initial extraction from a real project workflow. The first priority is clarity over automation. The included init script is intentionally small: it copies the base payload and selected modules, then leaves project-specific decisions to the owner.
