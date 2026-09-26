# Evidence — guard-regression-deferral

Уровень: `behavior`. Изменяется текстовый workflow; новые executable surfaces и certification artifacts отсутствуют. Проверяется согласованность инструкций, не фактическое поведение модели. VERSION/CHANGELOG готовят PATCH 0.7.1; публикация, commit, tag и archive не выполнялись.

## Проверка задач 1.1 и 1.2

Ручное сопоставление delta с root и shipped правилами выполнено 2026-09-26. Основной путь root: AGENTS.md → source/canonical-rules/coherence.md, раздел Current-Change Regressions. Путь payload: template/base/AGENTS.md → docs/AGENT_WORKFLOW.md, раздел Coherence / Current-Change Regressions → release-readiness checklist. Новых payload-файлов нет; skills остаются входами в project rules.

| Сценарий / требование | Путь реализации | Проверка и наблюдаемый результат | Итог |
| --- | --- | --- | --- |
| Обычный долг вне scope | coherence.md / The Durable Register; оба DEBT / What Belongs Here; payload workflow / The Register | Существующие проблемы вне scope и осознанные улучшения с понятными последствиями разрешены; исправлять весь старый долг не требуется | passed |
| Change готов к архивации | оба AGENTS; coherence.md / Two Levels; workflow / Level One; release-readiness | Запись semantic/structural finding сохраняется, но не снимает условие по регрессиям | passed |
| Незавершённое углубление | canonical workflow / Sequencing; payload / Work Sequencing; release-readiness | Перенос в долговечный реестр сохранён, регрессии остаются под gate | passed |
| Canonical skill gate | workflow / Level One; coherence.md / Two Levels | Skills адресуют project rules/checklist, полный checklist в skills не добавлен | passed |
| Инициализация и создание записи | template/base/docs/DEBT.md / Entries, Entry Format | Реестр пуст, прежние поля сохранены; для разрешённой отсрочки добавлены решение, последствия и change id | passed |
| Планирование / закрытие записи | coherence.md / The Durable Register; оба DEBT | Проверка открытых записей, статусы и запрет молчаливого удаления сохранены | passed |
| Task без evidence / spec-code конфликт | canonical verification / Contract-Driven Verification; payload / Resolving Conflicts | Результат проверки необходим; запрет молчаливого продуктового решения сохранён | passed |
| Регрессия требует решения | оба раздела Current-Change Regressions | Явно требуется зафиксировать проблему и спросить владельца, не заявляя готовность | passed |
| Владелец разрешил отсрочку | оба раздела Current-Change Regressions; оба DEBT / Entry Format | Решение + последствия + текущий change в записи, ссылка в evidence; прочие gates сохраняются | passed |
| Регрессия исправлена | оба раздела Current-Change Regressions | Восстановленное поведение проверяется, результат записывается до принятия | passed |
| Advisory / backlog / accepted / будущий change | canonical verification / Advisory Triage; canonical workflow / Sequencing; payload Quality Pipeline, Work Sequencing и Current-Change Regressions | Каждый вариант без явного разрешения владельца оставляет change неготовым | passed |
| Неясное происхождение расхождения | оба раздела Current-Change Regressions | Агент запрашивает решение, неизвестность не становится разрешением | passed |

Дополнительно audit checklist применяет gate к регрессиям, внесённым самим аудитом. Полный аудит репозитория не запускался.

## Проверка задачи 2.1

VERSION = 0.7.1; CHANGELOG содержит датированный раздел 0.7.1 от 2026-09-26. README на двух языках описывают одинаковое условие. UPGRADING требует явного project-local change, сохранения записей DEBT и целого копирования canonical files. Архивы и docs/CONCEPTS.md не изменены. Результат: passed.

## Проверка задачи 2.2

Все команды завершились успешно:

| Команда | Наблюдаемый результат | Итог |
| --- | --- | --- |
| `openspec validate guard-regression-deferral --strict` | Change is valid | passed |
| `scripts/verify-agent-adapters.sh` | Agent adapters verified | passed |
| `scripts/verify-contract-driven-workflow.sh` | Contract-driven workflow verified | passed |
| `scripts/verify-instruction-budget.sh` | Instruction budget verified; root 6530/10000 bytes, payload 6075/10000 bytes | passed |
| `git diff --check` | Нет ошибок whitespace | passed |

Эти проверки проверяют структуру, routing, установку и действующий verification contract. Новое смысловое условие проверено матрицей выше; проход скриптов сам по себе не подтверждает соблюдение правила моделью.

## Итоговое review и reconcile — задача 2.3

Выполнен отдельный проход review от proposal/specs к итоговому diff и evidence, без вывода о готовности из checkbox. Это review текущим агентом для уровня behavior, не отдельный агент и не certification review.

Проверены попытки обойти правило: «записано в DEBT», «accepted», «назначен будущий change», «advisory», «перенесено в углубление». В каждой точке центральное правило явно сохраняет блокировку без решения владельца. Обратный сценарий — владелец явно разрешил отсрочку — допускается только с последствиями и сохранением остальных gates. Сценарий старого долга не требует очищать реестр ради принятия change.

Проверены пути вызова: root AGENTS адресует canonical rules; payload AGENTS адресует workflow и release-readiness; canonical apply/archive skills направляют к project rules и readiness checklist. Новое полное правило не продублировано в skills. Upgrade сохраняет существующие записи DEBT и позволяет явно согласовать только конфликтующую вводную часть.

Исправлена mechanical-находка в затронутом docs/DEBT.md: ссылка на отсутствующий раздел root AGENTS «Coherence» заменена существующим «Documentation And Payload Boundary». Других находок, требующих записи в DEBT или решения владельца, при scoped reconcile не выявлено. Удалённых сущностей и новых файлов payload нет. В добавленном тексте нет незаполненных placeholder. Исторические записи DEBT сохранены.

Итог: реализация и пять задач подтверждены; можно предложить archive. Дельта specs остаётся в активном change до разрешённого archive/sync. Release commit, tag, merge и публикация не выполнялись; этот отчёт не заявляет готовность опубликованного релиза на конкретном commit.
