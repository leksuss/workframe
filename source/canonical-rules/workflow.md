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

When an agent notices a flaw in a finished block, it appends the improvement to a backlog instead of fixing it inline. The exception is a true blocker — a defect that prevents building the next block — which is fixed immediately as part of the current item.

## Language

OpenSpec artifacts are Russian by default. Technical identifiers stay in English where useful.

## Branches

One OpenSpec change maps to one `feature/<change-id>` branch.

## Safety

Agents never discard user changes, rewrite history, merge, rebase, delete branches, or perform destructive operations unless explicitly requested.

## Design

Design workflow is always available. Pencil MCP is optional. Direct `.pen` edits require Pencil MCP in the current runtime.
