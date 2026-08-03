## ADDED Requirements

### Requirement: Canonical project workflows
Workframe MUST install complete OpenSpec workflow skills in one canonical project location for every new project and MUST NOT maintain independent complete copies for individual AI clients.

#### Scenario: Agent loads a workflow through a client adapter
- **WHEN** Codex, Claude Code or Qwen Code invokes an installed OpenSpec workflow skill
- **THEN** its adapter instructs the agent to read the matching canonical workflow before performing the workflow

#### Scenario: Kimi Code loads a workflow
- **WHEN** Kimi Code opens a project with the agent-skills module
- **THEN** it can discover the canonical workflow skills from its supported project-level location

### Requirement: Supported client adapters
Workframe MUST document which AI clients have tested automatic project-level instructions or skills, and MUST distinguish a client adapter from the model selected inside that client.

#### Scenario: Owner uses a supported client
- **WHEN** an owner opens the generated project in Codex, Cursor, Claude Code, Qwen Code or Kimi Code
- **THEN** documentation states which common instructions and optional workflows that client loads automatically

#### Scenario: Owner uses another client or model
- **WHEN** an owner works through an unlisted client, including a client running DeepSeek or another model
- **THEN** documentation explains how to point that client at `AGENTS.md`, `docs/AGENT_WORKFLOW.md`, and the canonical workflow skills without claiming automatic support

### Requirement: Sequential multi-agent handoff
The generated project rules MUST support a task being continued in different agent clients sequentially from repository state.

#### Scenario: Owner switches agent clients
- **WHEN** the owner finishes work in one agent and opens the same repository in another agent
- **THEN** the incoming agent reads the project rules and checks Git and OpenSpec state before continuing

#### Scenario: Cross-client review
- **WHEN** the owner asks a second agent to review changes made by another agent
- **THEN** the review agent applies the same project rules and bases its review on the repository state rather than requiring the first chat history
