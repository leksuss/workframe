# Canonical Workflow Rules

This is the neutral source for Workframe's project workflow. AI-client adapters should preserve these rules even when their syntax differs.

## Instruction Loading

Keep scope, safety invariants, and exact workflow triggers in the automatically loaded project entry point. Keep detailed procedures in canonical workflow documents or skills that ship with the project, and require the agent to read them in full when their trigger occurs. Do not load every procedure for a simple request or copy a shortened procedure beside its canonical source.

Trigger uncertainty fails closed: if the agent is unsure whether a trigger applies, it treats the trigger as applicable and loads the referenced instructions before acting.

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

This sequencing does not waive the current-change regression gate in `coherence.md`: fix and verify regressions before acceptance or archive, or obtain an explicit owner decision permitting deferral with documented consequences.

That backlog belongs to one change and is archived with it. Improvements still unfinished when the change is archived move to the durable register described in `coherence.md`, so deferred work keeps an address after the change is gone.

## Language

OpenSpec artifacts are Russian by default. Technical identifiers stay in English where useful.

## Branches

One OpenSpec change maps to one `feature/<change-id>` branch.

## Verification

Technology decisions and meaningful technology-surface changes follow the stack-neutral lifecycle in `verification.md`. The same OpenSpec change derives a project-specific quality pipeline from surfaces and risks, implements or updates the applicable checks, and keeps the current commands and modes in `docs/QUALITY.md`.

Blocking checks gate completion. Advisory checks require review and triage but do not fail a change automatically. Skipped or unavailable blocking checks are documented explicitly and never treated as passing by default.

The change follows a contract-driven evidence chain: requirement → production ownership path → positive verification → risk-based negative/adversarial verification → recorded result → independent review → archive decision. A task checkbox records that its declared method ran and proved the exact expected outcome, not merely that implementation exists or an aggregate suite is green.

Scale the record to the highest risk. An atomic low-risk change needs only an obvious change/result/check link. A behavior change traces changed requirements to production paths and evidence. A high-risk boundary change makes traceability explicit, covers applicable bypass and alternative ownership paths, and receives an independent final review context. A release or certification change also re-verifies persisted evidence independently and binds it to the exact tracked revision.

Before archive, re-read proposal, design, specs, tasks, final diff, and results without trusting checkboxes. A tracked commit after final evidence makes that evidence stale. If a failed blocking check later passes once, keep the first failure, diagnose it in isolation, and rerun the full blocking gate rather than reporting the rerun alone.

## Coherence

Checks in `verification.md` observe one change. They do not observe what a long series of changes accumulates: dead artifacts, contradictory statements, duplicated documentation, and code that has drifted from its specification.

`coherence.md` covers that state. It defines the truth hierarchy between code, specs, constitution, and descriptive documentation; the read-only status of the archive; which findings an agent repairs on its own and which it only records; the reconcile step before archiving a change; and the durable register where unresolved findings live.

## Payload

Project rules, workflow documents, checklists, and workflow skills arrive from Workframe. Every file that arrives is addressed by a rule that arrives with it; a file no shipped rule points to never reaches the agent that should use it.

Upgrading to a newer Workframe version is an ordinary change inside the project. Canonical files are copied whole rather than restated, the version marker records what was applied and what was deliberately skipped, and the change ends with the project's canonical files byte-identical to the target version's template.

Rules the project decides for itself live in the project's own rules file, never as an edit to a canonical file: an edited canonical file cannot be told apart from a paraphrased one.

## Safety

Agents never discard user changes, rewrite history, merge, rebase, delete branches, or perform destructive operations unless explicitly requested.

## Design

Design workflow is always available. Pencil MCP is optional. Direct `.pen` edits require Pencil MCP in the current runtime.
