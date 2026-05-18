# Design And Pencil Module

Copy this module into a project when design artifacts, Pencil, screenshots, or frontend quality references should be part of the agent workflow.

Pencil MCP is optional and disabled by default. The workflow is always available, but direct `.pen` editing is allowed only when the runtime exposes Pencil MCP tools.

## Install

From the target project root:

```bash
cp -R /path/to/workframe/template/modules/design-pencil/.codex .
```

## Included

- `design-orchestration` Codex skill.
- `taste-skill` reference snapshot.
- `minimalist-ui` reference snapshot.

## Rule

The design artifact is a visual source of truth, not a product strategy document and not a data schema. If a mockup implies new data fields, routes, API contracts, permissions, or content structure, treat that as a product/contract change and use OpenSpec.
