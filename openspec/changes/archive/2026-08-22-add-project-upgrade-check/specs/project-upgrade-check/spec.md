## ADDED Requirements

### Requirement: Read-only проверка обновления проекта
Workframe MUST предоставлять `scripts/check-workframe-update.sh --target <path>` для проверки существующего проекта без изменения файлов target project. Отчёт MUST показывать применённую версию marker, текущий root `VERSION`, modules из marker (или `unknown`), релизные заметки, список review-файлов и следующий шаг с project-local OpenSpec change.

#### Scenario: Проект отстаёт от Workframe
- **WHEN** владелец запускает проверку для проекта, чей marker содержит более раннюю версию
- **THEN** скрипт не изменяет target project и выводит версии, релизные заметки, состояние review-файлов и инструкцию создать `upgrade-workframe-guidance`

#### Scenario: Старый marker не содержит modules
- **WHEN** `.project-workframe-version` проекта не содержит поля `modules`
- **THEN** скрипт продолжает проверку и выводит `modules: unknown`

### Requirement: Marker установленных modules
Штатный init Workframe MUST записывать в `.project-workframe-version` все modules, которые он установил: `agent-skills` и выбранные optional modules.

#### Scenario: Инициализация с optional modules
- **WHEN** владелец запускает init с `design-pencil` и `frontend-quality`
- **THEN** marker содержит `modules: agent-skills,design-pencil,frontend-quality`
