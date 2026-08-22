# Changelog

## Unreleased

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
