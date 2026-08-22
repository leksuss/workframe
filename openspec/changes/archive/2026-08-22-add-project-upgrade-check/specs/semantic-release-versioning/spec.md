## MODIFIED Requirements

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
