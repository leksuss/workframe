## ADDED Requirements

### Requirement: Verification result доказывает конкретный contract
Project verification lifecycle MUST записывать, какой requirement/scenario, production path и expected outcome доказывает каждый blocking result. Общий aggregate result MUST NOT подменять отсутствующий конкретный scenario.

#### Scenario: Aggregate gate проходит
- **WHEN** полный gate завершился `passed`
- **THEN** task считается доказанной только если её verification method присутствовал в gate и достиг требуемого ownership path

### Requirement: Fail-visible обработка flaky и timing-sensitive checks
Workframe MUST сохранять первый failure flaky или timing-sensitive blocking check, требовать isolated diagnosis, затем повтор полного blocking gate и запрещать считать случайный успешный rerun стиранием failure.

#### Scenario: Первый gate упал, один rerun прошёл
- **WHEN** полный blocking gate упал из-за предполагаемой timing race, а одиночный rerun прошёл
- **THEN** первый failure остаётся записанным
- **AND** агент выполняет isolated diagnosis и повторяет полный blocking gate

#### Scenario: Нестабильность подтверждена
- **WHEN** diagnosis подтверждает flaky behavior
- **THEN** check исправляется либо явно классифицируется по `docs/QUALITY.md`
- **AND** нестабильность не скрывается в итоговом сообщении
