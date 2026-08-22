## Why

Сейчас Workframe хранит версию только как исходный текст `0.1.0` в шаблоне маркера, а накопленные изменения остаются в разделе `Unreleased`. Владельцу трудно однозначно сопоставить состояние Workframe с версией, записанной в уже созданном проекте.

## What Changes

- Ввести единый канонический файл версии Workframe и применять Semantic Versioning (`MAJOR.MINOR.PATCH`).
- Требовать повышения версии при каждом завершённом Workframe change: `PATCH` для исправлений, `MINOR` для обратно совместимых возможностей, `MAJOR` для несовместимых изменений.
- Сделать инициализацию нового проекта записывающей фактическую версию Workframe в `.project-workframe-version`.
- Перевести накопленный раздел `Unreleased` в релиз `0.2.0` и обновить документацию обновления проектов.

## Capabilities

### New Capabilities

- `semantic-release-versioning`: единый номер версии Workframe, его изменение при завершении change и передача версии в создаваемый проект.

### Modified Capabilities

- `workframe-governance`: правила разработки Workframe дополняются обязательным выпуском версии для каждого завершённого change.

## Impact

Затронуты root governance, `VERSION`, `CHANGELOG.md`, шаблон `.project-workframe-version`, `scripts/init-project.sh`, README и `docs/UPGRADING.md`. Существующие проекты не меняются автоматически.
