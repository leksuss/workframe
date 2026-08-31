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

## Contract-Driven Verification

Verification follows one evidence chain:

```text
requirement
→ production ownership path
→ positive verification
→ negative/adversarial verification when risk requires it
→ recorded result
→ independent review
→ archive decision
```

A task checkbox records the end of this chain, not the end of implementation. Every non-atomic task names an observable expected result, the affected production surface or ownership path, material constraints and protective boundaries, and a concrete verification method. Do not mark it complete until that method ran and its result was recorded, or the owner accepted a documented exception. An aggregate green suite is not evidence for a scenario the suite did not execute.

When a change is complete, re-read every task and match its claim to the implementation path and actual result. Check assertions against the exact required outcome: a test that proves rejection does not satisfy a requirement for success, and a mock does not satisfy a required loopback or other production integration path. A claim that something never happens requires an observation — a counter, a probe, a recorded absence in an artifact — not reasoning about control flow.

## Proportional Evidence Levels

Classify the change by the highest-risk affected surface:

- `atomic low-risk`: an obvious change → result → check link in the task or final review is enough; no separate traceability table;
- `behavior`: trace each changed requirement or scenario to its production path, evidence and result; positive verification is required and negative verification follows the risk;
- `high-risk boundary`: make traceability explicit, exercise applicable positive and adversarial scenarios including bypass and alternative ownership paths, and use an independent final review context;
- `release/certification`: also independently re-verify persisted evidence and bind final evidence to the exact tracked revision or equivalent identity.

For `behavior` and higher levels, record at least:

```text
requirement or scenario | production implementation or ownership path | test/check/evidence | passed/failed/skipped/unavailable
```

Keep the record in the change artifacts. A separate heavy table is unnecessary for an atomic change whose relationship is genuinely obvious. Traceability is incomplete when a requirement has no implementation path, no evidence, or evidence for a different outcome. Include public/default paths and every relevant ownership path, not only the UI or facade used by the common happy path.

## Protective Boundaries And Adversarial Review

Negative or adversarial verification is mandatory when a change affects one or more of these surfaces:

- credentials, secrets, and redaction;
- authentication, authorization, permissions, and allow-lists;
- network requests and external adapters;
- timeouts, cancellation, budgets, and resource limits;
- streaming and bounded payloads;
- persistent storage, atomic writes, and rollback;
- idempotency, compare-and-swap, leases, and restart/resume;
- public APIs, server boundaries, and embedding defaults;
- certified evidence, manifests, digests, and revision binding;
- irreversible or externally visible side effects.

Choose scenarios from the actual risk rather than running every possible attack. Consider direct API bypass around a disabled UI, extra or undeclared fields, missing headers/permissions/allow-list entries, a body without `content-length`, a stalled dependency, retry and collision, stale or tampered persisted state, an optimistic default, partial write and rollback, and alternate paths such as CLI, API, console, supervisor/child, restart/resume, or embedding. When a decision reads data the code does not control, list every field of that data the decision reads and produce one hostile case per field. That list belongs in the change artifacts; adversarial coverage is judged against it, not against the author's sense of completeness.

Bounded behavior must be enforced while data is consumed, not only after full materialization. Readiness and public defaults fail closed when their dependency is absent or unknown. A permission check does not substitute for a required capability allow-list. For a protective boundary, show each adversarial test failing with its guard removed, and record that it did.

## Execution And Certification

When a change produces a certifiable persisted evidence artifact, execution and certification are separate responsibilities. A runner does not become an independent verifier merely because it performs inline assertions or records a digest.

The verifier must be able to re-open the saved artifact and, as applicable, check schema/version, provenance, exact revision or identity binding, digest, scope/tier, internal consistency, forbidden sensitive fields, tampering or stale state, and fail-closed behavior. If a separate verifier is disproportionate to the risk, the design records why and names the independent check used instead.

Final release or certification evidence records the exact tracked revision it covers and applicable artifact digests. A later tracked commit makes that evidence stale; rerun the blocking gate on the final revision before claiming readiness.

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

## Flaky And Timing-Sensitive Results

A random successful rerun does not erase the first failure. Preserve the failed result, diagnose the check in isolation, then repeat the full blocking gate. If the instability is confirmed, fix it or classify it explicitly under the project quality policy. Never hide the original failure or report a one-off rerun as stable evidence.

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

## Independent Final Review

Before proposing archive, change perspective from implementer to adversarial reviewer. Re-read proposal, design, specs, tasks, final diff, and recorded results without relying on task checkboxes. Look for spec/code mismatch, unverified claims, tests that certify the wrong outcome, unreachable test doubles, optimistic defaults, bypass paths, unbounded operations, runner/verifier conflation, and evidence not bound to the final revision. A design claim that a library, runtime, or platform guarantees X, when a safety decision rests on it, must cite an executed probe; reasoning about documented behavior is not evidence.

For a high-risk change, use another agent or model, or an equivalent separate review context that starts from repository artifacts rather than the implementation narrative. This does not require manual owner review of every change. A re-reading of the diff is not an adversarial pass. For `release/certification` work the independent context executes code — builds hostile inputs, runs them, records their output — and the record names what was run. Repair mechanical findings immediately; classify semantic and structural findings under the coherence policy.
