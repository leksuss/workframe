# Agent Instructions

Use this file as the always-loaded rules for AI agents working in this repository. Detailed procedures are shipped separately and must be loaded only at the triggers below.

## Session State And Authority

- Before changing files, inspect `git status`, the current branch, and active OpenSpec changes. Repository state and approved project documents override another agent's chat history.
- Treat `docs/CONCEPTS.md` as the product constitution and `docs/PROJECT_RULES.md` as project-owned additions. Never rewrite the constitution unless the owner explicitly asks.
- Workframe-supplied rules, workflow documents, checklists, and skills remain canonical; project-specific rules belong only in `docs/PROJECT_RULES.md`.
- For conflicting instructions, follow this file, then the triggered project workflow/checklist, then tool-specific documentation. Ask the owner when a conflict changes product intent or would risk user work.

## Load Detailed Rules Only At Their Trigger

Read each named file in full before the listed work; a path here is a mandatory routing rule, not optional background reading.

- Before proposing, planning, implementing, reviewing, or resuming a non-trivial change, read `docs/AGENT_WORKFLOW.md`, `docs/CONCEPTS.md`, `docs/PROJECT_RULES.md`, `docs/QUALITY.md`, and `docs/checklists/feature-change.md`. Check `docs/DEBT.md` and offer open entries in the affected area.
- Before declaring a change complete or proposing archive, read `docs/checklists/release-readiness.md` and perform its reconcile and evidence checks.
- Before a full repository audit, read `docs/checklists/coherence-audit.md`. Start such an audit only when the owner asks or accepts a proposal.
- Before design, interaction, or frontend work, read `docs/checklists/design-change.md`; if installed, also read `docs/checklists/frontend-quality.md` before handoff.
- When a project workflow skill applies, read the matching canonical `.agents/skills/<name>/SKILL.md` in full. Client-specific skill files are discovery adapters only.

Simple questions and atomic low-risk edits do not require loading unrelated workflow documents.
If unsure whether a trigger applies, treat it as applicable and load the referenced instructions before acting.

## Product And Change Routing

- For a new product, help the owner confirm purpose, audience, core value, principles, anti-goals, and key journeys. Record confirmed decisions in `docs/CONCEPTS.md`, then proactively offer the first OpenSpec proposal. The owner need not name files or request the OpenSpec step.
- Use OpenSpec for non-trivial product or behavior changes, integrations, redesigns, data/public contracts, and material refactors. Tiny cosmetic or typo fixes, dependency bumps, and purely internal cleanup may be direct unless documented behavior changes.
- A proposal does not authorize implementation unless the owner explicitly asked to proceed. Follow the active change during implementation and update its artifacts when real decisions change.
- Follow `docs/QUALITY.md` for project commands and policy. A task is complete only after its declared method ran and its result was recorded or the owner accepted a documented exception.
- Keep documentation and active specs aligned with implemented behavior. Prefer concise, concrete text; write OpenSpec artifacts in Russian by default and keep technical identifiers in English where clearer.

## OpenSpec And Git

- One OpenSpec change uses one matching `feature/<change-id>` branch. Choose a concise id automatically unless the owner supplies one; do not mix unrelated changes.
- Before creating or switching a branch, state the intended branch and check uncommitted changes. Do not switch if those changes could be affected without asking the owner.
- On apply or resume, infer the active change only when current `feature/<change-id>` and `openspec/changes/<change-id>/` agree. Otherwise ask which change to continue.
- Propose archive only after implementation, verification, and reconcile are complete. Do not archive, merge, rebase, tag, push, or create a PR without explicit authorization for that action.
- Archive directory dates are UTC. After an explicitly requested archive and merge, leave the project's main branch current; start later changes from that branch.

## Safety

- Assume existing and uncommitted changes belong to the user. Preserve them and keep unrelated edits out of the change.
- Never discard, overwrite, reset, or revert user changes; rewrite history; delete branches; or perform destructive actions unless explicitly requested.
- If user work overlaps the task, adapt when safe and ask only when continuing would be ambiguous or risk loss.
- Resolve exact targets before destructive actions and report any material deletion and whether it is recoverable.

## Coherence And Payload

- Never edit `openspec/changes/archive/`; it is history, not current policy.
- Repair objective `mechanical` findings. Record supported `semantic` and `structural` findings in `docs/DEBT.md` without silently choosing the desired behavior.
- Current-change regressions must be fixed and verified before acceptance or archive, unless the owner explicitly permits deferral with documented consequences. Recording in `docs/DEBT.md` alone does not establish readiness; request the owner decision when required.
- `.project-workframe-version` records the applied Workframe version, installed modules, and deliberately skipped upgrade parts. Workframe never auto-upgrades this project.
- Upgrade Workframe through a project-local OpenSpec change following the shipped guidance. Copy canonical files whole, keep project-owned documents and rules, and update the version marker only after verification.
- Do not edit canonical files to add project-specific rules or restate them from memory. Put such rules in `docs/PROJECT_RULES.md`; a completed upgrade leaves canonical files byte-identical to the selected Workframe template.
- A new payload file is valid only when a shipped rule names its path and exact trigger without duplicating its contents.
