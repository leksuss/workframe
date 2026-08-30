# semantic-release-versioning Specification

## Purpose
Определить единый номер версии Workframe, правила SemVer-релизов и сведения, которые переносятся в marker создаваемого проекта.
## Requirements
### Requirement: Каноническая версия Workframe
Workframe MUST хранить текущую версию scaffold в root-файле `VERSION` в формате Semantic Versioning `MAJOR.MINOR.PATCH`. Template и документация MUST ссылаться на этот источник, а не дублировать конкретный номер версии.

#### Scenario: Владелец определяет актуальную версию
- **WHEN** владелец или агент проверяет состояние Workframe
- **THEN** он получает единственный актуальный номер из root `VERSION`

### Requirement: Версионный выпуск завершённого change
Каждый завершённый нетривиальный Workframe change MUST выбрать и применить повышение SemVer-версии до предложения archive: `PATCH` для обратно совместимого исправления, `MINOR` для обратно совместимой возможности и `MAJOR` для несовместимого изменения обязательного payload или workflow. `CHANGELOG.md` MUST содержать датированную секцию этой версии, а release commit MUST иметь аннотированный Git-тег `v<version>`.

#### Scenario: Завершение обратно совместимой возможности
- **WHEN** Workframe change добавляет обратно совместимую возможность
- **THEN** агент повышает `MINOR`, переносит относящиеся к релизу записи из `Unreleased` в секцию новой версии, создаёт аннотированный Git-тег `v<version>` на release commit и фиксирует обоснование в артефактах change

### Requirement: Маркер версии в новом проекте
Штатная инициализация проекта MUST записывать в `.project-workframe-version` значение root `VERSION` Workframe, дату применения и список modules, фактически установленных init.

#### Scenario: Создание проекта скриптом
- **WHEN** владелец запускает `scripts/init-project.sh` из Workframe с валидным `VERSION`
- **THEN** новый проект содержит `.project-workframe-version` с этой версией, текущей датой и фактически установленными modules

### Requirement: Явное обновление существующего проекта
Обновление существующего проекта MUST оставаться отдельным проверяемым project-local change. Агент MUST сопоставить маркер проекта с выбранной версией Workframe, применить только релевантные изменения и записать фактически применённую версию.

#### Scenario: Проект обновляют до актуального Workframe
- **WHEN** владелец просит обновить Workframe в существующем проекте
- **THEN** агент не перезаписывает project-specific rules автоматически и обновляет `.project-workframe-version` только после review и применения выбранных изменений

### Requirement: Release evidence привязан к финальной tracked revision
Release или certification evidence MUST записывать exact tracked revision либо эквивалентную identity binding, для которой выполнен gate. Новый tracked commit MUST делать evidence stale до повторной проверки.

#### Scenario: Gate выполнен на final revision
- **WHEN** release gate проходит
- **THEN** result записывает текущую tracked revision и применимые artifact digests

#### Scenario: Revision изменилась после gate
- **WHEN** после записанного release evidence появляется новый tracked commit
- **THEN** evidence больше не подтверждает текущий state
- **AND** release/archive readiness требует повторного blocking gate

