# Codex Skills Module

Copy this module into a project when Codex should use local skills for OpenSpec work.

## Install

From the target project root:

```bash
cp -R /path/to/workframe/template/modules/codex-skills/.codex .
```

## Included Skills

- `openspec-explore`: thinking and investigation mode.
- `openspec-propose`: create a new OpenSpec change with proposal, design, specs, and tasks.
- `openspec-apply-change`: implement tasks from an active OpenSpec change.
- `openspec-archive-change`: archive a completed OpenSpec change.

These skills assume the `openspec` CLI is available in the project.

## Language

The project `openspec/config.yaml` controls Russian-by-default artifact writing. Keep technical identifiers in English where appropriate.
