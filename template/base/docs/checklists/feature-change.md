# Feature Change Checklist

Use this checklist before and during non-trivial product or behavior changes.

## Before Proposal

- Read `docs/CONCEPTS.md`.
- Read the current project policy in `docs/QUALITY.md`.
- Identify the user journey affected by the change.
- Decide whether OpenSpec is required.
- Check the current git branch and uncommitted changes.
- Choose a concise change id.

## Proposal

- Explain why the change matters.
- Explain how it fits or conflicts with `docs/CONCEPTS.md`.
- Define the behavior change concretely.
- Note important non-goals.
- Add tasks that can be verified and, when non-atomic, state the expected result, affected area, material constraints, and verification method or a precise OpenSpec reference.
- Split a large block into ordered substeps when this prevents the implementer from inventing a product or architectural decision; do not manufacture microtasks for atomic work.
- If the change introduces or materially changes a technology surface, derive checks from its risks and include pipeline work in design and tasks.

## Implementation

- Confirm the branch matches the active change id.
- Keep changes scoped to the proposal.
- Update OpenSpec artifacts if real decisions change.
- Add or update tests in proportion to risk.
- Implement or update declared quality checks early enough for the remaining work to use them.
- Keep `docs/QUALITY.md` aligned with actual commands, modes, triggers, prerequisites, and exclusions.
- Update nearby documentation when behavior changes.

## Verification

- Run blocking checks declared for the affected surfaces.
- Record each result as `passed`, `failed`, `skipped`, or `unavailable`; explain skipped or unavailable blocking checks.
- Review applicable advisory checks and triage findings as `confirmed`, `false positive`, or `deferred`.
- Verify the implemented behavior matches the OpenSpec change.
- For every completed task, verify its stated result and verification method rather than relying only on its checkbox.
- Perform manual verification where automation does not cover the risk.
- Propose archive when complete.
