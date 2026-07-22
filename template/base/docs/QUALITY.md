# Project Quality Policy

This file is the current source of truth for the project's quality pipeline. OpenSpec changes explain why the pipeline changes; this file records how to run it now.

## Status

`pending stack selection`

Do not select tools before the executable stack and its risks are understood. The first OpenSpec change that establishes a technology surface replaces this pending state with a minimal concrete policy and implements the corresponding checks.

## Derivation

Choose checks in this order:

1. List the executable surfaces introduced or changed.
2. Identify their important failure modes and quality risks.
3. Select check classes that address those risks.
4. Select stack-appropriate tools, commands, and automation.

Do not copy a standard tool list without connecting each check to a project risk.

## Verification Matrix

Replace the example row when the stack is selected. Add rows per surface when different parts of the project need different tools.

| Surface | Risk / check class | Tool and canonical command | Mode | Trigger | Prerequisites / exclusions |
| --- | --- | --- | --- | --- | --- |
| Pending | Stack not selected | Not configured | `not applicable` | First technology-establishing change | Replace this row |

Modes:

- `blocking`: must pass before completion unless the owner explicitly accepts a documented exception;
- `advisory`: review and triage findings, but do not fail the change automatically;
- `not applicable`: intentionally omitted with a short reason.

Record a run result separately as `passed`, `failed`, `skipped`, or `unavailable`. A skipped or unavailable blocking check is not a passing check; record the reason and impact on completion.

## Canonical Entry Points

Document the actual project commands after the stack is selected:

- Fast local checks: pending.
- Change verification: pending.
- Full or release verification: pending.
- Periodic advisory audit: pending or not applicable.

Small projects may use one command for multiple levels. Polyglot or monorepo projects should document per-surface commands and an aggregate entry point when practical.

## Rollout And Exceptions

- Start with the smallest reliable pipeline that addresses current risks.
- Introduce noisy or heuristic analyzers as advisory before making proven rules blocking.
- For legacy code, prefer a documented baseline, changed-scope enforcement, or staged rollout over unrelated cleanup.
- Exclude generated and vendored code explicitly.
- For spikes, state what is temporarily omitted and when the code must be deleted or promoted into the maintained pipeline.
- Declare checks that require secrets, network access, services, containers, special hardware, or a specific operating system.
- Do not use flaky or prohibitively slow checks as blocking gates until their execution level and reliability are clear.

When CI exists, enforce blocking checks there where practical. This file documents the contract; it does not replace technical enforcement.

## Advisory Triage

Classify advisory findings as:

- `confirmed`;
- `false positive`;
- `deferred` with an explicit follow-up.

Fix a confirmed finding in the current change only when it blocks the change's stated goal or safe completion. Otherwise record it as future work. Heuristic architecture tools remain advisory until the project explicitly adopts narrower proven rules as blocking.

If the project selects Archscope, start by reviewing its Markdown architecture and quality report after each OpenSpec implementation before completion and running a full-repository audit weekly. Treat SARIF as an additional security artifact, not a replacement for the broader report or agent triage. Record a different cadence here if the project deliberately chooses one.
