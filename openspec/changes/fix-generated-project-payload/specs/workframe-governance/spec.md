## MODIFIED Requirements

### Requirement: Root Governance

Workframe MUST provide root governance files for work on the Workframe repository itself.

#### Scenario: Agent works on Workframe

- **WHEN** AI agent работает в репозитории Workframe
- **THEN** agent следует root `AGENTS.md`, а не `template/base/AGENTS.md`

#### Scenario: Agent evaluates non-trivial Workframe change

- **WHEN** change влияет на Workframe behavior, generated payload, optional modules, adapters, examples или upgrade policy
- **THEN** agent читает `docs/CONCEPTS.md` и оценивает соответствие Workframe purpose, principles, anti-goals и feature fit criteria

### Requirement: Root And Template Boundary

Workframe MUST keep repository governance files separate from files copied into target projects.

#### Scenario: Root agent rule changes

- **WHEN** change affects how agents work on Workframe itself
- **THEN** agent updates root `AGENTS.md`
- **AND** agent updates `template/base/AGENTS.md` only if generated project payload behavior should also change

#### Scenario: Generated project rule changes

- **WHEN** change affects rules copied into new projects
- **THEN** agent updates files under `template/base/` or `template/modules/`
- **AND** agent considers whether root docs, `source/`, README files, `docs/UPGRADING.md` or AI-client adapters need updates

#### Scenario: Local workflow skills

- **WHEN** Workframe repo needs project-local Codex skills
- **THEN** root `.codex/skills/` contains skills for Workframe development
- **AND** generated-project workflow skills remain in the canonical `template/modules/agent-skills/` payload and client-specific module directories only adapt their discovery

#### Scenario: Adaptation material for a project type

- **WHEN** an owner adapts Workframe to a particular kind of project
- **THEN** `examples/` is the single place holding that adaptation material
- **AND** it is documentation rather than payload copied into a new project
