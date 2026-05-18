# Feature Change Checklist

Use this checklist before and during non-trivial product or behavior changes.

## Before Proposal

- Read `docs/CONCEPTS.md`.
- Identify the user journey affected by the change.
- Decide whether OpenSpec is required.
- Check the current git branch and uncommitted changes.
- Choose a concise change id.

## Proposal

- Explain why the change matters.
- Explain how it fits or conflicts with `docs/CONCEPTS.md`.
- Define the behavior change concretely.
- Note important non-goals.
- Add tasks that can be verified.

## Implementation

- Confirm the branch matches the active change id.
- Keep changes scoped to the proposal.
- Update OpenSpec artifacts if real decisions change.
- Add or update tests in proportion to risk.
- Update nearby documentation when behavior changes.

## Verification

- Run relevant checks.
- Verify the implemented behavior matches the OpenSpec change.
- Note any checks that could not be run.
- Propose archive when complete.
