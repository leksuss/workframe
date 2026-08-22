## Why

Фраза «обнови Workframe» заставляет агента угадывать источник, текущую версию и объём переноса. Владельцу нужен короткий повторяемый способ увидеть фактическую разницу до создания project-local change, сохранив ручной review.

## What Changes

- Добавить Git-теги `v<version>` для релизов Workframe, начиная с существующего `v0.2.0`, и сделать их обязательным элементом выпуска.
- Расширить `.project-workframe-version` полем `modules`, которое штатный init заполняет фактически установленными modules.
- Добавить read-only `scripts/check-workframe-update.sh`, показывающий версии, выбранные modules, релизные заметки и состояние review-файлов target project.
- Добавить короткий стандартный prompt и процесс project-local upgrade в документацию.
- Выпустить обратно совместимую возможность как `0.3.0`.

## Capabilities

### New Capabilities

- `project-upgrade-check`: локальная read-only проверка, которая формирует доказуемую основу для обновления Workframe в существующем проекте.

### Modified Capabilities

- `semantic-release-versioning`: выпуск Workframe сопровождается Git-тегом `v<version>` и marker нового проекта фиксирует применённые modules.

## Impact

Затронуты root `VERSION`, `CHANGELOG.md`, release governance, init payload и скрипты, `.project-workframe-version`, upgrade guide и README. Существующие проекты останутся без изменений, пока владелец не запустит проверку и отдельный upgrade change.
