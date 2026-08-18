# Coherence Audit Checklist

Use this for a full-repository check of accumulated drift. Run it on the owner's decision, as an ordinary OpenSpec change on its own branch, so that its repairs stay reviewable.

This checklist is self-contained: it does not require any skill or tool.

## Before Starting

- Confirm the owner asked for the audit.
- Create the change and branch, for example `coherence-audit-<YYYY-MM>`.
- Read `docs/CONCEPTS.md`, `docs/QUALITY.md`, and `docs/DEBT.md`.
- Note the scope: the whole repository, excluding `openspec/changes/archive/`, which is history and is never edited.

## Ground Rules

- Classify every finding before touching anything: `mechanical`, `semantic`, or `structural`.
- Repair `mechanical` findings directly. Record `semantic` and `structural` findings in `docs/DEBT.md` and change nothing.
- The test: can this be resolved without deciding what the product should be? If not, record and stop.
- Do not record a contradiction you cannot support by quoting both sides verbatim with their locations. Differing levels of abstraction are not disagreement.
- Do not mix repairs and recordings in a way that hides one inside the other; `semantic` findings produce no edits at all.

## Slice 1 — Referential Integrity (required)

- Every file path mentioned in documentation exists.
- Every command shown in documentation is runnable as written.
- Every internal link and anchor resolves.
- Every referenced script, config key, or environment variable exists.

Findings are `mechanical`.

## Slice 2 — Placeholders (required)

- No `TBD`, `TODO`, `FIXME`, or `pending` left from earlier work.
- No unfilled template lines such as `Update ... after ...` or `Replace this row`.
- No section headings with no content under them.
- Check `openspec/specs/` specifically: placeholders created during archive are easy to miss.

Findings are `mechanical`.

A state that an active spec or policy deliberately requires is not a finding. `docs/QUALITY.md` ships its pipeline as `pending stack selection` with a placeholder table row until the project selects a stack, because the verification lifecycle requires exactly that; flagging it every audit is a false result, not a discovery.

A document that names these tokens in order to search for them — this checklist, the rules that define it — is not a finding. Match the token as leftover work, not as a quoted search target.

## Slice 3 — Declared Against Actual (required)

- Files and directories promised by README tables exist, and existing ones are described.
- Commands and modes in `docs/QUALITY.md` match what the project actually runs.
- Entries in `docs/DEBT.md` still point at real locations.
- Setup and installation instructions produce the described result.

Findings are usually `mechanical`; a promise that reflects an abandoned decision is `semantic`.

## Slice 4 — Specs Against Code

- Every requirement in `openspec/specs/` has an observable implementation.
- Notable behavior in the code has a corresponding requirement.
- Scenarios describe what the system does now, not what an earlier change intended.

Findings are `semantic`. Record both sides; repair neither.

## Slice 5 — Duplication And Divergence

- One statement kept in two places: either the copies have drifted, or one should reference the other.
- Rules repeated across `AGENTS.md`, `docs/AGENT_WORKFLOW.md`, and checklists still agree.
- Client adapters and canonical instructions have not diverged.

Verbatim duplication is `mechanical`; drifted copies stating different things are `semantic`.

## Slice 6 — Dead Artifacts

- Files, modules, and artifacts with no inbound references.
- Configuration for tools no longer used.
- Documentation for behavior that no longer exists.

Findings are `semantic`. Missing references do not prove the artifact is unused, and deletion is irreversible — propose, do not delete.

## Slice 7 — Structure

- Files that have grown past what one file should hold.
- Responsibilities that have blurred across module boundaries.
- Logic duplicated across places that should share it.

Findings are `structural`. Record them; refactoring is a separate change.

## Proportionality

Slices 1 to 3 are always required: they are cheap and objectively verifiable. Apply slices 4 to 7 in proportion to the project's size and age. A small project may finish an audit in one pass with nothing to record.

## Finishing

- Revalidate open entries in `docs/DEBT.md`; mark entries overtaken by events as `stale`.
- Put any entry that has survived several audits without movement to the owner for an explicit decision.
- Record new `semantic` and `structural` findings with both sides quoted.
- Re-open every location the new entries cite and confirm it exists and says what the entry claims; repairs made earlier in the same run shift line numbers.
- Summarize for the owner: what was repaired, what was recorded, what needs a decision.
- Propose archive; do not archive automatically.
