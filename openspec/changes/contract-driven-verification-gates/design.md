## Context

Workframe уже различает blocking/advisory checks, требует проверяемые задачи и reconcile, но эти механизмы не образуют один contract. Checkbox можно поставить после общего suite, не установив, какой requirement прошёл через какой production path и какой evidence это доказывает. Особенно опасны защитные границы, public/default paths и release evidence.

Решение должно жить в provider-neutral payload. `source/canonical-rules/` объясняет нейтральную модель; `template/base/AGENTS.md`, `docs/AGENT_WORKFLOW.md`, `docs/QUALITY.md` и checklists доставляют её проектам; `.agents/skills/` реализует workflow действий; `.codex/`, `.claude/` и `.qwen/` только обнаруживают тот же канон. Root `AGENTS.md` управляет самим Workframe и синхронизируется по смыслу, но не считается копией payload.

## Goals / Non-Goals

**Goals:**

- сделать ожидаемый task outcome и конкретный verification result условием checkbox;
- обнаруживать requirement без production path/evidence и test, подтверждающий иной outcome;
- требовать risk-based adversarial checks для защитных границ и альтернативных ownership paths;
- отделить создание persisted evidence от его независимой перепроверки;
- привязать release/certification evidence к точной финальной tracked revision;
- добавить отдельный final review-pass и fail-visible обработку flaky failures;
- сохранить лёгкий путь для atomic low-risk changes;
- автоматически проверить доставку правил через fresh install и upgrade fixture с сохранением project-owned документов.

**Non-Goals:**

- предписывать языки, test frameworks, CI providers или продуктовые команды;
- требовать все adversarial scenarios для каждого change;
- превращать каждый typo в OpenSpec change или отдельную traceability table;
- объявлять runner независимым verifier либо требовать отдельный executable verifier при непропорционально низком риске;
- автоматически обновлять существующие проекты или архивировать change.

## Decisions

### 1. Один verification contract, четыре уровня глубины

Уровень выбирается в design/tasks по максимальному риску затронутых surfaces:

1. `atomic low-risk` — очевидная связь change → result → check в задаче или итоговом сообщении; отдельная matrix не нужна.
2. `behavior` — для каждого изменённого requirement/scenario фиксируются production path, evidence и result; positive scenario обязателен, negative добавляется по риску.
3. `high-risk boundary` — явная traceability, positive и risk-based negative/adversarial scenarios, bypass/alternative paths и отдельный review context.
4. `release/certification` — всё выше плюс persisted evidence, independent re-verification и exact revision/digest binding.

Альтернатива — единая обязательная таблица — отклонена как несоразмерная малым changes. Альтернатива — только свободный текст — отклонена: крупный change не позволяет надёжно увидеть пропуски.

### 2. Минимальная traceability хранится в change artifacts

Для `behavior` и выше design/tasks либо отдельная секция change artifacts содержит записи:

`requirement/scenario | production implementation/ownership path | verification/evidence | result`

Допустимые результаты: `passed`, `failed`, `skipped`, `unavailable`. В tasks можно ссылаться на эту секцию, не дублируя её. Отдельный новый постоянный файл payload не создаётся: traceability принадлежит конкретному change и должна архивироваться вместе с ним. Для этого change matrix будет в `design.md` и итоговые results — в `tasks.md`.

### 3. Production ownership path важнее test double

Verification method обязан называть production surface и наблюдаемый outcome. Test считается доказательством только если достигает требуемого ownership path либо обоснованно заменяет его. Review отдельно ищет facade-only coverage, unreachable doubles, direct API/server bypass, public/default/embedding paths и альтернативные CLI/console/supervisor/restart flows.

Так выявляются mock вместо loopback integration, тест неправильного отказа вместо требуемого успеха и UI-only gate при разрешающем API.

### 4. Защитные границы получают выбранные по риску adversarial scenarios

Универсальный список surfaces служит trigger, а не checklist всех возможных тестов. Design выбирает применимые attacks/failures: missing/extra fields, permissions/allow-list, absent length, stalled dependency, retry/collision, stale/tampered artifact, optimistic default, partial write/rollback и bypass paths. `docs/PROJECT_RULES.md` и `docs/QUALITY.md` определяют project-specific команды и обязательность.

### 5. Certification отделена от execution

Runner может создавать artifact и inline assertions, но certification требует повторной проверки уже сохранённого artifact независимым verifier. Применимый verifier проверяет schema/version, provenance, exact identity/revision, digest, scope/tier, consistency, sensitive fields, tampering/staleness и fail-closed behavior. Если отдельный verifier непропорционален, design обязан назвать причину и эквивалентную независимую проверку.

### 6. Final review является новым проходом, а не продолжением checkbox loop

Перед предложением archive агент заново читает proposal, design, specs, tasks, final diff и verification results, не полагаясь на checkbox. Для high-risk change используется другой агент/model либо новый изолированный review context с теми же repository artifacts. Требование не означает обязательное ручное owner review каждой реализации.

### 7. Evidence и flaky failures остаются видимыми

Release/certification result записывает точную tracked revision и, когда применимо, digest artifact. Любой следующий tracked commit делает evidence stale и требует повторного gate либо явного non-passing status. Первый failure timing-sensitive test сохраняется: сначала isolated diagnosis, затем повтор всего blocking gate; подтверждённая нестабильность исправляется или классифицируется по `docs/QUALITY.md`.

### 8. Автоматизация проверяет payload contract, а не продуктовые инструменты

Добавляется repository check script, который проверяет наличие ключевых contract clauses в канонических payload files, тонкость adapters, fresh init, upgrade fixture и byte preservation `docs/CONCEPTS.md`, `docs/QUALITY.md`, `docs/DEBT.md`, `docs/PROJECT_RULES.md`. Скрипт не пытается доказать смысл Markdown полностью; semantic traceability проверяется OpenSpec strict validation и adversarial review.

## Risks / Trade-offs

- **[Риск: process разрастается]** → четыре уровня и отсутствие отдельной matrix для atomic low-risk change.
- **[Риск: текстовые правила создают ложное чувство enforcement]** → automated payload checks проверяют доставку, а конкретные projects обязаны связывать rules с исполняемыми checks в `docs/QUALITY.md`.
- **[Риск: “independent” review остаётся тем же контекстом]** → high-risk требует другую модель/агента или явно изолированный context; итоговый result называет использованный способ.
- **[Риск: revision binding невозможно без commit]** → change остаётся non-release-ready до появления tracked final revision; рабочие проверки могут быть preliminary, но не называться final evidence.
- **[Риск: существующие проекты потеряют локальные quality rules]** → upgrade остаётся project-local OpenSpec change; project-owned документы не перезаписываются и проверяются fixture test.

## Migration Plan

1. Выпустить совместимую `MINOR`-версию Workframe: обязательный payload расширяет workflow, но не ломает формат проектов.
2. Fresh projects получают contract автоматически через init.
3. Existing projects запускают `scripts/check-workframe-update.sh`, создают project-local upgrade change, копируют canonical files целиком, сохраняют четыре project-owned документа и адаптируют свои команды в `docs/QUALITY.md`/`docs/PROJECT_RULES.md`.
4. Rollback выполняется возвратом canonical payload к предыдущему tagged Workframe release; project-owned документы остаются нетронутыми.

## Open Questions

Нет. Project-specific выбор checks намеренно остаётся за target project.

## Acceptance Traceability Results

| Scenario | Production/process path | Implemented mechanism | Evidence / result |
| --- | --- | --- | --- |
| 1. loopback required, mock only | task → ownership path → evidence | `source/canonical-rules/verification.md` and apply skill reject a mock as required loopback/integration evidence | `verify-contract-driven-workflow.sh` phrase gate — `passed` |
| 2. append success, test expects `EEXIST` | spec outcome → positive scenario | task/checklist/final review compare assertion with the exact required outcome | exact-outcome phrase gate plus strict scenario — `passed` |
| 3. UI blocks, `POST /runs` allows | facade plus direct server path | feature/release checklists require direct API/server bypass and alternative ownership-path review | direct-API phrase gate — `passed` |
| 4. size checked after `response.text()` | streaming/resource boundary | canonical rule and checklists require bounds during consumption, before full materialization | full-materialization phrase gate — `passed` |
| 5. public controller defaults `ready` | public/default ownership path | canonical rule requires absent/unknown dependencies and public defaults to fail closed | public-default phrase gate — `passed` |
| 6. digest stored, never verified | runner → persisted artifact → verifier | canonical rules and skills separate runner from independent persisted-artifact verifier | independent-verifier phrase gate — `passed` |
| 7. permissions exist, allow-list missing | authorization boundary | boundary review verifies mandatory allow-list denial separately from permissions | capability-allow-list phrase gate — `passed` |
| 8. dependency hangs before port | timeout/cancellation boundary | adversarial selection includes stalled dependency and bounded fail-closed timeout/cancellation | stalled-dependency phrase gate — `passed` |
| 9. evidence belongs to old commit | release evidence → final revision | release checklist and archive skill require exact current tracked revision and invalidate evidence after later commit | revision/staleness phrase gates — `passed`; final release evidence remains preliminary until commit |
| 10. failed gate hidden by rerun | run history → diagnosis → full gate | quality rules, checklist and apply/archive skills retain first failure, diagnose, then rerun full gate | first-failure phrase gate — `passed` |
