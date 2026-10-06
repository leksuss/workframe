# Changelog

## Unreleased

## 0.7.2 - 2026-10-06

- Rewrote the README around common AI-agent problems and the Workframe practices that address them.
- Made Russian the default README and added README.en.md; kept README.ru.md as a compatibility link.
- Added seven illustrated explanations in both languages covering design, OpenSpec changes, verification, context handoffs, debt, audits, and rule adoption.
- Retained setup and upgrade instructions; generated-project behavior is unchanged.

## 0.7.1 - 2026-09-26

- Separated recording debt from permission to defer regressions introduced by the current change: acceptance and archive require a verified fix or explicit owner permission with documented consequences.
- Applied the gate to root and generated-project rules, reconcile, advisory triage, depth backlog, and debt guidance while preserving owner authority over product decisions.
- Documented explicit adoption by existing projects without replacing their debt records.

## 0.7.0 - 2026-09-03

- Reduced the always-loaded root `AGENTS.md` from 15,681 to about 6.3 KB and the generated-project `AGENTS.md` from 17,859 to about 5.8 KB while preserving detailed procedures in mandatory trigger-based canonical sources; uncertain triggers fail closed and load the referenced procedure.
- Added `scripts/verify-instruction-budget.sh` with byte ceilings, canonical-address checks, footprint reporting, and hostile fixtures for over-budget and missing-address failures.
- Updated contract verification to test routing in entry points and exact obligations in canonical workflow sources instead of requiring full verification text in every `AGENTS.md`.
- Clarified Codex, Claude Code, Cursor, and generic adapter documentation so `AGENTS.md` is always loaded while workflow documents, checklists, and skills load on demand.
- Completed a seven-slice coherence audit, repaired the root-compatible `docs/QUALITY.md` condition in the shared audit checklist, found no new semantic or structural debt, and resolved D-005 under the owner's revised instruction-budget decision.

## 0.6.1 - 2026-08-31

- Added an adversarial-case generator: when a decision reads data the code does not control, every field that decision reads is listed and each field gets one hostile case. Coverage is judged against that list, not against the author's sense of completeness.
- A claim that something never happens now requires an observation — a counter, a probe, a recorded absence in an artifact — instead of reasoning about control flow.
- A design claim that a library, runtime, or platform guarantees something must cite an executed probe whenever a safety decision rests on it.
- Re-reading the diff no longer counts as an adversarial pass for `release/certification` work: the independent context executes code, builds hostile inputs, runs them, and the record names what was run.
- Adversarial tests for a protective boundary must be shown failing with the guard removed, so a test that passes with or without the guard is visible.
- No new defect category was added. `0.6.0` already named `optimistic defaults`, `bypass paths`, `unverified claims`, and `runner/verifier conflation`; what was missing was a method that produces a countable result an outsider can check.
- `scripts/verify-contract-driven-workflow.sh` now probes each method on every surface that carries it and rejects five negative fixtures, one per method clause.

## 0.6.0 - 2026-08-30

- Added a proportional contract-driven verification lifecycle: task completion now follows requirement → production ownership path → exact positive result → risk-based adversarial evidence → recorded result → independent review → archive decision.
- Added explicit traceability for behavior, high-risk boundary, and release/certification changes, while atomic low-risk edits keep a lightweight change/result/check link.
- Protective boundaries now trigger applicable negative scenarios for bypass paths, allow-lists, stalled dependencies, bounded streaming, persistence/rollback, public defaults, restart/resume, and other alternate ownership paths.
- Separated execution from certification: persisted evidence must be independently re-verifiable, and final release evidence is bound to the exact tracked revision and becomes stale after a later commit.
- Strengthened OpenSpec propose/apply/archive workflows and feature, release-readiness, and coherence checklists. Checkboxes no longer substitute for declared verification results, and high-risk work gets a separate adversarial review context.
- Added fail-visible handling for flaky or timing-sensitive blocking checks: the first failure remains recorded, isolated diagnosis comes before a full-gate rerun, and confirmed instability is fixed or classified by policy.
- Added `scripts/verify-contract-driven-workflow.sh`, covering canonical contract clauses, thin client adapters including Claude Code discovery, fresh installation, negative mutation, upgrade payload consistency, and byte-preservation of project-owned documents.
- Existing projects adopt the lifecycle through their own OpenSpec upgrade change, copying canonical files whole while preserving `docs/CONCEPTS.md`, `docs/QUALITY.md`, `docs/DEBT.md`, and `docs/PROJECT_RULES.md` and retaining stack-specific commands in project policy.

## 0.5.0 - 2026-08-23

- Added `docs/PROJECT_RULES.md` to the payload: the rules a project decides for itself now have their own addressed file, and a canonical file is never edited to hold one.
- Resolved the contradiction recorded as `D-007`. Byte-identical canonical files and preserved project rules were mutually exclusive as long as project rules lived inside canonical files; a project that kept its own rules could never report a clean upgrade, which made the signal meaningless.
- The upgrade guide now moves existing project-specific additions out of canonical files verbatim instead of preserving them in place, and the upgrade check treats the new file as project-local.

## 0.4.0 - 2026-08-23

- Every payload file now has an address in the rules that travel with it: the feature, design, and release readiness checklists, the optional frontend checklist, and `.project-workframe-version`, which no project rule had ever mentioned. Workframe's own rules now require a new payload file to get an address in the same change.
- Added a `Workframe Payload` section to the generated project rules: what the version marker records, and that a canonical file is copied whole rather than restated in the agent's own words.
- The feature checklist now names two steps the rules already required: checking `docs/DEBT.md` before a proposal, and reconciling the artifacts a change touched before completing it.
- The project upgrade check now compares every payload file with the template — `equal`, `differs`, or `missing` — names the newest release each differing file still matches, separates project-local files that are expected to diverge, and computes the level the installed content actually matches instead of trusting the marker.
- A finished Workframe upgrade must leave the project's canonical files byte-identical to the target version's template. The release readiness checklist and slice 5 of the audit checklist both check it, and `docs/UPGRADING.md` now forbids restating a canonical file from memory.
- Tagged the 0.1.0 release retroactively, so content comparison reaches projects created before releases were tagged.
- Fixed base-only `init-project.sh` runs, which failed under Bash `set -u` while writing the `modules` field of the version marker.

## 0.3.0 - 2026-08-22

- Added a read-only project upgrade check that reports versions, installed modules, release notes, and review-file status before any project-local change.
- Added `modules` to the Workframe version marker and annotated Git tags for releases.

## 0.2.0 - 2026-08-22

- Added canonical `VERSION` and Semantic Versioning releases for completed non-trivial Workframe changes.
- New projects created by `init-project.sh` now record the actual Workframe version in `.project-workframe-version`.
- Added work sequencing discipline: two-phase build model (skeleton, then depth), plan-first work selection, and a backlog for deferred improvements in `tasks.md`.
- Added a text-only verification lifecycle that turns technology choices into a project-specific quality pipeline through OpenSpec, with durable `docs/QUALITY.md` policy, blocking/advisory modes, explicit run results, staged rollout, and advisory triage.
- Added a coherence lifecycle addressing drift accumulated across many changes: a truth hierarchy between code, specs, constitution, and documentation; read-only status for `openspec/changes/archive/`; `mechanical`/`semantic`/`structural` finding classes that separate what an agent repairs from what it only records; a reconcile step before archive; a full-repository audit checklist usable without skills; and `docs/DEBT.md` as a durable register so deferred work no longer disappears into the archive with its change.
- Added a `coherence-audit` workflow skill with Codex, Claude Code and Qwen Code adapters, so the repository audit runs the same way in every supported client. The skill carries the procedure only; the slices stay in `docs/checklists/coherence-audit.md` so the two cannot drift apart.
- Fixed the payload adapter check, which searched every skill for one skill's description and so could never detect duplicated instructions in three of four adapters. It now compares adapter size against the canonical workflow and works for skills added later.
- Fixed base-only `init-project.sh` runs under Bash `set -u` when no optional modules are selected.

## 0.1.0 - 2026-05-18

- Created initial Workframe repository structure.
- Added base project payload with `AGENTS.md`, concept template, workflow docs, checklists, and OpenSpec config.
- Added optional module placeholders for Codex skills, Pencil design workflow, and frontend quality.
- Added neutral canonical rules and project profiles.
- Added Russian README and project upgrade guide.
- Added Workframe root governance with `AGENTS.md`, `docs/CONCEPTS.md`, root `openspec/`, and local OpenSpec Codex skills.
