# Agent Workflow

This document describes the neutral project workflow. Tool-specific files such as `AGENTS.md`, `CLAUDE.md`, or editor rules should adapt this workflow without changing its intent.

## Operating Model

The project is guided by three layers:

1. `docs/CONCEPTS.md` defines what the project is for.
2. OpenSpec changes define intentional product and behavior changes.
3. Code, tests, documentation, and design artifacts implement those decisions.

The order matters. Do not let implementation convenience quietly rewrite product direction.

## Change Size

Tiny changes can be made directly:

- typo fixes;
- comments and internal cleanup;
- small cosmetic adjustments;
- dependency bumps that do not change behavior.

Non-trivial changes should go through OpenSpec:

- feature work;
- behavior changes;
- integrations;
- refactors that affect public or cross-module behavior;
- database, schema, routing, protocol, or data contract changes;
- visual redesigns that change product experience.

## Language

Write OpenSpec artifacts in Russian by default.

Keep these in English when clearer:

- commands;
- file paths;
- branch names;
- code symbols;
- API names;
- capability ids;
- model names;
- framework terms.

## Change Lifecycle

1. Explore the idea and consult `docs/CONCEPTS.md`.
2. Create an OpenSpec change and matching `feature/<change-id>` branch.
3. Write proposal, design notes when useful, spec deltas, and tasks.
4. Implement only after the user asks to proceed.
5. Keep OpenSpec artifacts aligned with real decisions.
6. Run blocking checks and review advisory checks declared in `docs/QUALITY.md`.
7. Propose archive when complete.
8. Archive and merge only when explicitly requested.

## Quality Pipeline

`docs/QUALITY.md` is the current source of truth for project checks and canonical commands. OpenSpec changes record why the policy changes; the quality document records how verification works now.

Derive the pipeline instead of copying a standard tool list:

```
technology surface → failure modes and risks → check classes → tools and commands
```

When a change first introduces or materially changes an executable language, runtime, component, storage system, public contract, deployment surface, or similar technology surface:

1. Describe the affected surfaces and risks in the change design.
2. Decide which checks are `blocking`, `advisory`, or `not applicable`.
3. Add implementation and documentation of the smallest useful pipeline to the same change tasks.
4. Build those checks early enough that the rest of the change can use them.
5. Update `docs/QUALITY.md` with canonical commands, triggers, prerequisites, and exclusions.

A normal change that does not alter the technology surface follows the existing policy without selecting tools again.

Keep policy modes separate from run results. A run is `passed`, `failed`, `skipped`, or `unavailable`; skipped or unavailable blocking checks require a reason and are not passing by default. Review advisory findings as `confirmed`, `false positive`, or `deferred` before proposing archive.

Use verification levels in proportion to the project:

- fast local checks during implementation;
- change checks for affected surfaces;
- full or release checks for the integrated project;
- periodic audits for broad, slow, or heuristic advisory analysis.

Small projects may combine levels. Legacy projects may adopt baselines or changed-scope enforcement. Polyglot repositories may need per-surface commands and an aggregate entry point. Generated, vendored, temporary, environment-dependent, slow, or flaky checks require explicit handling in `docs/QUALITY.md`.

## Task Design And Handoffs

Treat `tasks.md` as a handoff contract: one agent plans the change, another can implement it, and a reviewer can verify the result without reconstructing unstated decisions.

For every non-atomic task, state the expected result, affected area, material constraints, and verification method. A short precise reference to a settled decision in `proposal.md`, `design.md`, or a spec is sufficient; do not duplicate the whole design. If completing a task would require a new product or architectural choice, record that choice in the relevant OpenSpec artifact before implementation.

Keep a large block as the top-level unit, then split its dependent work into ordered substeps when this reduces ambiguity. Normally put contracts and skeleton work first, implementation next, then checks and documentation. Do not manufacture microtasks for an atomic change.

For example:

```
## 1. Session authentication

- [ ] 1.1 Define the session model and login contract in `design.md` and `specs/session-auth/spec.md`; verify both artifacts describe expiry and invalid credentials.
- [ ] 1.2 Implement the login endpoint in `src/auth/`; use the approved session contract; verify successful and invalid-credential tests.
- [ ] 1.3 Protect the account route in `src/routes/`; verify unauthenticated access is rejected.
- [ ] 1.4 Update public API documentation; verify documented responses match the endpoint tests.
```

When reviewing a completed change, check each task against its stated result and verification method, not only whether its checkbox is marked.

## Work Sequencing

Build a system or a large feature in two phases.

**Skeleton phase.** Build large blocks in sequence, each with minimal functionality — enough that the block exists and connects to the next one. Reach an end-to-end skeleton of the whole system before any block is deepened.

**Depth phase.** Fill blocks with features, polish them, and address deferred improvements.

When choosing the next work, follow the plan: take the next unfinished `tasks.md` item in order, and size each step to a whole block rather than a small edit. When you notice a flaw in a finished block, append it to the backlog instead of fixing it inline; fix it immediately only when it blocks building the next block.

For a system or a large task, `tasks.md` uses two explicit sections:

```
## Фаза 1. Каркас
- [ ] 1. Block A — minimal functionality
- [ ] 2. Block B — minimal functionality

## Фаза 2. Углубление
- [ ] 1.x  Deepen and polish block A
- [ ] (accumulates during work)
```

The depth section doubles as the backlog for deferred improvements and may start empty. A small change that does not build a system may keep `tasks.md` as a flat list.

## Existing Work

Agents must assume uncommitted changes may belong to the user.

Never discard, reset, overwrite, or revert user changes unless explicitly requested. When a user change intersects the current work, adapt to it and ask only if progress would be unsafe or ambiguous.

## Design Work

Design work can involve code, images, design tools, screenshots, or written design decisions.

When a design artifact exists, treat it as the visual source of truth for layout, hierarchy, sizing, spacing, tokens, and approved content. Quality guidance may improve polish, accessibility, responsiveness, and state completeness without silently changing the approved design direction.

When no design artifact exists, use existing product UI, `docs/CONCEPTS.md`, user direction, and target audience as the source of truth.
