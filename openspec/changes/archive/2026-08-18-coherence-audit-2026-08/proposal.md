## Why

Первый прогон аудита согласованности после введения coherence lifecycle. Он служит приёмочной проверкой самих правил: если процедура не находит дефекты, известные заранее, правила надо переделывать до того, как проекты начнут на них полагаться.

Заранее известные дефекты — незаполненный `Purpose` в двух спеках и неверный заголовок списка файлов в `docs/UPGRADING.md`. Оба обнаружены. Кроме них найдено пять расхождений, о которых заранее известно не было.

## What Changes

Устраняются находки класса `mechanical`:

- Заполнен `Purpose` в `openspec/specs/agent-sequencing/spec.md` и `openspec/specs/workframe-governance/spec.md`.
- В `docs/UPGRADING.md` список файлов разделён на устанавливаемые всегда и приходящие с опциональными модулями; добавлена пропущенная строка адаптеров Codex.
- В `template/base/docs/checklists/coherence-audit.md` добавлено исключение для намеренно незаполненной quality policy, которую payload поставляет по требованию спеки `verification-lifecycle`.

Фиксируются без исправления находки классов `semantic` и `structural`: записи `D-002`–`D-005` в `docs/DEBT.md`.

## Capabilities

### Modified Capabilities

- `coherence-lifecycle`: аудит не считает находкой состояние, которого действующая спека или policy требует намеренно.

Прогон обнаружил, что это правило нигде не записано: срез placeholder повторно указывал на `pending stack selection` в `docs/QUALITY.md`, хотя спека `verification-lifecycle` прямо требует поставлять payload именно в таком виде. Остальные находки не меняют требований.

## Impact

- `openspec/specs/agent-sequencing/spec.md`, `openspec/specs/workframe-governance/spec.md` — заполнение Purpose.
- `docs/UPGRADING.md`, `template/base/docs/checklists/coherence-audit.md` — исправление неверных утверждений.
- `docs/DEBT.md` — четыре новые записи.
- Код, скрипты и поведение init не изменяются.
