## MODIFIED Requirements

### Requirement: Root OpenSpec

Workframe MUST use a root `openspec/` directory for its own future non-trivial changes. Each completed non-trivial Workframe change MUST update the canonical SemVer version and dated changelog section before archive.

#### Scenario: Workframe change starts

- **WHEN** owner начинает non-trivial Workframe change после bootstrap governance
- **THEN** change создается в root `openspec/changes/<change-id>/`
- **AND** работа ведется на matching branch `feature/<change-id>`

#### Scenario: Workframe change is ready to archive

- **WHEN** агент завершил и проверил non-trivial Workframe change
- **THEN** он выбирает SemVer-уровень, обновляет root `VERSION` и добавляет датированную секцию в `CHANGELOG.md` до предложения archive

#### Scenario: Template OpenSpec payload exists

- **WHEN** agent видит `template/base/openspec/`
- **THEN** agent treats it as generated project payload
- **AND** agent does not use it as the active OpenSpec directory for Workframe repo changes
