# Canonical Coherence Rules

This is the neutral source for keeping a repository internally consistent across a long series of changes. It defines how to resolve conflicts between artifacts, what an agent may repair on its own, and where unresolved findings live.

Individual changes are governed by `workflow.md`. Individual checks are governed by `verification.md`. This document governs the accumulated state that neither of them observes.

## Why Coherence Needs Its Own Rules

Every rule about a single change looks forward: keep artifacts current, do not leave stale requirements. None of them looks back at the sum of completed changes.

A repository can therefore satisfy every change-level rule and still accumulate dead artifacts, contradictory statements, duplicated documentation, broken references, and code that no longer matches its specification. Discipline without periodic reconciliation degrades by definition.

## Truth Hierarchy

Project artifacts answer different questions and do not carry equal authority:

1. Code and passing checks — what the system actually does.
2. `openspec/specs/` — what it is supposed to do.
3. `docs/CONCEPTS.md` — why it exists.
4. `docs/QUALITY.md`, README files, and other descriptive documentation — how it is verified and explained.

Conflict resolution depends on which pair disagrees. It does not reduce to "the lower level always wins", because that rule would silently promote every bug into a specification.

- Descriptive documentation that contradicts code or an active specification follows the behavior. The agent repairs the documentation.
- A specification that contradicts the code is not resolved by the agent. Either the specification is stale or the code has drifted, and choosing between those is a product decision.
- Anything that contradicts `docs/CONCEPTS.md` goes to the owner. The constitution is never rewritten without an explicit request.

## The Archive Is History

`openspec/changes/archive/` records decisions that were true when they were made. It is not a set of standing statements.

Dates in archive directory names are UTC, so the history stays comparable no matter which timezone the work was archived from. Near midnight the archive date and the local date differ; that is expected.

Archived artifacts are never edited, including during an audit. A disagreement between an archived design note and a current specification is not a finding; it is the archive doing its job.

Without this rule an agent reads old design notes as current commitments, and a mature repository generates contradictions faster than anyone can resolve them.

## Finding Classes

Every coherence finding is classified before anything is repaired:

- `mechanical`: objectively verifiable and repaired immediately. Broken paths and links, placeholders, references to removed entities, stale commands, verbatim duplication.
- `semantic`: a contradiction between statements, or between a specification and the code. Recorded, not repaired.
- `structural`: refactoring is required. An overgrown file, blurred boundaries, duplicated logic. Recorded, not repaired.

One test separates the first class from the other two: **can the finding be resolved without deciding what the product should be?** If it cannot, the agent records it and stops.

An artifact with no inbound references is `semantic`, not `mechanical`. Absence of references is not proof of uselessness, and deletion is irreversible.

## Two Levels

**Reconcile.** Runs before an agent proposes to archive a change. Its scope is limited to the artifacts that change touched. It confirms that specifications describe the final behavior, that created or modified artifacts contain no placeholders, that removed entities are gone from all references, and that unfinished deferred improvements have been moved into the durable register.

Reconcile is expressed as a project rule. Where a project uses vendored upstream workflow skills, those skills are not modified to carry it; forking them would create the same class of drift these rules exist to remove.

**Audit.** Covers the whole repository and runs on the owner's decision. An agent may propose an audit; it does not start one on its own.

How it is filed depends on what it changed. An audit that alters documented behavior is an ordinary change with its own artifacts. An audit that changed no requirements and repaired only `mechanical` findings is purely internal cleanup and is filed as a direct change without that ceremony — there is no decision for a proposal to record. Either way it stays on its own branch as its own commit, and findings it did not repair go to the register.

## Audit Slices

Ordered from objectively verifiable to requiring judgement:

1. Referential integrity — every path, file, command, and anchor that documentation mentions exists.
2. Placeholders — `TBD`, `TODO`, `pending`, and unfilled template lines.
3. Declared against actual — what README files, quality policy, and payload tables promise is what the repository contains.
4. Specifications against code — every requirement has an observable implementation, and notable behavior has a requirement.
5. Duplication and divergence — one statement kept in two places.
6. Dead artifacts — files, code, or artifacts with no inbound references.
7. Structure — overgrown files, blurred boundaries, duplicated logic.

The order is load-bearing. When attention or context runs out, the subjective slices are the ones abandoned, and the reliable ones are already done.

Slices 1 to 3 are always required; they are cheap and objective. Slices 4 to 7 apply in proportion to the project. A small project may complete an audit in a single pass with an empty result.

A suspected contradiction that cannot be supported by quoting both sides verbatim, with their locations, is not recorded. Agents reliably mistake differing levels of abstraction for disagreement.

## The Durable Register

Findings of class `semantic` and `structural`, together with deferred improvements that outlive their change, live in a permanent project file rather than inside change artifacts.

Deferred work kept only in a change's task list disappears into the archive with it. The register is the address that survives.

Each entry records an identifier, class, discovery date and source, the exact location with both sides of the divergence, the available resolutions, and a status: `open`, `accepted` with a change id, `resolved` with a change id, `rejected` with a reason, or `stale`.

Four rules keep the register useful:

- It is filled by reconcile and by audits.
- It is spent during planning. Before starting a change, the agent checks for open entries in the area the change will touch anyway. This is the only way debt is repaid in practice.
- It is revalidated by every audit; entries overtaken by events become `stale`. The register does not grow monotonically.
- It does not become a dumping ground. An entry that survives several audits without movement is put to the owner for an explicit decision.

A project with no findings carries no cost: the register ships empty.

## Proportionality

Coherence work scales down. Reconcile costs minutes. Slices 1 to 3 are mechanical. The register starts empty and stays empty until something real is found.

Nothing here is scheduled, automated, or enforced by tooling. A project should not carry more coherence process than its size justifies.
