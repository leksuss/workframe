# Agent Instructions

Use this file as the operating rules for AI agents working on Workframe itself.

Workframe is the reusable project workflow scaffold. Do not confuse root project files with payload files under `template/`.

## Project Context

When `docs/CONCEPTS.md` exists, treat it as the Workframe constitution:

- Read it before non-trivial feature work, behavior changes, integrations, redesigns, and refactors.
- Use it to evaluate whether a proposed change fits Workframe's purpose, audience, anti-goals, and feature-fit criteria.
- Do not rewrite it unless the user explicitly asks.

Important source boundaries:

- Root `AGENTS.md`, `docs/`, `openspec/`, and `.codex/` govern work on this repository.
- `template/base/` is payload copied into new projects.
- `template/modules/` contains optional payload modules.
- `source/` contains canonical notes, adapters, and profiles used to evolve the payload.
- `examples/` is documentation and must not be copied into new projects by default.

## Feature Workflow

For non-trivial Workframe feature work, behavior changes, integrations, and refactors, use OpenSpec.

Do not use OpenSpec for tiny typo fixes, small README clarifications, dependency bumps, or purely internal cleanup unless they change documented behavior.

Before implementation:

- Start an OpenSpec change using the project's OpenSpec workflow.
- Choose a concise change id automatically unless the user provides one.
- Include how the change fits or conflicts with `docs/CONCEPTS.md`.
- Do not write implementation code from an OpenSpec proposal step unless the user explicitly asks to proceed.

During implementation:

- Follow the active OpenSpec change.
- Keep the active OpenSpec change artifacts up to date when scope, requirements, or implementation decisions change.
- Keep root governance files and `template/` payload files clearly separated.

After implementation:

- Run the relevant checks for the changed area.
- Verify that the active OpenSpec change reflects the implemented behavior.
- Propose archiving the OpenSpec change when the work is complete and verified.
- Do not archive automatically unless the user explicitly asks for it.

## OpenSpec And Git Branches

Use one OpenSpec change per git branch.

When starting a new OpenSpec change:

- Choose a concise change id automatically unless the user provides one.
- Create or switch to a matching git branch named `feature/<change-id>`.
- Keep all implementation work for that change on that branch.
- Do not mix unrelated OpenSpec changes in the same branch.

When applying an OpenSpec change:

- Confirm the current branch matches the active change id.
- If the current branch is `feature/<change-id>`, treat `<change-id>` as the active OpenSpec change.
- If the current branch does not clearly identify an active OpenSpec change, ask the user which change to continue.

When resuming work in a new context:

- Check the current git branch.
- If it is named `feature/<change-id>` and `openspec/changes/<change-id>/` exists, continue that OpenSpec change.
- If multiple active OpenSpec changes exist and the current branch does not identify one clearly, ask the user which change to continue.

When the change is complete:

- Propose archiving the OpenSpec change.
- Do not archive automatically unless the user explicitly asks.
- When the user explicitly asks to archive a completed change, archive it, sync specs, commit the archive result, switch to `main`, merge the completed feature branch into `main`, and leave `main` as the current branch for the next change.
- New OpenSpec changes should start from the current `main`, not from a previous feature branch.
- After archive and merge, the user may push or create a pull request.

## Git Safety

Never merge, rebase, delete branches, reset history, or discard changes unless the user explicitly asks.

Before creating or switching branches:

- Tell the user what branch you intend to use.
- Do not switch branches if there are uncommitted changes that could be affected; ask the user how to proceed.

Do not revert user changes unless the user explicitly asks.

## Documentation Discipline

Keep documentation close to actual behavior.

Write OpenSpec artifacts in Russian by default, because the project owner reads them continuously.
Keep technical identifiers, filenames, paths, branch names, capability names, model names, commands, and code symbols in English where appropriate.

When implementation differs from the active OpenSpec change:

- Update the OpenSpec change artifacts to match the real decision.
- Do not leave stale requirements, tasks, or design notes.

When a change modifies generated project payload behavior:

- Update `template/` files.
- Update root docs and `source/` notes when they explain that behavior.
- Consider whether `README.md`, `README.ru.md`, `docs/UPGRADING.md`, or `CHANGELOG.md` need changes.

Prefer concise, concrete documentation over broad abstract statements.

## Bootstrap Note

The first Workframe commit was created before Workframe had its own root OpenSpec. Treat `bootstrap-workframe-governance` as the explicit transition point after which Workframe governs itself through this workflow.
