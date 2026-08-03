# owner-led-project-start Specification

## Purpose

Describe the owner-facing path from a project idea to an approved first implementation.

## Requirements

### Requirement: Owner-led initialization guidance
Workframe README files MUST describe a first-project journey in which the owner runs the scaffold, opens the target project in an AI agent, discusses the product idea, and confirms the product decisions that the agent records.

#### Scenario: Owner starts from an idea
- **WHEN** an owner follows the quick-start documentation for a new project
- **THEN** it instructs them to discuss users, value, boundaries and anti-goals with the agent before serious implementation

#### Scenario: Agent records agreed direction
- **WHEN** the initial discovery conversation reaches agreed product decisions
- **THEN** documentation identifies the agent, not the owner, as the party that writes `docs/CONCEPTS.md` from those confirmed decisions

#### Scenario: Agent proposes the first change
- **WHEN** the product direction is recorded
- **THEN** the agent proactively offers to prepare the first OpenSpec change
- **AND** documentation states that implementation needs explicit approval after the owner reviews its plan
