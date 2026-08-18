## MODIFIED Requirements

### Requirement: Canonical project workflows
Workframe MUST install complete project workflow skills in one canonical project location for every new project and MUST NOT maintain independent complete copies for individual AI clients. The canonical location holds the project's working procedures, including workflows that are not part of OpenSpec.

#### Scenario: Agent loads a workflow through a client adapter
- **WHEN** Codex, Claude Code or Qwen Code invokes an installed workflow skill
- **THEN** its adapter instructs the agent to read the matching canonical workflow before performing the workflow

#### Scenario: Kimi Code loads a workflow
- **WHEN** Kimi Code opens a project with the agent-skills module
- **THEN** it can discover the canonical workflow skills from its supported project-level location

#### Scenario: Adapter duplicates canonical instructions
- **WHEN** a client adapter contains the canonical workflow text instead of a reference to it
- **THEN** the payload verification detects the duplication for any skill, including skills added later
- **AND** the check does not depend on the wording of an individual skill description
