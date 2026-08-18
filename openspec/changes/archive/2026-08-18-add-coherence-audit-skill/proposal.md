## Why

Change `add-coherence-lifecycle` ввёл правила аудита согласованности и чек-лист `docs/checklists/coherence-audit.md`, но не дал исполняемого workflow. Чек-лист описывает, что искать; он не описывает, как провести аудит целиком: с какого состояния начать, в каком порядке идти, что делать с находкой каждого класса, чем закончить.

Аудит — длинная многосрезовая процедура. Без пошагового сценария агент выполняет её каждый раз по-своему: пропускает срезы, смешивает классы находок, правит то, что правил не должен, и завершает работу без обновления реестра. Разброс результатов обесценивает саму идею периодической сверки.

Остальные workflow проекта уже решены этим способом: полный текст живёт один раз в `.agents/skills/`, а клиенты получают короткие discovery adapters. Аудит — того же класса задача.

Отдельно этот change закрывает запись `D-001` из `docs/DEBT.md`. Она указывает на `scripts/verify-agent-adapters.sh:15`, а change обязан править этот же файл, добавляя в него пятый skill. Оставить проверку сломанной, расширив её область, значит увеличить расхождение вместо его устранения.

## What Changes

- Добавить канонический workflow `.agents/skills/coherence-audit/SKILL.md`: порядок выполнения, обработка находок по классам, формат результата и условия остановки.
- Добавить discovery adapters для Codex, Claude Code и Qwen Code по существующей схеме.
- Расширить `scripts/verify-agent-adapters.sh` на новый skill и заменить нерабочую проверку дублирования инструкций на проверку, которая срабатывает для любого skill.
- Уточнить формулировки, утверждающие, что канонический каталог содержит только OpenSpec workflows: `template/modules/agent-skills/README.md` и `template/base/CLAUDE.md`.
- Закрыть `D-001` в `docs/DEBT.md` со ссылкой на этот change.

Не входит в этот change: первый реальный прогон аудита на репозитории Workframe — отдельный change `coherence-audit-2026-08`.

## Capabilities

### Modified Capabilities

- `coherence-lifecycle`: процедура аудита становится доступной как исполняемый workflow, при этом остаётся выполнимой по чек-листу в клиентах без поддержки skills.
- `multi-agent-workflow-adapters`: канонический каталог workflows содержит рабочие процессы проекта, а не исключительно OpenSpec workflows.

## Impact

- Payload: `template/modules/agent-skills/.agents/skills/coherence-audit/`, адаптеры в `.codex/`, `.claude/`, `.qwen/`, `template/modules/agent-skills/README.md`, `template/base/CLAUDE.md`.
- Проверка: `scripts/verify-agent-adapters.sh`.
- Реестр: `docs/DEBT.md`, запись `D-001` переходит в `resolved`.
- Новый runtime или внешняя зависимость не требуются.
