## Context

Base payload уже содержит нейтральные `AGENTS.md` и `docs/AGENT_WORKFLOW.md`, однако только Codex получает discoverable OpenSpec skills. В результате владелец, который переходит между Codex, Cursor, Claude Code, Qwen Code или Kimi Code, не получает одинаковый способ вызвать workflow.

Формат `SKILL.md` переносим, но пути discovery зависят от клиента. В частности, Codex использует `.codex/skills/`, Claude Code — `.claude/skills/`, Qwen Code — `.qwen/skills/`, а Kimi Code понимает project-level `.agents/skills/` и `.kimi-code/skills/`. Cursor автоматически читает root `AGENTS.md`.

## Goals / Non-Goals

**Goals:**

- Дать одному проекту единый workflow, который можно последовательно продолжать в поддерживаемых агентных средах.
- Хранить полные OpenSpec workflows в одном каноническом payload-месте и не поддерживать независимые копии инструкций.
- Автоматически установить lightweight adapters для Codex, Claude Code, Qwen Code и Kimi Code по явному module choice; Cursor получает базовые правила через `AGENTS.md`.
- Ясно отделить AI client от модели: Qwen и Kimi являются поддерживаемыми клиентами; DeepSeek и другие модели получают те же правила, когда запущены в одном из поддерживаемых клиентов.

**Non-Goals:**

- Не обещать автоматическое подключение для всех существующих и будущих приложений: единого стандарта discovery нет.
- Не синхронизировать историю чатов, лимиты, настройки моделей или credentials между поставщиками.
- Не давать агентам право одновременно менять одни и те же файлы; речь идёт о последовательной передаче работы в одном Git worktree.
- Не добавлять adapter для среды, пока её project-level instruction/skill format не подтверждён документацией.

## Decisions

### 1. Канонические workflow skills живут в `.agents/skills/`

Новый optional module `agent-skills` будет хранить полные `SKILL.md` в `.agents/skills/openspec-*/`. Это нейтральная project-level папка, которую непосредственно сканирует Kimi Code, и понятное место для ручного подключения в других клиентах.

`agent-skills` остаётся внутренней границей payload в репозитории Workframe, но `init-project.sh` устанавливает его всегда. Новый проект без общих workflows не даёт владельцу обещанный сценарий смены клиентов, поэтому отдельный flag не нужен.

Альтернатива — копировать полный текст в `.codex`, `.claude`, `.qwen` и `.kimi-code`. Она отклонена: версия workflow неизбежно начнёт расходиться.

### 2. Client directories содержат только adapter skills

Для Codex, Claude Code и Qwen Code module создаёт соответствующие `SKILL.md` с необходимым minimal frontmatter и инструкцией прочитать одноимённый canonical skill из `.agents/skills/` перед работой. Для Kimi direct `.agents/skills/` достаточно; `.kimi-code/skills/` не создаётся без отдельной Kimi-specific необходимости.

Так каждый клиент автоматически показывает нужный command/skill, а содержательные правила существуют ровно в одном файле. Adapter не дублирует требования и не меняет workflow.

### 3. Always-on rules остаются в base payload

`AGENTS.md` и `docs/AGENT_WORKFLOW.md` — обязательная общая рамка. В них будет явное правило: при старте новой сессии агент читает эти документы и продолжает работу от repository state, а не от памяти предыдущего чата. Это поддерживает смену приложений и review другим агентом.

Для Claude Code будет добавлен короткий `CLAUDE.md`, ссылающийся на `AGENTS.md` и `docs/AGENT_WORKFLOW.md`. Cursor уже умеет читать `AGENTS.md`; отдельные Cursor Rules не нужны и создавали бы вторую копию always-on rules.

### 4. Инициализация и документация ориентированы на владельца

`init-project.sh` всегда устанавливает `agent-skills`. README даёт практический путь: создать repository, применить scaffold, открыть его в выбранном агенте, обсудить идею до согласования ценностей, попросить агента записать утверждённые решения и подготовить первый change. Документация перечисляет поддерживаемые clients и fallback для неподдерживаемых.

## Risks / Trade-offs

- [Agent не выполняет ссылку из adapter skill] → wrapper формулирует чтение canonical skill как первый обязательный шаг; smoke test проверяет пути и отсутствие самостоятельных workflow instructions в wrappers.
- [Client меняет формат] → registry адаптеров содержит ссылку на официальную документацию и дату проверки; новый format добавляется отдельным change.
- [Смена агента создаёт конфликт в worktree] → базовые rules предписывают проверять `git status`, текущую ветку и active OpenSpec change перед изменениями; документация подчёркивает последовательную, не параллельную работу.
- [Пользователь не ожидает скрытых agent files] → README и вывод init script явно сообщают, что workflows и adapters входят в стандартный scaffold.
