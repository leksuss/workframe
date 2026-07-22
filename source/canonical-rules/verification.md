# Canonical Verification Rules

This is the neutral source for turning project technology decisions into a concrete quality pipeline. It defines a contract and lifecycle, not a toolchain.

## Derive The Pipeline From The Project

Choose checks in this order:

1. Identify the executable surfaces introduced or changed by the project.
2. Identify the failure modes and quality risks of each surface.
3. Choose the classes of checks that address those risks.
4. Only then select tools, commands, and automation appropriate to the stack.

Do not add a familiar analyzer merely because it is common for the language. Each check should have a useful risk, scope, and operating mode.

## OpenSpec Integration

An OpenSpec change that first introduces or materially changes a language, runtime, component, storage system, public contract, deployment surface, or other executable technology surface also evaluates the quality pipeline for that surface.

The change design records the surfaces, risks, check classes, and important trade-offs. Its tasks implement or update the smallest useful pipeline early enough that the remaining work can use it. A change that does not alter a technology surface follows the existing project policy without redesigning it.

OpenSpec records why the pipeline changed. The current commands and policy remain in `docs/QUALITY.md` after the change is archived.

## Policy Modes And Run Results

Each declared check has one policy mode:

- `blocking`: must pass before completion unless the owner explicitly accepts a documented exception;
- `advisory`: must be reviewed and triaged, but findings do not fail the change automatically;
- `not applicable`: intentionally omitted with a short reason.

Record the result of a particular run separately:

- `passed`;
- `failed`;
- `skipped` with a reason;
- `unavailable` with the missing prerequisite or environment constraint.

A skipped or unavailable blocking check is not a passing check. Explain its impact before proposing archive, merge, release, or deployment.

## Verification Levels

Keep feedback proportional to the work:

- fast local checks support implementation;
- change checks cover the affected surfaces before an OpenSpec change is completed;
- full or release checks cover the integrated project before release or deployment;
- periodic audits run broad, slow, or heuristic advisory analysis when the project benefits from them.

Projects may combine levels when they are small. Larger or polyglot repositories should document per-surface commands and provide an aggregate entry point when practical.

## Advisory Triage

Review advisory findings as `confirmed`, `false positive`, or `deferred`.

A confirmed finding is fixed in the current change only when it blocks the change's stated goal or safe completion. Otherwise record it as explicit future work. Heuristic architecture analysis starts as advisory unless the project adopts a narrower proven rule as blocking.

When a project selects Archscope, the normal starting policy is to review its Markdown architecture and quality report after each OpenSpec implementation before completion, plus run a full-repository audit weekly. Its SARIF output may be retained as an additional security artifact, but it does not replace the broader report or agent triage. A project may adjust the cadence explicitly when its size or workflow justifies it.

## Proportional Adoption

- New projects start with the smallest reliable pipeline that addresses current risks.
- Legacy projects may use a baseline, changed-scope enforcement, or advisory rollout instead of fixing unrelated backlog.
- Generated and vendored code use explicit exclusions rather than manual cleanup.
- Spikes document temporary omissions and the condition for deletion or promotion into maintained code.
- Checks that need secrets, network access, services, containers, special hardware, or a specific operating system declare those prerequisites and a fallback where useful.
- Flaky or prohibitively slow checks are not suitable blocking gates until their reliability and execution level are made explicit.

When CI exists, enforce blocking checks there where practical. Textual policy documents the contract; it does not substitute for technical enforcement.
