# Changelog

## Unreleased

- Added work sequencing discipline: two-phase build model (skeleton, then depth), plan-first work selection, and a backlog for deferred improvements in `tasks.md`.
- Added a text-only verification lifecycle that turns technology choices into a project-specific quality pipeline through OpenSpec, with durable `docs/QUALITY.md` policy, blocking/advisory modes, explicit run results, staged rollout, and advisory triage.
- Added a coherence lifecycle addressing drift accumulated across many changes: a truth hierarchy between code, specs, constitution, and documentation; read-only status for `openspec/changes/archive/`; `mechanical`/`semantic`/`structural` finding classes that separate what an agent repairs from what it only records; a reconcile step before archive; a full-repository audit checklist usable without skills; and `docs/DEBT.md` as a durable register so deferred work no longer disappears into the archive with its change.
- Fixed base-only `init-project.sh` runs under Bash `set -u` when no optional modules are selected.

## 0.1.0 - 2026-05-18

- Created initial Workframe repository structure.
- Added base project payload with `AGENTS.md`, concept template, workflow docs, checklists, and OpenSpec config.
- Added optional module placeholders for Codex skills, Pencil design workflow, and frontend quality.
- Added neutral canonical rules and project profiles.
- Added Russian README and project upgrade guide.
- Added Workframe root governance with `AGENTS.md`, `docs/CONCEPTS.md`, root `openspec/`, and local OpenSpec Codex skills.
