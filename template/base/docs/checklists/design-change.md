# Design Change Checklist

Use this checklist for visual, interaction, or frontend experience changes.

## Source Of Truth

- Identify the design source: existing UI, design artifact, screenshot, brand reference, or explicit user request.
- If a `.pen` file must be edited, verify Pencil MCP is available before making changes.
- If Pencil MCP is unavailable, work from exports or ask the user to enable it.

## Structure Impact

Classify the change before editing:

- Design-only: visual composition, spacing, typography, color, static copy.
- Frontend-only: layout/components/styles using existing data fields and routes.
- Contract change: new or changed content fields, data models, schemas, permissions, routes, API contracts, validation, or editor-facing forms.
- Migration: existing data or content needs transformation.

Contract changes and migrations should go through OpenSpec before implementation.

## Implementation Quality

- Follow existing frontend stack and UI conventions.
- Avoid adding new UI, icon, animation, or styling libraries without checking the project.
- Consider loading, empty, error, hover, active, focus, and disabled states.
- Check mobile and desktop layout.
- Check text overflow and overlap.
- Verify visually when possible.

## Handoff

- Record any design decisions that affect future behavior.
- Keep the design artifact and implemented behavior aligned.
- Report what was verified and what remains unverified.
