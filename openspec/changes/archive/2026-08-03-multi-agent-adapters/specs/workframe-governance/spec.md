## MODIFIED Requirements

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
