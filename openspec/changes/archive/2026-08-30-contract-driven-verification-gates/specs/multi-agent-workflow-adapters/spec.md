## ADDED Requirements

### Requirement: Client adapters загружают единый verification workflow
Полные contract-driven verification инструкции MUST храниться в canonical `.agents/skills/` и нейтральных project rules. Client-specific skill files MUST оставаться короткими discovery adapters и MUST NOT создавать собственный вариант verification contract.

#### Scenario: Claude Code обнаруживает skill
- **WHEN** `.claude/skills/` установлен в project payload
- **THEN** adapter направляет client к соответствующему `.agents/skills/.../SKILL.md`
- **AND** не дублирует contract-driven rules

#### Scenario: Другой поддерживаемый client обнаруживает skill
- **WHEN** Codex или Qwen загружает client adapter, либо Kimi читает `.agents/skills/` напрямую
- **THEN** все clients получают один canonical workflow
