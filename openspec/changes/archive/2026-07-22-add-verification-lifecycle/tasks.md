## 1. Канонический verification contract

- [x] 1.1 Добавить stack-neutral lifecycle в `source/canonical-rules/verification.md` и связать его с canonical workflow.
- [x] 1.2 Добавить в base payload постоянную `docs/QUALITY.md` с pending state, verification matrix и правилами staged rollout.

## 2. Встраивание в lifecycle целевого проекта

- [x] 2.1 Обновить `template/base/AGENTS.md` и `template/base/docs/AGENT_WORKFLOW.md`: trigger для technology surfaces, OpenSpec integration и completion behavior.
- [x] 2.2 Обновить feature и release checklists: blocking/advisory modes, run results, triage и явные skipped/unavailable checks.

## 3. Документация Workframe

- [x] 3.1 Обновить `README.md` и `README.ru.md`, описав новый base payload и границу между текстовым contract и project-specific tools.
- [x] 3.2 Обновить `docs/UPGRADING.md` для explicit adoption существующими проектами и добавить изменение в `CHANGELOG.md`.

## 4. Проверка

- [x] 4.1 Исправить обнаруженный empty-module compatibility blocker и проверить, что init script переносит `docs/QUALITY.md` в base-only проект без добавления tool-specific файлов.
- [x] 4.2 Запустить OpenSpec validation и проверки согласованности документации; устранить найденные расхождения.
