# Changelog

## Unreleased

- Added work sequencing discipline: two-phase build model (skeleton, then depth), plan-first work selection, and a backlog for deferred improvements in `tasks.md`.
- Added a text-only verification lifecycle that turns technology choices into a project-specific quality pipeline through OpenSpec, with durable `docs/QUALITY.md` policy, blocking/advisory modes, explicit run results, staged rollout, and advisory triage.
- Fixed base-only `init-project.sh` runs under Bash `set -u` when no optional modules are selected.

## 0.1.0 - 2026-05-18

- Created initial Workframe repository structure.
- Added base project payload with `AGENTS.md`, concept template, workflow docs, checklists, and OpenSpec config.
- Added optional module placeholders for Codex skills, Pencil design workflow, and frontend quality.
- Added neutral canonical rules and project profiles.
- Added Russian README and project upgrade guide.
- Added Workframe root governance with `AGENTS.md`, `docs/CONCEPTS.md`, root `openspec/`, and local OpenSpec Codex skills.
