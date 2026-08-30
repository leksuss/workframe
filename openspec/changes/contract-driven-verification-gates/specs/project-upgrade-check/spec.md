## ADDED Requirements

### Requirement: Проверяемое сохранение project-owned документов при upgrade
Workframe MUST иметь automated fixture verification, которая применяет fresh payload и моделирует upgrade существующего проекта, подтверждая сохранение `docs/CONCEPTS.md`, `docs/QUALITY.md`, `docs/DEBT.md` и `docs/PROJECT_RULES.md`, а также консистентность canonical payload и generated client adapters.

#### Scenario: Existing fixture обновляется
- **WHEN** upgrade verification запускается на fixture с уникальным содержимым project-owned документов
- **THEN** после применения canonical upgrade procedure содержимое четырёх документов побайтово сохранено
- **AND** canonical payload совпадает с текущими templates

#### Scenario: Fresh installation проверяется
- **WHEN** выполняется blocking verification Workframe
- **THEN** fresh target содержит universal `.agents/skills/` и тонкие adapters поддерживаемых clients
- **AND** contract-driven rules и checklists адресованы и согласованы
