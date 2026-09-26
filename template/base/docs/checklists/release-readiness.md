# Release Readiness Checklist

Use this before publishing, deploying, merging, or archiving meaningful work.

- The implemented behavior matches the active OpenSpec change.
- Specs and tasks reflect the final behavior.
- The chosen verification level matches the highest-risk affected surface.
- Every completed non-atomic task has a recorded `passed`, `failed`, `skipped`, or `unavailable` result for its declared method and real production ownership path.
- Every changed requirement/scenario at `behavior` level or above maps to implementation and evidence for the exact required outcome; no aggregate green result hides a missing scenario. A claim that something never happens requires an observation — a counter, a probe, a recorded absence in an artifact — not reasoning about control flow.
- High-risk and release/certification traceability explicitly covers applicable public/default and alternative ownership paths, and lists every field of uncontrolled data a decision reads with one hostile case per field.
- `docs/QUALITY.md` matches the implemented pipeline and current canonical commands.
- Declared blocking checks passed; any `skipped` or `unavailable` result has an explicit reason and owner decision about its impact.
- A blocking failure followed by a pass retains the first failure, has isolated diagnosis, and is followed by a full blocking-gate rerun; confirmed flakiness is fixed or classified by policy.
- Applicable advisory findings were triaged as `confirmed`, `false positive`, or `deferred`.
- Every changed protective boundary has applicable negative/adversarial evidence, including relevant facade/API bypass and alternative ownership paths, and each adversarial test was shown failing with its guard removed.
- Bounded operations enforce limits before full materialization; readiness/default paths fail closed; permissions do not bypass required allow-lists.
- Persisted certification evidence can be re-opened by an independent verifier; runner inline assertions alone do not certify it.
- Final release/certification evidence names the exact current tracked revision and applicable digests; no tracked commit followed that evidence.
- Important manual verification was performed where automated checks are insufficient.
- A fresh final review re-read proposal, design, specs, tasks, final diff, and results without trusting checkboxes; high-risk work records its independent review context. A re-reading of the diff is not an adversarial pass. For `release/certification` work the independent context executes code — builds hostile inputs, runs them, records their output — and the record names what was run.
- Documentation close to the changed behavior was updated.
- When the change upgraded this project's Workframe payload: the project's canonical files are byte-identical to the target version's template, and any deliberately skipped part is named in `.project-workframe-version` notes.
- No placeholder remains in any artifact this change created or modified, including specs synced during archive.
- Entities this change removed are gone from every reference across the repository.
- Unfinished `## Фаза 2. Углубление` items were moved to `docs/DEBT.md` before archive.
- `semantic` and `structural` findings noticed during the change were recorded in `docs/DEBT.md` rather than silently repaired.
- Current-change regressions must be fixed and verified before acceptance or archive, unless the owner explicitly permits deferral with documented consequences. Recording in `docs/DEBT.md` alone does not establish readiness; request the owner decision when required.
- No unrelated user changes were reverted or mixed in.
- Known risks, accepted exceptions, deferred findings, and follow-up work are documented.
- Residual risks, unstable results, and non-passing exceptions are visible in the final report.
- The user has explicitly requested any merge, archive, push, deployment, or destructive operation.
