## ADDED Requirements

### Requirement: Contract reconcile перед archive
Сверка перед archive MUST включать traceability requirements/tasks к production paths и verification results, проверку final diff/evidence без доверия checkbox и классификацию найденных mechanical, semantic и structural findings.

#### Scenario: Task claim не подтверждён evidence
- **WHEN** reconcile находит завершённую задачу без заявленного verification result
- **THEN** task и change не считаются готовыми к archive

#### Scenario: Spec и implementation расходятся
- **WHEN** contract reconcile обнаруживает, что test доказывает другой outcome либо production bypass не соответствует spec
- **THEN** расхождение классифицируется по действующей coherence policy
- **AND** не устраняется молчаливым изменением spec или code

## MODIFIED Requirements

### Requirement: Сверка перед архивацией

Workframe MUST требовать сверку согласованности до предложения archive. Область сверки ограничена артефактами, которых касался текущий change. Project rules и release-readiness checklist MUST оставаться полным источником шагов, а canonical Workframe skills MAY обеспечивать входные и выходные gates без дублирования всего checklist.

#### Scenario: Change готов к архивации

- **WHEN** реализация change завершена и агент готовится предложить archive
- **THEN** агент проверяет traceability tasks/requirements к production paths и recorded results, независимо перечитывает final diff/evidence, убеждается, что спеки описывают итоговое поведение, что в созданных и изменённых артефактах нет placeholder и что удалённые сущности вычищены из упоминаний
- **AND** предлагает archive только после устранения найденных `mechanical`-находок и регистрации `semantic`/`structural` findings

#### Scenario: Change оставил незакрытые отложенные улучшения

- **WHEN** секция `## Фаза 2. Углубление` активного change содержит невыполненные пункты
- **THEN** агент переносит их в постоянный реестр расхождений до архивации
- **AND** не допускает их архивации как единственного места хранения

#### Scenario: Canonical skill обеспечивает gate

- **WHEN** Workframe поставляет canonical propose/apply/archive skill
- **THEN** skill MAY проверять task evidence и archive readiness и направляет агента к project rules/checklist
- **AND** не дублирует полный reconcile checklist и не требует ручной правки third-party cache или generated copies
