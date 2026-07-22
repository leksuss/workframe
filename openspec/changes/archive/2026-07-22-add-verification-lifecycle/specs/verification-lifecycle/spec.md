## ADDED Requirements

### Requirement: Stack-neutral verification contract

Workframe MUST предоставлять текстовый verification contract и MUST NOT поставлять конкретные quality tools, их зависимости, конфигурации или CI pipeline как обязательную часть base payload.

#### Scenario: Новый проект получает base payload

- **WHEN** owner применяет Workframe к новому проекту
- **THEN** проект получает инструкции по проектированию и документированию quality pipeline
- **AND** ни один язык, framework, analyzer или CI provider не становится обязательным

### Requirement: Technology choice triggers pipeline design

Workframe MUST требовать оценку quality pipeline в OpenSpec change, который впервые вводит или существенно меняет исполняемый stack, component, runtime, storage, contract или deployment surface.

#### Scenario: Foundation change выбирает стек

- **WHEN** OpenSpec change целевого проекта фиксирует технологии первого исполняемого skeleton
- **THEN** design описывает surfaces, характерные риски и требуемые классы проверок
- **AND** tasks включают минимально достаточное внедрение конкретного pipeline для выбранного стека

#### Scenario: Обычное изменение не меняет technology surface

- **WHEN** change использует существующий стек и не создаёт новых quality risks или surfaces
- **THEN** change следует текущей project quality policy
- **AND** не обязан заново выбирать инструменты

### Requirement: Durable project quality policy

Generated project payload MUST содержать постоянный текстовый источник истины для актуальной quality policy, который целевой проект конкретизирует после выбора стека.

#### Scenario: Конкретный pipeline внедрён

- **WHEN** OpenSpec change добавляет или изменяет quality pipeline
- **THEN** project quality policy перечисляет применимые surfaces, checks, canonical commands, modes, triggers, prerequisites и exclusions
- **AND** OpenSpec artifacts сохраняют rationale и delta этого изменения

#### Scenario: Стек ещё не выбран

- **WHEN** Workframe только инициализирован и исполняемый стек ещё не определён
- **THEN** quality policy явно отмечает pipeline как pending stack selection
- **AND** не выдумывает инструменты заранее

### Requirement: Check modes and run results

Project quality policy MUST различать режим обязательности проверки и результат конкретного запуска.

#### Scenario: Check классифицируется

- **WHEN** проект добавляет проверку в quality policy
- **THEN** она классифицируется как `blocking`, `advisory` или `not applicable`

#### Scenario: Blocking check не выполнен

- **WHEN** blocking check получает результат `skipped` или `unavailable`
- **THEN** результат не считается автоматическим успехом
- **AND** причина и влияние на completion фиксируются явно

#### Scenario: Advisory analyzer сообщает findings

- **WHEN** advisory check возвращает findings
- **THEN** agent выполняет triage как `confirmed`, `false positive` или `deferred`
- **AND** подтверждённая проблема либо устраняется как blocker текущей цели, либо фиксируется как будущая работа

### Requirement: Proportional rollout and exceptional surfaces

Verification guidance MUST разрешать staged rollout и MUST требовать явного обращения с project shapes, для которых единый строгий pipeline создаёт ложный или непрактичный gate.

#### Scenario: Analyzer добавляется в legacy repository

- **WHEN** новый analyzer обнаруживает значительный существующий backlog
- **THEN** проект может использовать baseline, changed-scope enforcement или advisory rollout
- **AND** не обязан исправлять весь legacy в несвязанном change

#### Scenario: Проект является monorepo или polyglot system

- **WHEN** разные surfaces требуют разных инструментов
- **THEN** quality policy разделяет проверки по surfaces
- **AND** определяет агрегирующий entry point, если это практически оправдано

#### Scenario: Код generated, vendored или временный

- **WHEN** surface не должна проверяться обычными правилами
- **THEN** exclusions или временные пропуски документируются явно
- **AND** для spike указывается условие удаления либо перехода к постоянному pipeline

### Requirement: Layered verification lifecycle

Workframe MUST различать быстрые change-level проверки, полную release verification и periodic advisory audit там, где эти уровни применимы.

#### Scenario: Change готовится к завершению

- **WHEN** реализация OpenSpec change завершена
- **THEN** объявленные blocking checks запускаются или получают явно задокументированный non-passing result
- **AND** применимые advisory results проходят triage до предложения archive

#### Scenario: Architecture analyzer используется проектом

- **WHEN** проект выбирает эвристический architecture analyzer, такой как Archscope
- **THEN** он по умолчанию рассматривается как advisory до отдельного решения об ужесточении
- **AND** полный отчёт, пригодный для агентского анализа, имеет приоритет над более узким interchange artifact

### Requirement: Explicit adoption by existing projects

Workframe MUST NOT автоматически добавлять verification lifecycle в ранее созданные проекты.

#### Scenario: Existing project принимает новый lifecycle

- **WHEN** owner решает обновить существующий project payload
- **THEN** adoption оформляется через OpenSpec change этого проекта
- **AND** существующие project-specific rules, commands и CI сохраняются или изменяются только явно
