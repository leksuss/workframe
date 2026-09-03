## MODIFIED Requirements

### Requirement: Root Governance

Workframe MUST provide root governance files for work on the Workframe repository itself. Root `AGENTS.md` MUST keep always-loaded scope, safety and workflow-routing invariants, while detailed procedures MAY live in root canonical sources that `AGENTS.md` requires the agent to read at an exact trigger.

#### Scenario: Agent works on Workframe

- **WHEN** AI agent работает в репозитории Workframe
- **THEN** agent следует root `AGENTS.md`, а не `template/base/AGENTS.md`

#### Scenario: Agent evaluates non-trivial Workframe change

- **WHEN** change влияет на Workframe behavior, generated payload, optional modules, adapters, examples или upgrade policy
- **THEN** agent читает `docs/CONCEPTS.md` и оценивает соответствие Workframe purpose, principles, anti-goals и feature fit criteria
- **AND** до planning или implementation читает названные root canonical workflow sources

#### Scenario: Agent выполняет простой запрос

- **WHEN** запрос не достигает trigger подробного workflow
- **THEN** root `AGENTS.md` не заставляет загружать полные verification, coherence и sequencing procedures
- **AND** обязательные safety invariants продолжают действовать из always-loaded файла
