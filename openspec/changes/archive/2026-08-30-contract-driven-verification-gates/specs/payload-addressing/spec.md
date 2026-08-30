## ADDED Requirements

### Requirement: Verification guidance адресован в shipped rules
Каждый shipped checklist и canonical skill, содержащий contract-driven verification steps, MUST иметь входящую ссылку из `template/base/AGENTS.md`, `docs/AGENT_WORKFLOW.md` либо уже адресованного client adapter. Адрес MUST называть момент применения и путь, не дублируя содержание guidance.

#### Scenario: Release readiness checklist расширен
- **WHEN** payload получает новые archive gates
- **THEN** shipped agent rules направляют агента к `docs/checklists/release-readiness.md` перед archive proposal

#### Scenario: Canonical apply skill расширен
- **WHEN** `.agents/skills/openspec-apply-change/SKILL.md` содержит task evidence steps
- **THEN** client adapters направляют поддерживаемые clients к этому canonical file
