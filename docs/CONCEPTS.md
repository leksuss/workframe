# Workframe Concepts

## Purpose

Workframe exists to make AI-assisted software projects easier to start, steer, and maintain without tying the project to a specific AI provider or application framework.

It provides a reusable operating frame for new projects: project concepts, agent rules, OpenSpec workflow, design discipline, upgrade policy, and optional modules for specific AI-client or design workflows.

Workframe should help the project owner preserve the useful working practices discovered in real projects while separating universal process from project-specific product decisions.

## Audience

The initial audience is one technical owner who regularly starts and maintains different software projects with AI assistance.

The owner is comfortable with Git, Markdown, command-line tools, code review, and occasional manual setup. They want a durable workflow scaffold that keeps AI agents productive without hiding important project decisions in a vendor-specific tool.

Future users may include other developers adopting the same workflow, but the first version should optimize for clarity, inspectability, and easy manual adaptation.

## Core Value

Workframe's core value is portable project discipline: reusable AI-assisted workflow rules that can be copied, inspected, adapted, versioned, and upgraded deliberately across unrelated software projects.

The scaffold should make projects more coherent without making every project share the same product values, architecture, or implementation stack.

## Product Principles

- Workframe should be provider-neutral. Codex-specific files are adapters, not the canonical idea.
- Project-specific concepts belong in the target project's `docs/CONCEPTS.md`, not in Workframe's universal rules.
- The copied payload should stay small enough to understand and edit manually.
- Automation should make setup repeatable without hiding decisions from the owner.
- Existing projects should not auto-upgrade. Upgrades should be explicit, reviewable project changes.
- OpenSpec artifacts should be Russian by default, while technical identifiers remain English where appropriate.
- Design discipline should be available by default, but direct Pencil MCP editing should require runtime availability.
- Examples and profiles should teach adaptation, not become cargo-cult files copied into every project.

## Anti-Goals

- Workframe is not an application framework.
- Workframe is not an AI provider SDK.
- Workframe is not only for Codex, Claude, Cursor, or any single agent runtime.
- Workframe should not copy product-specific specs, histories, or values from one project into unrelated projects.
- Workframe should not automatically rewrite existing projects when the template evolves.
- Workframe should not require every project to use every optional module.
- Workframe should not make process heavier than the project can justify.

## Key User Journeys

### Start A New Project

The owner creates a repository, runs the Workframe init script or copies the base payload, chooses optional modules, fills `docs/CONCEPTS.md`, commits the scaffold, and starts the first real change through OpenSpec.

### Adapt Workflow To A Project Type

The owner reads a profile such as `django-app`, `telegram-bot`, or `scraper-service`, then adapts the base checklist and concepts without copying irrelevant example content.

### Upgrade An Existing Project

The owner reviews Workframe changes, creates an OpenSpec change in the target project, applies only relevant workflow updates, preserves project-specific rules, updates `.project-workframe-version`, verifies the result, and commits the upgrade.

### Evolve Workframe Itself

The owner changes Workframe through its own OpenSpec workflow, keeping root governance files separate from copied template payload and documenting behavior that affects generated projects.

## Feature Fit Criteria

A feature fits Workframe when it clearly improves at least one of these outcomes:

- makes new project initialization clearer or more repeatable;
- strengthens AI-agent safety and usefulness across different project types;
- separates universal workflow from project-specific product decisions;
- improves OpenSpec, git, documentation, design, or upgrade discipline;
- makes optional modules easier to understand, install, or skip;
- keeps generated project payload small, inspectable, and manually editable;
- helps existing projects upgrade deliberately without surprise.

A feature is suspect when it:

- ties Workframe to one AI provider or runtime as the only supported path;
- adds product-domain assumptions that belong in a target project's `docs/CONCEPTS.md`;
- copies examples, archived decisions, or project history into every new project;
- makes setup automation opaque or hard to audit;
- forces optional modules on projects that do not need them;
- optimizes for template elegance while making target projects harder to understand.
