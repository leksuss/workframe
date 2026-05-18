# Canonical Workflow Rules

This is the neutral source for Workframe's project workflow. AI-client adapters should preserve these rules even when their syntax differs.

## Project Constitution

`docs/CONCEPTS.md` defines product purpose, audience, values, anti-goals, journeys, and feature fit criteria.

Agents read it before non-trivial feature work, behavior changes, integrations, redesigns, and refactors.

## OpenSpec

Use OpenSpec for intentional changes that affect behavior, product experience, integrations, data contracts, architecture, or public workflows.

Do not use OpenSpec for tiny cosmetic changes, typo fixes, dependency bumps, or purely internal cleanup unless they affect documented behavior.

## Language

OpenSpec artifacts are Russian by default. Technical identifiers stay in English where useful.

## Branches

One OpenSpec change maps to one `feature/<change-id>` branch.

## Safety

Agents never discard user changes, rewrite history, merge, rebase, delete branches, or perform destructive operations unless explicitly requested.

## Design

Design workflow is always available. Pencil MCP is optional. Direct `.pen` edits require Pencil MCP in the current runtime.
