# Changelog

## Unreleased

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
