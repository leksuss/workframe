## 1. Правила принятия change

- [x] 1.1 Обновить source/canonical-rules/coherence.md, workflow.md и verification.md по Decisions 1–4 design: регистрация не разрешает отсрочку регрессии, sequencing/advisory не обходят gate, продуктовые решения остаются за владельцем. Согласовать root AGENTS.md и docs/DEBT.md. Проверка: перечитать все пути завершения, сопоставить каждый сценарий delta с точным адресом правила и записать результат в evidence.md.
- [x] 1.2 Перенести эквивалентное поведение в template/base/AGENTS.md, docs/AGENT_WORKFLOW.md, docs/DEBT.md и применимые checklists, сохранив адресуемость и отсутствие полного дублирования в skills. Проверка: матрица root/payload для обычного долга, исправленной регрессии, ожидания решения, явной отсрочки и обхода через advisory/backlog; каждый ожидаемый исход из delta подтверждён текстом shipped правил.

## 2. Документация и проверка

- [x] 2.1 Обновить README.md, README.ru.md и docs/UPGRADING.md для явного принятия политики существующими проектами; повысить VERSION на PATCH и оформить датированный release в CHANGELOG.md. Проверка: согласованность версии, смысла документации и границ root/payload; архивы и docs/CONCEPTS.md не изменены.
- [x] 2.2 Запустить openspec validate guard-regression-deferral --strict, scripts/verify-agent-adapters.sh, scripts/verify-contract-driven-workflow.sh, scripts/verify-instruction-budget.sh и git diff --check. Записать команды и реальные результаты в evidence.md; ошибки исправить и повторить затронутый gate. Отдельно указать, что проверки текста не доказывают поведение модели.
- [x] 2.3 Выполнить независимое перечитывание proposal/design/specs/tasks, итогового diff и evidence, затем reconcile по canonical policy. Ожидаемый результат: все сценарии подтверждены, новых регрессий без исправления либо явной отсрочки владельца нет. Только после этого предложить принятие/archive; commit/tag/merge/archive требуют соответствующего разрешения владельца.
