---
name: design-orchestration
description: Use when creating, reviewing, or implementing design work across design artifacts, frontend code, screenshots, and quality reference rules.
---

# Design Orchestration

Use this skill for design-aware work: creating or reviewing design artifacts, implementing approved designs in code, importing existing components into a design tool, or improving frontend experience while respecting the project's product concepts and existing stack.

Current optional design tool adapter: Pencil (`.pen`, Pencil MCP, screenshots, variables).

Current quality references:

- Default broad quality reference: `references/taste-skill.md`.
- Minimal/editorial reference: `references/minimalist-ui.md`.

## Entry Points

Use this skill when the user asks for design, redesign, visual polish, mockups, Pencil work, screenshots, UI implementation from a design artifact, or frontend quality review.

Use two main actions:

1. **Design Authoring / Review**: create, critique, or improve the design artifact or visual direction.
2. **Design Implementation**: read an approved design artifact and transfer it into production code.

## Precedence

Apply inputs in this order:

1. Project rules, `AGENTS.md`, `docs/CONCEPTS.md`, and active OpenSpec change.
2. Existing codebase conventions, dependencies, design system, and package files.
3. Approved design artifact: layout, hierarchy, component structure, variables, spacing, sizing, assets.
4. Chosen quality reference: typography polish, state completeness, motion restraint, density, accessibility, and anti-generic UI discipline.

When these conflict, higher items win.

## Shared Setup

1. For non-trivial behavior/design changes, follow the repository OpenSpec workflow before implementation.
2. Read `docs/CONCEPTS.md` when the task affects product behavior, audience fit, identity, integrations, or redesign direction.
3. Inspect the existing frontend stack before importing libraries:
   - check package files;
   - check existing styling approach and UI components;
   - use the project's icon library when present.
4. Locate the design artifact when one exists.
5. Before changing any `.pen` file, verify Pencil MCP tools are available in the current context.
6. If Pencil MCP is unavailable, do not edit `.pen` files; work from screenshots/exports or ask the user to enable Pencil MCP in a refreshed session.
7. Read the narrowest useful quality reference only when the task needs detailed design quality rules.

## Structure Impact Check

Run this check for every design or implementation request, even when the user describes it as visual.

Treat the request as a structure change when it introduces or changes any of these:

- content types, data models, database tables, collections, or domain entities;
- fields, validation rules, computed values, or user-editable metadata;
- taxonomies, categories, tags, series, navigation, grouping, or route-relevant metadata;
- URL behavior, redirects, pagination, permissions, API contracts, protocol behavior, or background jobs;
- editor-facing forms, publication readiness checks, import mapping, build-time queries, or generated schemas;
- design sections that require data to be created, validated, filtered, sorted, persisted, or reused.

Classify the change before editing:

- **Design-artifact-only**: visual composition, spacing, typography, color, or static copy in the mockup.
- **Frontend-only**: layout/components/styles/routes that use already-known data contracts.
- **Product/data contract**: new or changed models, fields, schemas, permissions, routes, APIs, validation, or editor forms.
- **Migration**: existing data/content needs transformation after the contract changes.

For product/data contract changes and migrations, update OpenSpec before implementation.

## Action 1: Design Authoring / Review

Use this action to create or improve the design artifact before writing production code.

1. Inspect the product context, audience, content/data shape, and existing visual constraints.
2. Inspect the current design artifact when it exists.
3. Apply the chosen quality reference as a critique and generation filter.
4. Include desktop and mobile frames for page-level work when useful.
5. Use realistic content from the project instead of generic filler.
6. If the design introduces new structured data or behavior, record that as a product/contract change.
7. Stop at the design artifact unless the user explicitly asks to implement code in the same turn.

## Action 2: Design Implementation

Use this action to make the code match an approved design artifact.

1. Inspect the approved design artifact or screenshot.
2. Extract layout, hierarchy, spacing, tokens, assets, content, responsive behavior, and states.
3. Run the Structure Impact Check.
4. If the design requires a product/data contract change, update the OpenSpec change before code depends on it.
5. Implement the smallest faithful code delta.
6. Verify visually when possible:
   - use the local browser target for changed frontend UI;
   - compare against design screenshots or exports when available;
   - fix obvious overlap, clipping, broken responsive behavior, and text overflow.

## Conflict Rules

- Layout, hierarchy, spacing, sizing, slots, and component structure: follow the approved design artifact.
- Named design variables and design tokens: preserve names when syncing to code.
- Existing project dependencies and patterns: follow the codebase.
- Icons: use the icon set already used by the project.
- Motion: use restraint unless the product and design direction call for high motion.
- Visual polish may improve type rendering, contrast, states, responsive resilience, and anti-generic details without changing approved structure.

## What Not To Do

- Do not ignore an approved design artifact and generate from scratch.
- Do not change `.pen` files when Pencil MCP is unavailable.
- Do not add new animation, icon, or UI libraries before checking dependencies and local conventions.
- Do not use placeholder code, fake skeletons, or incomplete states for production-facing UI.
- Do not rewrite unrelated components while syncing a design delta.
- Do not make a design artifact the source of truth for product data contracts.

## Pre-Flight Checklist

- Design source of truth was inspected or the missing source was explicitly noted.
- Existing stack and dependencies were checked before imports.
- Structure Impact Check was run.
- Loading, empty, error, hover, active, focus, disabled, and responsive states were considered where relevant.
- Visual verification was run or the reason it could not run was reported.
