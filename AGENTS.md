# Agent Instructions

Use this file as the always-loaded rules for work on Workframe itself. `template/` contains generated-project payload and does not govern this repository.

## Scope And Sources

- Read `docs/CONCEPTS.md` before any non-trivial feature, behavior, integration, redesign, or refactor. Evaluate the change against its purpose, audience, principles, anti-goals, and feature-fit criteria. Do not rewrite it unless the user explicitly asks.
- Root `AGENTS.md`, `docs/`, `openspec/`, and `.codex/` govern Workframe. `template/base/` is required payload, `template/modules/` optional payload, `source/` canonical neutral rules and adapter notes, and `examples/` documentation that is never copied by default.
- Treat payload and scripts as actual behavior, active specs as required behavior, `docs/CONCEPTS.md` as product intent, and README/source notes as description. Do not resolve a spec/payload or constitution conflict without the owner.

## Load Detailed Rules Only At Their Trigger

These files are normative. Read each named file in full before the listed work; do not rely on a summary in this entry point.

- Before proposing, planning, implementing, or resuming a non-trivial change, read `source/canonical-rules/workflow.md`. Before proposal, also read `docs/DEBT.md` and offer any open entry in the affected area.
- Before designing non-atomic tasks, implementing behavior, choosing verification, reviewing evidence, or declaring tasks complete, read `source/canonical-rules/verification.md`.
- Before reconcile, archive readiness, or a repository audit, read `source/canonical-rules/coherence.md`. For a full audit, also follow `template/base/docs/checklists/coherence-audit.md`, interpreted with the root/payload boundary below.
- When a project-local skill applies, read its `SKILL.md` in full. A skill may add procedure but does not override this file or the active OpenSpec change.

Paths such as `docs/QUALITY.md` inside neutral sources describe generated projects. Workframe itself uses its repository verification scripts and change evidence; their mention does not imply a missing root payload file.

Simple questions and atomic low-risk edits do not require loading unrelated procedures.
If unsure whether a trigger applies, treat it as applicable and load the referenced instructions before acting.

## Workframe Change Workflow

- Use OpenSpec for non-trivial Workframe features, behavior changes, integrations, redesigns, and refactors. Tiny typo/README fixes, dependency bumps, and purely internal cleanup may be direct unless they change documented behavior.
- Choose a concise change id unless the user supplied one. Use exactly one matching branch, `feature/<change-id>`, and keep unrelated changes separate.
- Before creating or switching branches, state the intended branch and check for uncommitted changes. Do not switch when those changes could be affected without asking the user.
- On apply or resume, the current `feature/<change-id>` and `openspec/changes/<change-id>/` identify the active change. If they do not identify one unambiguously, ask which change to continue.
- Write OpenSpec artifacts in Russian by default; keep technical identifiers, paths, commands, model names, and code symbols in English where clearer.
- A proposal does not authorize implementation unless the user explicitly asked to proceed. During implementation, follow tasks in order and keep proposal, design, specs, tasks, and recorded evidence aligned with actual decisions.
- Keep root governance and payload edits distinct. If generated-project behavior changes, update `template/`, give every new payload file an address in shipped rules, and update applicable `source/`, README, `docs/UPGRADING.md`, and changelog documentation.
- After implementation, run affected checks, verify every task against its exact expected result and evidence, then reconcile. Propose archive when complete; never archive automatically.

## Release And Archive

Every completed non-trivial Workframe change is a release:

- choose SemVer impact in root `VERSION`: `PATCH` compatible fix, `MINOR` compatible capability, `MAJOR` incompatible required payload or workflow;
- move changelog entries from `Unreleased` into a dated release section before proposing archive;
- after the release commit, create annotated tag `v<VERSION>` on that commit.

Archive directory dates are UTC. When the owner explicitly asks to archive, archive and sync specs, commit the archive result, switch to `main`, merge the feature branch, and leave `main` current. Do not merge, tag, push, or create a PR unless the user's request covers that action. New changes start from current `main`.

## Git And Change Safety

- Assume existing or uncommitted changes belong to the user. Preserve them and avoid unrelated edits.
- Never discard changes, rewrite history, reset, merge, rebase, delete branches, or perform destructive operations unless the user explicitly requests that action.
- If user work overlaps the task, adapt when safe; ask before continuing only when the overlap makes the intended result ambiguous or risks loss.
- Prefer non-interactive, scoped operations. Resolve exact targets before destructive actions and report any material deletion and recoverability.

## Documentation And Payload Boundary

- Keep documentation close to behavior and concise. When implementation differs from an active change, update the change artifacts rather than leaving stale requirements or decisions.
- Update `template/` only for behavior that new generated projects should receive. A root-rule change alone does not imply a payload-rule change.
- During a root audit, findings inside `template/` concern payload consistency, not an already generated project. Never modify generated projects from a Workframe audit; they upgrade through their own OpenSpec change under `docs/UPGRADING.md`.
- Never edit `openspec/changes/archive/`; it is historical evidence. Repair objective `mechanical` findings. Record supported `semantic` and `structural` findings in `docs/DEBT.md` without deciding them silently.
- Current-change regressions must be fixed and verified before acceptance or archive, unless the owner explicitly permits deferral with documented consequences. Recording in `docs/DEBT.md` alone does not establish readiness; request the owner decision when required.

## Bootstrap

The first Workframe commit predates root OpenSpec. `bootstrap-workframe-governance` is the transition after which this workflow governs the repository.
