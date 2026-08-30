## ADDED Requirements

### Requirement: Release evidence привязан к финальной tracked revision
Release или certification evidence MUST записывать exact tracked revision либо эквивалентную identity binding, для которой выполнен gate. Новый tracked commit MUST делать evidence stale до повторной проверки.

#### Scenario: Gate выполнен на final revision
- **WHEN** release gate проходит
- **THEN** result записывает текущую tracked revision и применимые artifact digests

#### Scenario: Revision изменилась после gate
- **WHEN** после записанного release evidence появляется новый tracked commit
- **THEN** evidence больше не подтверждает текущий state
- **AND** release/archive readiness требует повторного blocking gate
