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
6. Run relevant checks.
7. Propose archive when complete.
8. Archive and merge only when explicitly requested.

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
