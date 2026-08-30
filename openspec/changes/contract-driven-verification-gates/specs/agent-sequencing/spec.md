## ADDED Requirements

### Requirement: Checkbox следует за verification evidence
Workframe MUST требовать, чтобы исполнитель отмечал задачу завершённой только после выполнения указанного verification method и записи result либо после документированного owner exception. При завершении change агент MUST повторно пройти каждую задачу и сопоставить expected result, production path, implementation и evidence.

#### Scenario: Implementation написана до проверки
- **WHEN** код задачи готов, но declared verification method ещё не выполнен
- **THEN** checkbox остаётся незакрытым

#### Scenario: Все checkbox выставлены
- **WHEN** агент готов завершить change
- **THEN** он повторно проверяет каждую задачу по фактическому result и method
- **AND** не выводит completion из состояния checkbox

### Requirement: High-risk review отделён от implementer pass
Workframe MUST требовать для high-risk change другой agent/model либо эквивалентный изолированный review context после завершения implementation pass.

#### Scenario: Implementer завершил high-risk change
- **WHEN** implementation и первичные checks завершены
- **THEN** отдельный reviewer context читает repository artifacts и final diff заново
- **AND** итог называет способ независимого review
