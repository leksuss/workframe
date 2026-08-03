## Why

Workframe декларирует provider-neutral workflow, но готовый исполняемый adapter есть только для Codex. Владельцу проекта неудобно последовательно работать в нескольких AI-средах: правила могут не подхватываться автоматически или расходиться между средами.

## What Changes

- Добавить в payload адаптеры для распространённых AI coding agents, которые автоматически ссылаются на единый нейтральный workflow проекта.
- Сделать `AGENTS.md` и `docs/AGENT_WORKFLOW.md` каноническими общими правилами; adapters не должны создавать независимые копии процесса.
- Включить переносимые OpenSpec workflows и client adapters в каждый новый project scaffold.
- Обновить init script, README на русском и английском, adapters и upgrade guide: они должны описывать фактический путь владельца от идеи к первому change и смешанное последовательное использование агентов.
- Добавить проверку, подтверждающую, что scaffold содержит и согласованно устанавливает adapters.

## Capabilities

### New Capabilities

- `multi-agent-workflow-adapters`: единый workflow проекта доступен через поддерживаемые AI-client instruction formats без дублирования правил.
- `owner-led-project-start`: документация описывает действия владельца проекта, а агент заполняет и применяет рабочие документы после обсуждения и подтверждения решений.

### Modified Capabilities

- `workframe-governance`: generated payload и upgrade guidance учитывают adapters для нескольких AI-сред.

## Impact

- Затрагиваются `template/base/`, `template/modules/`, `scripts/init-project.sh`, `README.md`, `README.ru.md`, `docs/UPGRADING.md`, `source/adapters/` и OpenSpec specs.
- Не требуется новый runtime или внешняя зависимость; адаптеры являются текстовыми project files и входят в базовую инициализацию.
