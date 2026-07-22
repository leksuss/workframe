## Why

Workframe требует только запускать «relevant checks», поэтому после выбора стека целевой проект может остаться без явной quality policy или получить случайный набор инструментов. Нужен stack-neutral текстовый lifecycle, который связывает технологические решения с проектированием и внедрением конкретного quality pipeline внутри OpenSpec change целевого проекта.

## What Changes

- Базовый payload получает универсальные инструкции по проектированию quality pipeline после выбора или существенного изменения стека.
- OpenSpec lifecycle целевого проекта требует описывать verification strategy и добавлять внедрение конкретных проверок в тот же change, который вводит соответствующую технологическую поверхность.
- Проект получает постоянный текстовый источник истины для текущих blocking, advisory и неприменимых проверок, их команд и условий запуска.
- Verification guidance описывает staged rollout, skipped checks, legacy baseline, monorepo/polyglot, generated code, spikes и другие случаи, где единый строгий gate неприменим.
- Archscope фиксируется только как пример advisory architecture analysis; Workframe не поставляет и не устанавливает конкретные quality tools.
- Root documentation и upgrade guidance объясняют, как новый lifecycle попадает в создаваемые и существующие проекты.
- Base-only smoke verification исправляет обнаруженный compatibility blocker init script при пустом списке optional modules.

## Capabilities

### New Capabilities

- `verification-lifecycle`: Stack-neutral контракт, по которому целевой проект выводит, внедряет, документирует и развивает конкретный quality pipeline через OpenSpec changes.

### Modified Capabilities

Нет.

## Impact

- Изменяется generated project payload в `template/base/`: agent workflow, checklists и постоянная project quality policy.
- Обновляются canonical rules в `source/`, README и `docs/UPGRADING.md`, объясняющие поведение payload.
- `scripts/init-project.sh` получает узкое исправление обработки пустого `MODULES` для документированного запуска без `--with`.
- Workframe остаётся набором текстов и shell-based copier: новые анализаторы, зависимости, CI-конфигурации и готовые code modules не добавляются.
- Существующие проекты не обновляются автоматически; adoption проходит через их собственный OpenSpec change.
