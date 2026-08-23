## Why

Запись `D-007` реестра фиксирует противоречие, обнаруженное при апгрейде `/Users/andrey/sites/tendril`: чек-лист и правила payload требуют, чтобы канонические файлы проекта были побайтово равны шаблону, а `docs/UPGRADING.md` требует сохранять project-specific дополнения в `AGENTS.md`, чек-листах и локальных skills. Проект, у которого собственные правила лежат внутри канонического файла, не может выполнить оба требования одновременно. Наблюдаемая цена: tendril, обновлённый до текущей версии, получает `Content level: mixed` и `Status: review an upgrade before changing the project` — сигнал о пересказе срабатывает на безобидном поводе и перестаёт что-либо значить.

## What Changes

- Добавить в payload `docs/PROJECT_RULES.md` — файл проекта для правил, которые Workframe не поставляет, — и адресовать его из `template/base/AGENTS.md`.
- Запретить вносить project-specific правила в канонические файлы: их место в `docs/PROJECT_RULES.md`, а канонические файлы остаются побайтово равными шаблону.
- Отнести `docs/PROJECT_RULES.md` к project-local файлам в `scripts/check-workframe-update.sh`, чтобы его расхождение с шаблоном было ожидаемым.
- Заменить в `docs/UPGRADING.md` требование сохранять дополнения внутри канонических файлов на требование переносить их в `docs/PROJECT_RULES.md` без переписывания.
- Закрыть `D-007` в реестре с указанием этого change.
- Выпустить обратно совместимую возможность как `0.5.0`.

## Capabilities

### Modified Capabilities

- `payload-addressing`: правила, которые проект решает за себя, живут в собственном адресованном файле; канонический файл не редактируется ради их добавления.
- `project-upgrade-check`: побайтовое равенство канонических файлов становится выполнимым требованием, а `docs/PROJECT_RULES.md` относится к файлам, расхождение которых ожидаемо.

## Impact

Затронуты generated project payload (`template/base/AGENTS.md`, новый `template/base/docs/PROJECT_RULES.md`), `scripts/check-workframe-update.sh`, root `docs/UPGRADING.md`, `README.md`, `README.ru.md`, `source/canonical-rules/workflow.md`, `docs/DEBT.md`, `VERSION` и `CHANGELOG.md`. Существующие проекты не изменяются автоматически; при апгрейде им потребуется перенести собственные правила из канонических файлов в новый файл. Такой перенос выполняется для `/Users/andrey/sites/tendril`, `/Users/andrey/sites/leksus/cashback_bro` и `/Users/andrey/sites/bilingvo` отдельными project-local changes.
