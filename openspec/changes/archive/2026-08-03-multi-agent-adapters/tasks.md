## Фаза 1. Каркас

## 1. Канонический модуль workflows

- [x] 1.1 Создать `template/modules/agent-skills/` с canonical `.agents/skills/openspec-*` и lightweight discovery adapters для Codex, Claude Code и Qwen Code; полные инструкции должны существовать только в `.agents/skills/`. Проверка: сравнение дерева подтверждает обязательные skills и adapters, а adapter ссылается на matching canonical file.
- [x] 1.2 Включить agent-skills в каждую инициализацию и удалить отдельные agent-skill flags. Обновить сообщения usage/next steps. Проверка: smoke copy в пустую временную директорию без optional flags содержит canonical и client adapters.

## 2. Общие правила и документация

- [x] 2.1 Добавить краткий `CLAUDE.md` в base payload и уточнить shared handoff rules в `template/base/AGENTS.md` и `docs/AGENT_WORKFLOW.md`. Проверка: Claude adapter и base rules направляют к одному canonical workflow, а rules требуют сверки Git/OpenSpec state при продолжении задачи.
- [x] 2.2 Переписать `README.md` и `README.ru.md` как owner-facing guide: value and supported-client overview, single-command start, agent-led flow from idea to approved implementation, then payload internals. Проверка: обе версии содержат одинаковые факты, рабочий синтаксис init script и не требуют от владельца просить запись `CONCEPTS.md` или OpenSpec change.
- [x] 2.3 Обновить `source/adapters/`, module READMEs и `docs/UPGRADING.md` для neutral canonical source, tested adapters, legacy alias и безопасного последовательного handoff. Проверка: не остаётся утверждений, что сами OpenSpec skills предназначены исключительно для Codex.

## 3. Проверка и OpenSpec

- [x] 3.1 Добавить и запустить проверку структуры adapters, ссылок на canonical workflows и базовой инициализации. Проверка: команда успешно проходит и проверяет отсутствие дублированных полных workflow instructions в client adapters.
- [x] 3.2 Сверить implementation с proposal, design и delta specs, отметить выполненные задачи и выполнить применимые document/shell проверки. Проверка: `openspec status --change multi-agent-adapters` показывает apply-ready artifacts, а все выполненные task contracts подтверждены.

## Фаза 2. Углубление

- [ ] 4.1 Добавить adapter для следующего AI client только после проверки его документированного project-level instruction или skill format; не дублировать canonical workflow.
