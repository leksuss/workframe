# Upgrading Projects Created From Workframe

Workframe does not auto-update existing projects. A project created from an older Workframe version keeps that version until the owner intentionally upgrades it.

This protects active projects from hidden workflow changes.

## Principle

Treat a Workframe upgrade as a normal project change.

If the target project uses OpenSpec, create an OpenSpec change inside that project before changing its agent rules, checklists, skills, or workflow docs.

## When To Upgrade

Upgrade when a newer Workframe version contains something the project actually benefits from:

- better agent safety rules;
- clearer OpenSpec workflow;
- improved design or frontend checklists;
- new AI-client adapter files;
- useful project profiles;
- bug fixes in `scripts/init-project.sh` payload behavior;
- better documentation for future maintenance.

Do not upgrade just because a newer version exists.

## Before Upgrading

In the target project:

1. Check git status.
2. Read `.project-workframe-version`.
3. Read the current project's `AGENTS.md` and `docs/CONCEPTS.md`.
4. Review the Workframe `CHANGELOG.md` between the project's version and the current version.
5. Decide which changes are useful for this project.

If the project has uncommitted work, do not mix the upgrade with unrelated changes.

## Recommended OpenSpec Change

Use a change id like:

```text
upgrade-workframe-guidance
```

Proposal should explain:

- current Workframe version in the project;
- target Workframe version;
- why the upgrade matters;
- which files will be updated;
- which Workframe changes are intentionally skipped.

Write the OpenSpec artifacts in Russian by default.

## Files To Compare

Common base files:

- `AGENTS.md`
- `docs/AGENT_WORKFLOW.md`
- `docs/checklists/feature-change.md`
- `docs/checklists/design-change.md`
- `docs/checklists/release-readiness.md`
- `openspec/config.yaml`
- `.project-workframe-version`

Optional module files:

- `.codex/skills/openspec-*`
- `.codex/skills/design-orchestration/`
- `docs/checklists/frontend-quality.md`

Do not overwrite project-specific `docs/CONCEPTS.md` with the Workframe template. Use the template only as a reference if the project constitution needs deliberate improvement.

## Suggested Process

1. Create or switch to a feature branch for the upgrade.
2. Create the OpenSpec change.
3. Compare files manually or with `diff`.
4. Apply only relevant changes.
5. Preserve project-specific additions in `AGENTS.md`, checklists, and local skills.
6. Update `.project-workframe-version`.
7. Run lightweight verification:
   - review links in docs;
   - run shellcheck or syntax checks for changed scripts when applicable;
   - run a smoke copy to a temporary directory if init behavior changed.
8. Mark OpenSpec tasks complete.
9. Commit the upgrade.
10. Propose archive when verified.

## Manual Diff Example

From the target project root:

```bash
diff -u AGENTS.md /path/to/workframe/template/base/AGENTS.md
diff -u docs/AGENT_WORKFLOW.md /path/to/workframe/template/base/docs/AGENT_WORKFLOW.md
diff -u openspec/config.yaml /path/to/workframe/template/base/openspec/config.yaml
```

For module payloads:

```bash
diff -ru .codex/skills /path/to/workframe/template/modules/codex-skills/.codex/skills
diff -ru docs/checklists /path/to/workframe/template/modules/frontend-quality/docs/checklists
```

Use these diffs as review material, not as automatic replacement commands.

## What Not To Do

- Do not overwrite `docs/CONCEPTS.md` with the template.
- Do not copy `source/` or `examples/` into the target project.
- Do not mix the upgrade with unrelated feature work.
- Do not remove project-specific rules just because the base template does not contain them.
- Do not auto-merge old projects to a new Workframe version.

## Version Marker

After upgrading, update:

```text
.project-workframe-version
```

Example:

```text
workframe: 0.2.0
applied-at: 2026-05-18
notes: Upgraded AGENTS.md, OpenSpec config, and frontend checklist. Kept project-specific deployment rules.
```

The marker records what was applied, not merely what exists upstream.
