## Context

Версия Workframe теперь хранится в `VERSION`, но существующий проект сообщает лишь версию и не даёт повторяемой проверки до изменения файлов. Скрипт должен работать из checkout Workframe, читать target project и не менять его.

## Goals / Non-Goals

**Goals:**

- Дать владельцу и агенту одинаковый краткий отчёт: текущая и применённая версии, modules, релизные заметки и список файлов для review.
- Записывать modules, реально установленные штатным init, в marker.
- Связывать каждый SemVer-релиз с локальным Git-тегом `v<version>`.

**Non-Goals:**

- Не применять diff и не создавать project-local OpenSpec change автоматически.
- Не пытаться трёхсторонне сливать project-specific изменения.
- Не требовать, чтобы target project был Git-репозиторием.

## Decisions

- `scripts/check-workframe-update.sh --target <path>` — read-only Bash script рядом с init script. Он не принимает флаг записи и завершается ошибкой только для некорректного вызова или отсутствующего marker; различия в review-файлах являются информационным результатом.
- Marker хранит `modules` как comma-separated список. Новый init всегда записывает `agent-skills` и добавляет выбранные `design-pencil` и `frontend-quality`; старые markers без поля остаются допустимы и выводятся как `unknown`.
- Скрипт выводит release notes из `CHANGELOG.md` от текущего release к версии target, состояние стандартного набора review-файлов и подсказку создать `upgrade-workframe-guidance`. Для source of truth он использует текущий Workframe checkout, поэтому агенту не нужно угадывать, откуда брать новые файлы.
- Релиз получает аннотированный Git-тег `v<VERSION>` после commit. `v0.2.0` ставится на уже существующий релизный commit; этот change выпускает `0.3.0` и получает `v0.3.0` при завершении.
- Placeholder `TBD` в Purpose уже созданной main spec исправляется как mechanical finding в этом change.

## Risks / Trade-offs

- [Локальный Workframe checkout устарел] → отчёт явно печатает путь и `VERSION`; владелец сначала обновляет сам Workframe checkout.
- [Marker старого проекта не имеет modules] → скрипт сообщает `unknown`, а агент определяет modules по файлам во время review.
- [Файлы отличаются из-за местных правил] → скрипт только сообщает состояние, не называет расхождение ошибкой и не заменяет файл.
