# Agent Instructions

Use this file as the operating rules for AI agents working in this repository.

## Project Context

When `docs/CONCEPTS.md` exists, treat it as the project constitution:

- Read it before non-trivial feature work, behavior changes, integrations, redesigns, and refactors.
- Use it to evaluate whether a proposed change fits the product values, audience, anti-goals, and feature-fit criteria.
- Do not rewrite it unless the user explicitly asks.

For tool-specific instructions, prefer this file first, then `docs/AGENT_WORKFLOW.md`, then local tool or skill documentation.

## Feature Workflow

For non-trivial feature work, behavior changes, integrations, and refactors, use OpenSpec.

Do not use OpenSpec for tiny cosmetic fixes, typo fixes, dependency bumps, or purely internal cleanup unless they change documented behavior.

Before implementation:

- Start an OpenSpec change using the project's OpenSpec workflow.
- Choose a concise change id automatically unless the user provides one.
- Include how the change fits or conflicts with `docs/CONCEPTS.md` when it exists.
- Do not write implementation code from an OpenSpec proposal step unless the user explicitly asks to proceed.

During implementation:

- Follow the active OpenSpec change.
- Keep the active OpenSpec change artifacts up to date when scope, requirements, or implementation decisions change.
- Follow the current quality policy in `docs/QUALITY.md`.

After implementation:

- Run the blocking checks declared for the changed surfaces in `docs/QUALITY.md`.
- Review and triage applicable advisory findings.
- Treat skipped or unavailable blocking checks as non-passing unless the owner explicitly accepts the documented exception.
- Verify that the active OpenSpec change reflects the implemented behavior.
- Propose archiving the OpenSpec change when the work is complete and verified.
- Do not archive automatically unless the user explicitly asks for it.

## Quality Pipeline

Work from project risks, not a generic list of fashionable tools. Derive checks in this order: executable surface, failure modes, check class, then stack-appropriate tool and command.

When an OpenSpec change first introduces or materially changes a language, runtime, component, storage system, public contract, deployment surface, or other executable technology surface:

- Describe the surfaces, risks, check classes, and important trade-offs in the change design.
- Add tasks that implement or update the smallest useful quality pipeline early enough for the remaining work to use it.
- Update `docs/QUALITY.md` in the same change with the current commands, modes, triggers, prerequisites, and exclusions.
- Do not select tools before the stack and its risks are understood.

Each check is `blocking`, `advisory`, or `not applicable`. Record a particular run separately as `passed`, `failed`, `skipped`, or `unavailable`. Advisory findings are triaged as `confirmed`, `false positive`, or `deferred`; confirmed findings block the current change only when they prevent its stated goal or safe completion.

Use staged rollout when a strict gate would be misleading or disproportionate. Legacy code may need a baseline or changed-scope enforcement; generated and vendored code need explicit exclusions; spikes need an exit condition; polyglot projects may need per-surface commands. When CI exists, enforce blocking checks there where practical.

## Work Sequencing

Build systems and large features in two phases.

Skeleton phase: build large blocks in sequence, each with minimal functionality — enough that the block exists and connects to the next one — until the whole system has an end-to-end skeleton.

Depth phase: fill blocks with features, polish them, and address deferred improvements.

When choosing the next work:

- Check the plan first. Take the next unfinished item in `tasks.md`, in order. Do not move to the depth phase before the skeleton phase is complete.
- Size each step to a whole block, not a small edit. The step should visibly advance toward the goal.
- When you notice a flaw in a finished block, append it to the `## Фаза 2. Углубление` section of `tasks.md` instead of fixing it inline.
- Fix a flaw immediately only when it is a true blocker — a defect that prevents building the next block. Then it is part of the current item, not a deferred improvement.

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
- When the user explicitly asks to archive a completed change, archive it, sync specs, commit the archive result, switch to the main branch, merge the completed feature branch, and leave the main branch as the current branch for the next change.
- New OpenSpec changes should start from the current main branch, not from a previous feature branch.
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

When a change modifies product behavior:

- Make sure the relevant OpenSpec specs describe the final behavior before proposing archive.

Prefer concise, concrete documentation over broad abstract statements.

## Design Discipline

The design workflow is available by default, even when no design tool is connected.

When a task affects visual product experience:

- Identify the source of truth: existing UI, design artifact, screenshot, brand material, or explicit user direction.
- Respect the existing project stack and design conventions before adding libraries.
- Consider responsive behavior, loading states, empty states, error states, focus states, and text overflow.
- Verify visually when possible.

Pencil MCP is optional and disabled by default. If a task requires editing `.pen` files and Pencil MCP is unavailable, ask the user to enable it or work from exported artifacts instead. Do not pretend a design artifact was updated when it was not.
