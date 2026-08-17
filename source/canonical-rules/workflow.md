# Canonical Workflow Rules

This is the neutral source for Workframe's project workflow. AI-client adapters should preserve these rules even when their syntax differs.

## Project Constitution

`docs/CONCEPTS.md` defines product purpose, audience, values, anti-goals, journeys, and feature fit criteria.

Agents read it before non-trivial feature work, behavior changes, integrations, redesigns, and refactors.

## OpenSpec

Use OpenSpec for intentional changes that affect behavior, product experience, integrations, data contracts, architecture, or public workflows.

Do not use OpenSpec for tiny cosmetic changes, typo fixes, dependency bumps, or purely internal cleanup unless they affect documented behavior.

## Sequencing

Build a system or a large feature in two phases.

In the skeleton phase, large blocks are built in sequence, each with minimal functionality — enough that the block exists and connects to the next one. The goal is an end-to-end skeleton of the whole system before any block is deepened.

In the depth phase, blocks are filled with features, polished, and deferred improvements are addressed.

Agents follow the plan first: when choosing the next work, they take the next unfinished plan item in order and size each step to a whole block rather than a small edit.

When an agent notices a flaw in a finished block, it appends the improvement to the change's depth-phase backlog instead of fixing it inline. The exception is a true blocker — a defect that prevents building the next block — which is fixed immediately as part of the current item.

That backlog belongs to one change and is archived with it. Improvements still unfinished when the change is archived move to the durable register described in `coherence.md`, so deferred work keeps an address after the change is gone.

## Language

OpenSpec artifacts are Russian by default. Technical identifiers stay in English where useful.

## Branches

One OpenSpec change maps to one `feature/<change-id>` branch.

## Verification

Technology decisions and meaningful technology-surface changes follow the stack-neutral lifecycle in `verification.md`. The same OpenSpec change derives a project-specific quality pipeline from surfaces and risks, implements or updates the applicable checks, and keeps the current commands and modes in `docs/QUALITY.md`.

Blocking checks gate completion. Advisory checks require review and triage but do not fail a change automatically. Skipped or unavailable blocking checks are documented explicitly and never treated as passing by default.

## Coherence

Checks in `verification.md` observe one change. They do not observe what a long series of changes accumulates: dead artifacts, contradictory statements, duplicated documentation, and code that has drifted from its specification.

`coherence.md` covers that state. It defines the truth hierarchy between code, specs, constitution, and descriptive documentation; the read-only status of the archive; which findings an agent repairs on its own and which it only records; the reconcile step before archiving a change; and the durable register where unresolved findings live.

## Safety

Agents never discard user changes, rewrite history, merge, rebase, delete branches, or perform destructive operations unless explicitly requested.

## Design

Design workflow is always available. Pencil MCP is optional. Direct `.pen` edits require Pencil MCP in the current runtime.
