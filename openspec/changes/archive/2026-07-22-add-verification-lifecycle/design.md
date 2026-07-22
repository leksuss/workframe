## Context

Workframe сейчас хранит нейтральный workflow в `source/canonical-rules/workflow.md` и переносит его в целевой проект через `template/base/AGENTS.md`, `template/base/docs/AGENT_WORKFLOW.md` и checklists. Verification сформулирован только как `Run relevant checks`; постоянного места для команд, режимов и исключений нет.

Workframe должен остаться небольшим набором текстов, не выбирать стек за проект и не поставлять готовые конфигурации анализаторов. При этом выбор технологии должен приводить не только к application code, но и к конкретному, воспроизводимому quality pipeline в целевом репозитории.

## Goals / Non-Goals

**Goals:**

- задать stack-neutral lifecycle от технологического решения до работающего project-specific pipeline;
- связать создание и изменение pipeline с тем же OpenSpec change, который вводит или существенно меняет технологическую поверхность;
- дать целевому проекту постоянный, редактируемый источник истины для quality policy;
- различать blocking, advisory и `not applicable` checks, а также явные результаты skipped/unavailable;
- описать минимально достаточный rollout и типовые corner cases без привязки к конкретным инструментам.

**Non-Goals:**

- поставлять Ruff, mypy, ESLint, Semgrep, Archscope, CI workflows или их конфигурации;
- предписывать одинаковые категории и строгость проверок всем проектам;
- автоматически обновлять существующие проекты;
- превращать advisory findings в автоматический blocker;
- требовать полный production pipeline для временного spike до принятия решения о его сохранении.

## Decisions

### 1. Workframe задаёт verification contract, а не готовый pipeline

Canonical guidance появится в `source/canonical-rules/verification.md`. Payload получит `template/base/docs/QUALITY.md` как постоянную project-local policy и инструкции по её заполнению. Это сохраняет stack-neutral границу: Workframe поставляет вопросы, состояния и lifecycle, а целевой проект выбирает инструменты и команды.

Альтернатива — optional module с готовыми tool configs — отклонена: он быстро стал бы stack-specific, потребовал бы dependency maintenance и провоцировал cargo cult.

### 2. Trigger привязан к новой или существенно изменённой technology surface

Если OpenSpec change вводит или существенно меняет язык, runtime, компонент, хранилище, public contract, deployment surface или другой исполняемый слой, его design должен оценить quality risks, а tasks — внедрить или обновить pipeline для этой поверхности. Мелкие изменения, не меняющие поверхность, используют существующую policy и не обязаны перепроектировать её.

Для нового проекта рекомендуемый первый foundation change объединяет минимальный end-to-end skeleton и минимальный pipeline. Pipeline-задачи выполняются достаточно рано, чтобы последующая реализация проверялась уже каноническими командами.

### 3. OpenSpec хранит delta и rationale, `docs/QUALITY.md` — текущее состояние

Proposal/design/tasks объясняют, почему pipeline вводится или меняется и как он встроен в change. После archive постоянные команды не должны быть спрятаны только в истории change, поэтому `docs/QUALITY.md` хранит актуальную verification matrix:

- surface или scope;
- risk/check class;
- tool и canonical command;
- mode: `blocking`, `advisory`, `not applicable`;
- trigger: local/change/full/release/periodic;
- exclusions, prerequisites и fallback;
- owner note или rationale там, где решение неочевидно.

### 4. Режим проверки отделён от результата запуска

Policy mode определяет обязательность: `blocking`, `advisory`, `not applicable`. Run result фиксируется отдельно: `passed`, `failed`, `skipped` или `unavailable`. `skipped` и `unavailable` требуют причины и не считаются автоматическим успехом blocking check.

Advisory findings проходят агентский triage как минимум в категории `confirmed`, `false positive` или `deferred`. Подтверждённый finding либо исправляется в текущем change, если блокирует его цель, либо становится явно зафиксированной будущей работой.

### 5. Guidance требует пропорциональности и staged rollout

Новый инструмент не обязан сразу становиться blocking. Для legacy, noisy и эвристических анализаторов допустимы baseline, changed-scope enforcement и advisory rollout. Для polyglot/monorepo policy разделяется по surfaces и предоставляет агрегирующую команду, когда это практично. Generated/vendor code получает явные exclusions. Spikes документируют временные пропуски и условие перехода к постоянному pipeline.

Archscope упоминается как пример advisory architecture/quality analysis: Markdown используется для агентского разбора полного отчёта, SARIF — как дополнительный security artifact, если полезен. Его наличие не является требованием Workframe.

### 6. Lifecycle встраивается в существующие workflow-точки

- `template/base/AGENTS.md` получает нормативное правило для technology-surface changes и completion.
- `template/base/docs/AGENT_WORKFLOW.md` объясняет derivation flow и уровни запуска.
- `feature-change.md` проверяет design/tasks и обновление `docs/QUALITY.md`.
- `release-readiness.md` различает blocking results, manual verification и advisory triage.
- README перечисляет новый base payload и объясняет, что он не содержит готовых инструментов.
- `docs/UPGRADING.md` предлагает существующим проектам принимать lifecycle через project-local OpenSpec change.

Root `AGENTS.md` не становится копией payload guidance: изменение направлено на generated projects. Root docs описывают новое поведение, соблюдая boundary между governance Workframe и `template/`.

### 7. Base-only init smoke blocker исправляется в текущем change

Smoke test нового обязательного payload обнаружил, что системный Bash с `set -u` считает expansion пустого `MODULES[@]` unbound и завершает `scripts/init-project.sh --target ...` до копирования. Поскольку это блокирует проверку документированного base-only journey, script получает отдельный module count и входит в цикл только при наличии `--with`. Исправление не добавляет automation или tool-specific payload.

## Risks / Trade-offs

- [Risk] Первый foundation change станет тяжелее. → Требовать минимально достаточный набор и разрешать staged rollout.
- [Risk] Agents выберут популярные tools без связи с рисками. → Требовать порядок `surface → risk → check class → tool` и явный rationale.
- [Risk] `docs/QUALITY.md` разойдётся с CI. → Сделать его обновление частью того же change и completion checklist.
- [Risk] Legacy repository получит непреодолимый красный gate. → Описать baseline, changed-scope enforcement и постепенное ужесточение.
- [Risk] Пропущенный check будет выдан за успешный. → Разделить policy mode и run result, требовать причину для `skipped`/`unavailable`.
- [Risk] Дополнительный документ увеличит payload. → Держать его короткой матрицей и практическими правилами, а подробное объяснение lifecycle — в существующем workflow.
- [Risk] Text-only guidance не обеспечивает техническое enforcement. → Прямо рекомендовать закреплять blocking checks в CI после появления CI, не утверждая, что документация его заменяет.
- [Risk] Исправление init script расширяет change за пределы текстов. → Ограничить правку только существующим base-only blocker, обнаруженным обязательным smoke test.

## Migration Plan

Новые проекты получают `docs/QUALITY.md` вместе с base payload. До выбора стека документ остаётся явной незаполненной policy, а первый technology-establishing change конкретизирует его.

Существующие проекты принимают lifecycle только через собственный OpenSpec change по `docs/UPGRADING.md`; автоматического копирования или переписывания нет. Откат состоит в удалении новых payload-инструкций до выпуска либо в project-local change, отменяющем принятую policy.

## Open Questions

Нет блокирующих вопросов. Имена конкретных инструментов, canonical commands и CI integration намеренно остаются решениями целевого проекта.
