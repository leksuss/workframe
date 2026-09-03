# instruction-budget Specification

## Purpose
TBD - created by archiving change optimize-instruction-budget. Update Purpose after archive.
## Requirements
### Requirement: Automatically loaded instructions имеют измеримый budget

Workframe MUST различать automatically loaded instruction entry points и on-demand canonical sources. Проверка MUST измерять entry points в raw UTF-8 bytes, MUST ограничивать каждый объявленный entry point абсолютным потолком и MUST выводить размеры так, чтобы изменение footprint было видно владельцу.

#### Scenario: Проверяется root governance

- **WHEN** запускается instruction-budget verification для Workframe
- **THEN** размер root `AGENTS.md` проверяется независимо от payload
- **AND** превышение объявленного потолка завершает проверку ошибкой

#### Scenario: Проверяется generated-project payload

- **WHEN** запускается instruction-budget verification
- **THEN** размеры `template/base/AGENTS.md` и client entry points проверяются как automatically loaded surfaces
- **AND** on-demand workflow documents не прибавляются к каждому entry point как будто они загружаются всегда

#### Scenario: Владелец оценивает экономию

- **WHEN** проверка завершается
- **THEN** она сообщает фактические размеры always-loaded и on-demand групп
- **AND** не выдаёт model-dependent token estimate за точное число tokens

### Requirement: Сокращение не удаляет обязательство

Automatically loaded entry point MUST содержать обязательные safety и routing invariants. Подробная процедура MAY находиться в on-demand canonical source только если entry point называет точный trigger и путь, а shipped verification проверяет этот address.

Если агент не уверен, применяется ли trigger, entry point MUST требовать считать trigger применимым и загрузить адресованные инструкции до действия.

#### Scenario: Запрос не требует проектного workflow

- **WHEN** агент выполняет простой запрос, не активирующий planning, implementation, review, reconcile или audit
- **THEN** его always-loaded project context не содержит полные процедуры этих workflows

#### Scenario: Запрос активирует workflow

- **WHEN** работа достигает trigger, названного в entry point
- **THEN** агент обязан прочитать соответствующий canonical source полностью до действий этого workflow
- **AND** получает те же normative obligations, которые были вынесены из entry point

#### Scenario: Entry point сокращён без address

- **WHEN** обязательная процедура удалена из entry point, но её trigger или canonical path отсутствует
- **THEN** verification завершается ошибкой

#### Scenario: Применимость trigger неоднозначна

- **WHEN** агент не уверен, относится ли запрос к named workflow trigger
- **THEN** он считает trigger применимым
- **AND** читает адресованный canonical source до действия

