# Agent Instructions

Use this file as the operating rules for AI agents working on Workframe itself.

Workframe is the reusable project workflow scaffold. Do not confuse root project files with payload files under `template/`.

## Project Context

When `docs/CONCEPTS.md` exists, treat it as the Workframe constitution:

- Read it before non-trivial feature work, behavior changes, integrations, redesigns, and refactors.
- Use it to evaluate whether a proposed change fits Workframe's purpose, audience, anti-goals, and feature-fit criteria.
- Do not rewrite it unless the user explicitly asks.

Important source boundaries:

- Root `AGENTS.md`, `docs/`, `openspec/`, and `.codex/` govern work on this repository.
- `template/base/` is payload copied into new projects.
- `template/modules/` contains optional payload modules.
- `source/` contains canonical rules and client adapter notes used to evolve the payload.
- `examples/` is documentation and must not be copied into new projects by default.

## Feature Workflow

For non-trivial Workframe feature work, behavior changes, integrations, and refactors, use OpenSpec.

Do not use OpenSpec for tiny typo fixes, small README clarifications, dependency bumps, or purely internal cleanup unless they change documented behavior.

Before implementation:

- Start an OpenSpec change using the project's OpenSpec workflow.
- Choose a concise change id automatically unless the user provides one.
- Include how the change fits or conflicts with `docs/CONCEPTS.md`.
- Check `docs/DEBT.md` for open entries in the area this change will touch, and offer the applicable ones to the user.
- Do not write implementation code from an OpenSpec proposal step unless the user explicitly asks to proceed.

During implementation:

- Follow the active OpenSpec change.
- Keep the active OpenSpec change artifacts up to date when scope, requirements, or implementation decisions change.
- Keep root governance files and `template/` payload files clearly separated.

After implementation:

- Run the relevant checks for the changed area.
- Verify that the active OpenSpec change reflects the implemented behavior.
- Run the reconcile step described under `Coherence` before proposing archive.
- For every completed non-trivial Workframe change, choose the SemVer impact (`PATCH` for a compatible fix, `MINOR` for a compatible capability, `MAJOR` for a breaking required payload or workflow change), update root `VERSION`, and move its `CHANGELOG.md` entries into a dated release section before proposing archive.
- Propose archiving the OpenSpec change when the work is complete and verified.
- Do not archive automatically unless the user explicitly asks for it.

## OpenSpec Task Design

Treat `tasks.md` as a handoff contract between the agent that plans a change, the agent that implements it, and the agent that reviews it.

- Decompose non-atomic work until an implementer can complete a task without inventing a product or architectural decision.
- Each such task must state the expected result, affected area, material constraints, and verification method. It may refer precisely to the relevant proposal, design, or spec instead of repeating settled decisions.
- Keep large blocks visible at the top level, and use ordered substeps (`1.1`, `1.2`, ...) where they reduce uncertainty. Put contracts and skeleton work before implementation, then checks and documentation.
- Do not manufacture microtasks for an already atomic change. If a required decision is missing, update the OpenSpec artifacts or ask for clarification before implementation.
- Before completion, verify the implementation against each task's expected result and verification method, not just its checkbox.

## Work Sequencing

Build systems and large features in two phases.

Skeleton phase: build large blocks in sequence, each with minimal functionality — enough that the block exists and connects to the next one — until the whole system has an end-to-end skeleton.

Depth phase: fill blocks with features, polish them, and address deferred improvements.

When choosing the next work:

- Check the plan first. Take the next unfinished item in `tasks.md`, in order. Do not move to the depth phase before the skeleton phase is complete.
- Size each step to a whole block, not a small edit. The step should visibly advance toward the goal.
- When you notice a flaw in a finished block, append it to the `## Фаза 2. Углубление` section of `tasks.md` instead of fixing it inline.
- Fix a flaw immediately only when it is a true blocker — a defect that prevents building the next block. Then it is part of the current item, not a deferred improvement.
- Move any `## Фаза 2. Углубление` item still unfinished to `docs/DEBT.md` before the change is archived. That section is archived with the change; the register is not.

## OpenSpec And Git Branches

Use one OpenSpec change per git branch.

When starting a new OpenSpec change:

- Choose a concise change id automatically unless the user provides one.
- Create or switch to a matching git branch named `feature/<change-id>`.
- Keep all implementation work for that change on that branch.
- Do not mix unrelated OpenSpec changes in the same branch.

When applying an OpenSpec change:

- Confirm the current branch matches the active change id.
- If the current branch is `feature/<change-id>`, treat `<change-id>` as the active OpenSpec change.
- If the current branch does not clearly identify an active OpenSpec change, ask the user which change to continue.

When resuming work in a new context:

- Check the current git branch.
- If it is named `feature/<change-id>` and `openspec/changes/<change-id>/` exists, continue that OpenSpec change.
- If multiple active OpenSpec changes exist and the current branch does not identify one clearly, ask the user which change to continue.

When the change is complete:

- Propose archiving the OpenSpec change.
- Do not archive automatically unless the user explicitly asks.
- Dates in archive directory names are UTC. Near midnight they can differ from the local date; that is expected and is not corrected.
- When the user explicitly asks to archive a completed change, archive it, sync specs, commit the archive result, switch to `main`, merge the completed feature branch into `main`, and leave `main` as the current branch for the next change.
- New OpenSpec changes should start from the current `main`, not from a previous feature branch.
- After archive and merge, the user may push or create a pull request.

## Git Safety

Never merge, rebase, delete branches, reset history, or discard changes unless the user explicitly asks.

Before creating or switching branches:

- Tell the user what branch you intend to use.
- Do not switch branches if there are uncommitted changes that could be affected; ask the user how to proceed.

Do not revert user changes unless the user explicitly asks.

## Documentation Discipline

Keep documentation close to actual behavior.

Write OpenSpec artifacts in Russian by default, because the project owner reads them continuously.
Keep technical identifiers, filenames, paths, branch names, capability names, model names, commands, and code symbols in English where appropriate.

When implementation differs from the active OpenSpec change:

- Update the OpenSpec change artifacts to match the real decision.
- Do not leave stale requirements, tasks, or design notes.

When a change modifies generated project payload behavior:

- Update `template/` files.
- Update root docs and `source/` notes when they explain that behavior.
- Consider whether `README.md`, `README.ru.md`, `docs/UPGRADING.md`, or `CHANGELOG.md` need changes.

Prefer concise, concrete documentation over broad abstract statements.

## Workframe Versioning

Root `VERSION` is the single source of the current Workframe scaffold version and uses Semantic Versioning `MAJOR.MINOR.PATCH`.

- `PATCH` is a backwards-compatible fix.
- `MINOR` is a backwards-compatible capability or workflow addition.
- `MAJOR` is an incompatible change to required payload or workflow.

Every completed non-trivial Workframe change releases one chosen version before archive. Record the version and release date in `CHANGELOG.md`; leave a fresh `Unreleased` section for the next change. After committing the release, create an annotated Git tag `v<VERSION>` on that release commit. `VERSION` remains the source of the current version; a tag makes a released state retrievable later.

## Coherence

A long series of changes accumulates dead artifacts, contradictory statements, duplicated documentation, and payload that has drifted from the rules describing it. These rules keep that state observable. The neutral source is `source/canonical-rules/coherence.md`.

### Truth Hierarchy

Artifacts do not carry equal authority: payload and scripts describe what Workframe actually produces; `openspec/specs/` describes what it should produce; `docs/CONCEPTS.md` describes why Workframe exists; README files, `docs/UPGRADING.md`, and `source/` notes describe how it works and is explained.

- Descriptive documentation that contradicts payload or an active spec follows the payload. Repair the documentation.
- A spec that contradicts the payload is not resolved on your own. Either the spec is stale or the payload drifted; choosing is a product decision.
- Anything that contradicts `docs/CONCEPTS.md` goes to the user.

### The Archive Is History

`openspec/changes/archive/` records what was true when it was written. Never edit archived artifacts. A disagreement between an archived note and a current spec is not a finding.

### Finding Classes

Classify before repairing anything:

- `mechanical`: broken paths and links, placeholders, references to removed entities, stale commands, verbatim duplication. Repair immediately.
- `semantic`: a contradiction between statements, or between a spec and the payload. Record in `docs/DEBT.md`; do not repair.
- `structural`: refactoring is required. Record in `docs/DEBT.md`; do not repair.

The test: can this be resolved without deciding what Workframe should be? If not, record it and stop.

Do not record a suspected contradiction you cannot support by quoting both sides verbatim with their locations.

### Root And Template Boundary

An audit covers root governance files, `source/`, `scripts/`, `examples/`, and `template/` payload. Keep the boundary intact while auditing:

- A finding inside `template/` is about the payload's own consistency — its rules, docs, and adapters agreeing with each other. It is not a finding about any project generated from it.
- A rule that changed in root `AGENTS.md` is not automatically a finding in `template/base/AGENTS.md`. The two are allowed to differ where generated-project behavior should differ.
- Generated projects are never modified by a Workframe audit. Existing projects adopt changes only through their own OpenSpec change, per `docs/UPGRADING.md`.

### Reconcile Before Archive

Before proposing archive, check the artifacts this change touched:

- specs describe the final behavior;
- no placeholders remain in artifacts this change created or modified, including specs it synced;
- entities this change removed are gone from all references;
- payload, `source/` notes, READMEs, and `docs/UPGRADING.md` agree about what the change did;
- unfinished `## Фаза 2. Углубление` items have moved to `docs/DEBT.md`.

Repair `mechanical` findings before proposing archive. Record the rest.

### Audit

A full-repository audit covers referential integrity, placeholders, declared-against-actual, specs against payload, duplication, dead artifacts, and structure — in that order, because the reliable slices must not be the ones abandoned when attention runs out. The first three are always required.

The procedure is the one shipped to projects in `template/base/docs/checklists/coherence-audit.md`, read with the root-and-template boundary above in mind. File an audit that changed documented behavior as an ordinary change. File one that changed no requirements and repaired only `mechanical` findings as a direct change — it is purely internal cleanup. Either way keep it on its own branch as its own commit. Propose an audit when you see accumulated drift; do not start one on your own.

### The Register

`docs/DEBT.md` holds `semantic` and `structural` findings plus deferred work that outlived its change. Fill it during reconcile and audits, check it when planning a change, mark overtaken entries `stale`, and close entries only with a change id or an explicit user decision.

## Bootstrap Note

The first Workframe commit was created before Workframe had its own root OpenSpec. Treat `bootstrap-workframe-governance` as the explicit transition point after which Workframe governs itself through this workflow.
