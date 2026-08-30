# Feature Change Checklist

Use this checklist before and during non-trivial product or behavior changes.

## Before Proposal

- Read `docs/CONCEPTS.md`.
- Read the current project policy in `docs/QUALITY.md`.
- Check `docs/DEBT.md` for open entries in the affected area.
- Identify the user journey affected by the change.
- Decide whether OpenSpec is required.
- Check the current git branch and uncommitted changes.
- Choose a concise change id.
- Classify the change as `atomic low-risk`, `behavior`, `high-risk boundary`, or `release/certification` by its highest-risk affected surface.

## Proposal

- Explain why the change matters.
- Explain how it fits or conflicts with `docs/CONCEPTS.md`.
- Define the behavior change concretely.
- Note important non-goals.
- Add tasks that can be verified and, when non-atomic, state the expected result, affected area, material constraints, and verification method or a precise OpenSpec reference.
- For every non-atomic task, name the production surface or ownership path and any protective boundary its verification must exercise.
- For `behavior` and higher levels, record requirement/scenario → production path → test/check/evidence → result; make the record explicit for high-risk and release/certification changes.
- Define positive verification for the exact required outcome. Add risk-based negative/adversarial scenarios for protective boundaries.
- When certification evidence will persist, define the independent verifier or explain why a separate verifier is disproportionate and name the independent check used instead.
- Split a large block into ordered substeps when this prevents the implementer from inventing a product or architectural decision; do not manufacture microtasks for atomic work.
- If the change introduces or materially changes a technology surface, derive checks from its risks and include pipeline work in design and tasks.

## Implementation

- Confirm the branch matches the active change id.
- Keep changes scoped to the proposal.
- Update OpenSpec artifacts if real decisions change.
- Add or update tests in proportion to risk.
- Exercise the real production ownership path required by the task; do not substitute a mock for a required loopback/integration path.
- Cover relevant direct API/server paths and alternative CLI, console, supervisor/child, restart/resume, or embedding paths rather than testing only a UI or facade.
- For resource bounds, verify enforcement during streaming/consumption rather than only after full materialization.
- For access control, verify required allow-lists as well as permissions; for readiness/default behavior, verify absent or unknown dependencies fail closed.
- Implement or update declared quality checks early enough for the remaining work to use them.
- Keep `docs/QUALITY.md` aligned with actual commands, modes, triggers, prerequisites, and exclusions.
- Update nearby documentation when behavior changes.

## Verification

- Run blocking checks declared for the affected surfaces.
- Record each result as `passed`, `failed`, `skipped`, or `unavailable`; explain skipped or unavailable blocking checks.
- Preserve the first failed result when a rerun passes; diagnose it in isolation, then rerun the complete blocking gate and classify confirmed flakiness under `docs/QUALITY.md`.
- Review applicable advisory checks and triage findings as `confirmed`, `false positive`, or `deferred`.
- Verify the implemented behavior matches the OpenSpec change.
- For every completed task, verify its exact stated outcome, production path, implementation, evidence, and result rather than relying on its checkbox or an aggregate green suite.
- Re-open persisted certification evidence through the independent verifier and test applicable stale/tampered/fail-closed cases.
- Record the exact tracked revision for final release/certification evidence; rerun the blocking gate after any later tracked commit.
- Perform manual verification where automation does not cover the risk.
- Perform a fresh adversarial review of proposal, design, specs, tasks, final diff, and results without trusting checkboxes. For high-risk changes, use another agent/model or an equivalent isolated review context and record which.
- Reconcile artifacts touched by the change; repair `mechanical` findings and record `semantic` or `structural` findings in `docs/DEBT.md`.
- Propose archive when complete.
