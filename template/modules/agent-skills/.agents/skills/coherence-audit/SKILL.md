---
name: coherence-audit
description: Audit the whole repository for drift accumulated across many changes - contradictory statements, stale artifacts, broken references, and code that no longer matches its specification. Use when the owner asks for a coherence audit or agrees to one you proposed.
license: MIT
compatibility: Requires the project checklist docs/checklists/coherence-audit.md.
metadata:
  author: workframe
  version: "1.0"
---

Audit the repository for accumulated drift.

This workflow is the procedure. It does not describe what to look for — `docs/checklists/coherence-audit.md` does, and it is the only source for the content of the slices. Read it; do not restate it here or work from memory of it.

**Input**: Optionally a scope hint from the owner. If none, audit the whole repository.

## Steps

1. **Confirm the audit was requested**

   An audit is started by the owner, not by you. If you proposed one, confirm they agreed before continuing.

   If the owner has not asked and has not agreed, stop and ask.

2. **Read the sources**

   Read in this order, in full:

   - `docs/checklists/coherence-audit.md` — the slices and what each one looks for;
   - the `Coherence` section of `AGENTS.md` — the truth hierarchy and finding classes;
   - `docs/DEBT.md` — the current register, including every open entry;
   - `docs/CONCEPTS.md` and `docs/QUALITY.md` — what the project is for and how it is verified.

   Do not proceed on a partial read. The classification rules decide what you are allowed to touch.

3. **Prepare the change**

   Confirm the working tree is clean, or ask the owner how to proceed.

   Create the change and a matching branch, for example `coherence-audit-<YYYY-MM>`. The audit's repairs modify the repository and must stay reviewable and revertible.

   Announce the change id and branch.

4. **Run the slices in order**

   Work through the checklist slices in the order it gives them. That order runs from objectively verifiable to requiring judgement, so that a truncated audit loses its least reliable part rather than its most reliable one.

   Slices 1 to 3 are required. Apply the rest in proportion to the project's size and age; state explicitly which ones you applied and which you did not.

   Do not reorder. Do not start with the slice that looks most interesting.

   Exclude `openspec/changes/archive/` from every slice. It is history and is never edited.

5. **Classify before touching anything**

   For each finding, decide its class first, using the test in `AGENTS.md`: can this be resolved without deciding what the product should be?

   - `mechanical` — repair it now, in this change.
   - `semantic` or `structural` — record it in `docs/DEBT.md`. Change nothing.

   Never repair a finding you have not classified. Never record a `mechanical` finding instead of fixing it, and never fix a `semantic` one instead of recording it.

6. **Prove every recorded finding**

   Before writing an entry, quote both sides of the divergence verbatim, with file paths and line numbers.

   If you cannot quote both sides, you do not have a finding. Differing levels of abstraction are not disagreement, and a document that names a placeholder token in order to search for it is not a placeholder.

   Write entries in the format `docs/DEBT.md` specifies, with a fresh `D-<NNN>` identifier.

7. **Revalidate the existing register**

   Re-read every `open` entry recorded before this audit and check whether it still holds.

   - Still valid: leave it `open`.
   - Overtaken by events: set it to `stale` and say what overtook it.
   - Survived several audits without movement: put it to the owner for an explicit decision — resolve it or reject it. Do not leave it silently accumulating.

8. **Report and stop**

   Summarize for the owner:

   - which slices ran and which were skipped, with the reason;
   - what was repaired, as a reviewable list;
   - what was recorded, by class, with the new entry ids;
   - which entries became `stale`, and which need a decision now.

   Propose archive. Do not archive automatically.

## Stop Conditions

Stop and ask the owner when:

- the working tree is dirty and the ownership of the changes is unclear;
- a `mechanical` repair turns out to require a product decision after all — reclassify it and stop;
- a slice reveals that the checklist itself is wrong or incomplete;
- the volume of findings suggests the project needs a different remedy than an audit, such as a deliberate refactor.

## Guardrails

- The checklist is the source for slice content. This file is the source for procedure. Never let one grow into the other.
- Never edit `openspec/changes/archive/`.
- Never rewrite `docs/CONCEPTS.md`.
- Never resolve a specification-versus-code disagreement on your own.
- Never delete an artifact because nothing references it; propose the deletion and let the owner decide.
- An audit that repairs nothing and records nothing is a valid result. Do not manufacture findings to justify the run.
