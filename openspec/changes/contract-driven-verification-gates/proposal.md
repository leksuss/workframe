## Why

Текущий Workframe связывает завершение change с checkbox, общими проверками и reconcile, но не требует доказать конкретный ожидаемый результат через реальный production ownership path. Из-за этого зелёный suite может скрыть неподходящий test double, обход защитной границы, непроверяемый evidence artifact или проверку не той revision.

Change соответствует `docs/CONCEPTS.md`: усиливает переносимую дисциплину для разных стеков, оставляет продуктовые команды проекту и масштабирует глубину процесса по риску. Открытых записей `docs/DEBT.md` в этой области нет.

## What Changes

- Вводится пропорциональный contract-driven flow `requirement → production ownership path → positive verification → negative/adversarial verification → recorded result → independent review → archive decision`.
- Контракт `tasks.md` связывает неатомарные задачи с наблюдаемым результатом, production surface, защитными границами и фактически выполненным verification method; общий зелёный suite сам по себе не закрывает задачу.
- Для обычных, high-risk и release/certification changes вводится явная traceability requirement/scenario → implementation path → evidence → result; для atomic low-risk changes достаточно очевидной связи в задаче или итоговом review.
- Защитные границы получают обязательную risk-based negative/adversarial verification, включая bypass и альтернативные ownership paths.
- Execution отделяется от certification: сохранённый evidence artifact при применимости перепроверяется независимым verifier с identity, digest, provenance, consistency и fail-closed checks.
- Перед archive проводится отдельный финальный adversarial review без доверия checkbox; high-risk change использует другую модель/агента либо эквивалентный изолированный review context.
- Release readiness блокирует архивирование при недоказанных задачах, неприемлемых `skipped`/`unavailable`, stale evidence, непроверенной границе или скрытом flaky failure.
- Обновляются универсальные rules, payload, checklists, OpenSpec skills, adapter discovery, installer/upgrader guidance, version/changelog и автоматизированные проверки установки и upgrade preservation.

## Capabilities

### New Capabilities

- `contract-driven-verification`: уровни риска, traceability, adversarial boundary review, независимая certification и archive gates.

### Modified Capabilities

- `verification-lifecycle`: результаты конкретных проверок связываются с требованиями; flaky/timing-sensitive failures получают fail-visible обработку.
- `agent-sequencing`: task handoff и финальный review требуют фактического evidence, а high-risk review отделяется от implementer context.
- `coherence-lifecycle`: reconcile включает contract traceability, final diff/evidence review и классификацию обнаруженных расхождений.
- `project-upgrade-check`: upgrade verification доказывает сохранение project-owned документов и консистентность fresh/upgrade payload.
- `semantic-release-versioning`: release/certification evidence привязывается к финальной tracked revision и становится stale после нового commit.
- `multi-agent-workflow-adapters`: канонические skills получают универсальный verification contract, а client adapters остаются короткими указателями.
- `payload-addressing`: новый verification guidance получает адрес в правилах, которые приезжают вместе с ним.

## Impact

Change затрагивает root governance, `source/canonical-rules/`, `template/base/`, канонические `.agents/skills/`, client discovery adapters, OpenSpec specs, installation/upgrade scripts и их проверки, `README*`, `docs/UPGRADING.md`, `VERSION` и `CHANGELOG.md`. Продуктовые команды и stack-specific инструменты не добавляются: проекты продолжают определять их в `docs/PROJECT_RULES.md`, `docs/QUALITY.md` и собственных OpenSpec changes.
