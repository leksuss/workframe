# workframe-governance Specification

## Purpose

Описывает self-governance Workframe как самостоятельного проекта и правила разделения root governance files от payload, который копируется в target projects.

## ADDED Requirements

### Requirement: Root Governance

Workframe MUST provide root governance files for work on the Workframe repository itself.

#### Scenario: Agent works on Workframe

- **WHEN** AI agent работает в репозитории Workframe
- **THEN** agent следует root `AGENTS.md`, а не `template/base/AGENTS.md`

#### Scenario: Agent evaluates non-trivial Workframe change

- **WHEN** change влияет на Workframe behavior, generated payload, optional modules, adapters, profiles, examples или upgrade policy
- **THEN** agent читает `docs/CONCEPTS.md` и оценивает соответствие Workframe purpose, principles, anti-goals и feature fit criteria

### Requirement: Root OpenSpec

Workframe MUST use a root `openspec/` directory for its own future non-trivial changes.

#### Scenario: Workframe change starts

- **WHEN** owner начинает non-trivial Workframe change после bootstrap governance
- **THEN** change создается в root `openspec/changes/<change-id>/`
- **AND** работа ведется на matching branch `feature/<change-id>`

#### Scenario: Template OpenSpec payload exists

- **WHEN** agent видит `template/base/openspec/`
- **THEN** agent treats it as generated project payload
- **AND** agent does not use it as the active OpenSpec directory for Workframe repo changes

### Requirement: Root And Template Boundary

Workframe MUST keep repository governance files separate from files copied into target projects.

#### Scenario: Root agent rule changes

- **WHEN** change affects how agents work on Workframe itself
- **THEN** agent updates root `AGENTS.md`
- **AND** agent updates `template/base/AGENTS.md` only if generated project payload behavior should also change

#### Scenario: Generated project rule changes

- **WHEN** change affects rules copied into new projects
- **THEN** agent updates files under `template/base/` or `template/modules/`
- **AND** agent considers whether root docs, `source/`, README files, or `docs/UPGRADING.md` need updates

#### Scenario: Local Codex skills

- **WHEN** Workframe repo needs project-local Codex skills
- **THEN** root `.codex/skills/` contains skills for Workframe development
- **AND** `template/modules/codex-skills/.codex/skills/` remains the payload copied into target projects

### Requirement: Bootstrap Exception

Workframe MUST document that the initial scaffold existed before root OpenSpec governance.

#### Scenario: Reviewing initial history

- **WHEN** owner reviews Workframe history
- **THEN** initial scaffold commit is understood as a bootstrap exception
- **AND** `bootstrap-workframe-governance` is the transition point to normal Workframe self-governance

#### Scenario: Future changes after bootstrap

- **WHEN** bootstrap governance is complete
- **THEN** future non-trivial changes follow root OpenSpec workflow

### Requirement: Existing Project Stability

Workframe MUST NOT automatically update projects created from older versions.

#### Scenario: Workframe governance changes

- **WHEN** Workframe changes its root governance or generated payload
- **THEN** existing target projects remain unchanged
- **AND** upgrading a target project remains an explicit project-local change guided by `docs/UPGRADING.md`
