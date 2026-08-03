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
- a stack-neutral verification lifecycle that can make the project's existing quality pipeline explicit;
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
- `docs/QUALITY.md`
- `docs/checklists/feature-change.md`
- `docs/checklists/design-change.md`
- `docs/checklists/release-readiness.md`
- `openspec/config.yaml`
- `.project-workframe-version`

Agent workflow files installed in every new project:

- `.agents/skills/openspec-*`
- `.claude/skills/openspec-*`
- `.qwen/skills/openspec-*`
- `.codex/skills/design-orchestration/`
- `docs/checklists/frontend-quality.md`

Do not overwrite project-specific `docs/CONCEPTS.md` with the Workframe template. Use the template only as a reference if the project constitution needs deliberate improvement.

## Adopting The Verification Lifecycle

An existing project already has a stack, and may already have scripts, CI jobs, conventions, and exceptions. Do not copy the pending `docs/QUALITY.md` row as if the project had no pipeline.

In the project-local upgrade change:

1. Inventory the executable surfaces and the checks that actually run today.
2. Connect each check to a risk and classify it as `blocking`, `advisory`, or `not applicable`.
3. Record canonical commands, triggers, prerequisites, exclusions, and any environment constraints in `docs/QUALITY.md`.
4. Preserve project-specific commands and CI behavior unless the change explicitly replaces them.
5. Use baselines, changed-scope enforcement, or staged advisory rollout when a new analyzer would expose unrelated legacy backlog.
6. Record skipped or unavailable blocking checks as non-passing results unless the owner explicitly accepts the documented exception.

The upgrade may document an existing pipeline without changing its tools. Adding a new analyzer or tightening a gate should be justified by project risks, not by the Workframe template.

## Suggested Process

1. Create or switch to a feature branch for the upgrade.
2. Create the OpenSpec change.
3. Compare files manually or with `diff`.
4. Apply only relevant changes.
5. Preserve project-specific additions in `AGENTS.md`, checklists, and local skills.
6. If adopting the verification lifecycle, create or update `docs/QUALITY.md` for the real stack rather than leaving it in the template's pending state.
7. Update `.project-workframe-version`.
8. Run lightweight verification:
   - review links in docs;
   - run shellcheck or syntax checks for changed scripts when applicable;
   - run a smoke copy to a temporary directory if init behavior changed.
9. Mark OpenSpec tasks complete.
10. Commit the upgrade.
11. Propose archive when verified.

## Manual Diff Example

From the target project root:

```bash
diff -u AGENTS.md /path/to/workframe/template/base/AGENTS.md
diff -u docs/AGENT_WORKFLOW.md /path/to/workframe/template/base/docs/AGENT_WORKFLOW.md
diff -u docs/QUALITY.md /path/to/workframe/template/base/docs/QUALITY.md
diff -u openspec/config.yaml /path/to/workframe/template/base/openspec/config.yaml
```

For optional module payloads:

```bash
diff -ru .agents/skills /path/to/workframe/template/modules/agent-skills/.agents/skills
diff -ru .codex/skills /path/to/workframe/template/modules/agent-skills/.codex/skills
diff -ru .claude/skills /path/to/workframe/template/modules/agent-skills/.claude/skills
diff -ru .qwen/skills /path/to/workframe/template/modules/agent-skills/.qwen/skills
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
