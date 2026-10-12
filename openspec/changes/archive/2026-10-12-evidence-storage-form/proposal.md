## Why

Правила verification говорят, что записать (результат, первый провал, итог пробы снятия защиты, persisted certification evidence), но не говорят, в какой форме это хранить. Агенты перестраховываются и коммитят сырые выводы целиком. Наблюдаемые случаи в проекте на Workframe 0.7.0: change «оптимизация тестов» — около 80 строк кода и около 75 000 строк свидетельств (3,1 МБ: три сырых профиля pytest, полные логи gate, логи проб и первых провалов, перечни тестов, хэши 221 файла); change «приёмка уроков» — десятки логов и скриншотов в artifacts. Это навсегда раздувает историю VCS, а ценность свидетельства — в итоге и его привязке к ревизии, не в пословном выводе.

## What Changes

- Ввести правило формы свидетельств: в VCS хранится сводка по типу данных, сырой вывод успешных проверок, профили, повторные прогоны и дампы проб — вне VCS.
- Требовать положительной записи успеха; отсутствие записи об ошибке не считается успехом.
- Сырые выводы лежат в локальном каталоге, игнорируемом VCS, адресуются хэшем содержимого и удаляются при reconcile перед archive; сводка ссылается на хэш, когда вывод опирается на сырой файл.
- Предпочитать сводку, сгенерированную инструментом проекта; инструмент, формат и каталог назначает `docs/QUALITY.md` проекта.
- Уточнить пропорциональность: для tooling и внутренних behavior changes достаточно «было/стало + полный gate зелёный».
- Отразить правило в каноническом verification source, `docs/AGENT_WORKFLOW.md`, feature/release-readiness checklists и шаблоне `docs/QUALITY.md`; выпустить 0.8.0 с инструкцией обновления.

Существующие требования не ослабляются: первый провал сохраняется (выдержка в сводке), итог пробы снятия защиты записывается, certification evidence остаётся в VCS в объёме, нужном verifier.

## Capabilities

### New Capabilities

Нет.

### Modified Capabilities

- `contract-driven-verification`: добавляется требование к форме хранения свидетельств.

## Impact

Root canonical rules (`source/canonical-rules/verification.md`) и generated-project payload: `template/base/docs/AGENT_WORKFLOW.md`, `docs/checklists/feature-change.md`, `docs/checklists/release-readiness.md`, `docs/QUALITY.md`. Always-loaded `AGENTS.md` не меняется: существующая маршрутизация уже загружает workflow и checklists. Новых payload-файлов, зависимостей и executable surfaces нет. Документация: `docs/UPGRADING.md`, `CHANGELOG.md`, `VERSION` (MINOR → 0.8.0), README при необходимости. Архивы и `docs/CONCEPTS.md` не меняются. Открытых записей в `docs/DEBT.md` нет.
