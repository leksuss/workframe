---
name: openspec-apply-change
description: Implement tasks from an OpenSpec change. Use when the user wants to start implementing, continue implementation, or work through tasks.
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.3.1"
---

Implement tasks from an OpenSpec change.

**Input**: Optionally specify a change name. If omitted, check if it can be inferred from conversation context. If vague or ambiguous you MUST prompt for available changes.

**Steps**

1. **Select the change**

   If a name is provided, use it. Otherwise:
   - Infer from conversation context if the user mentioned a change
   - Auto-select if only one active change exists
   - If ambiguous, run `openspec list --json` to get available changes and use the **AskUserQuestion tool** to let the user select

   Always announce: "Using change: <name>" and how to override (e.g., `/opsx:apply <other>`).

2. **Check status to understand the schema**
   ```bash
   openspec status --change "<name>" --json
   ```
   Parse the JSON to understand:
   - `schemaName`: The workflow being used (e.g., "spec-driven")
   - Which artifact contains the tasks (typically "tasks" for spec-driven, check status for others)

3. **Get apply instructions**

   ```bash
   openspec instructions apply --change "<name>" --json
   ```

   This returns:
   - `contextFiles`: artifact ID -> array of concrete file paths (varies by schema - could be proposal/specs/design/tasks or spec/tests/implementation/docs)
   - Progress (total, complete, remaining)
   - Task list with status
   - Dynamic instruction based on current state

   **Handle states:**
   - If `state: "blocked"` (missing artifacts): show message, suggest using openspec-continue-change
   - If `state: "all_done"`: congratulate, suggest archive
   - Otherwise: proceed to implementation

4. **Read context files**

   Read every file path listed under `contextFiles` from the apply instructions output.
   The files depend on the schema being used:
   - **spec-driven**: proposal, specs, design, tasks
   - Other schemas: follow the contextFiles from CLI output

5. **Show current progress**

   Display:
   - Schema being used
   - Progress: "N/M tasks complete"
   - Remaining tasks overview
   - Dynamic instruction from CLI

6. **Implement tasks (loop until done or blocked)**

   For each pending task:
   - Show which task is being worked on
   - Make the code changes required
   - Keep changes minimal and focused
   - Run the task's declared verification method against its required production ownership path and exact expected outcome
   - Record the result as `passed`, `failed`, `skipped`, or `unavailable`, including evidence and revision/notes where applicable
   - Mark the task complete only after a passing result, or after the owner accepts a documented `skipped`/`unavailable` exception: `- [ ]` → `- [x]`
   - Continue to next task

   **Pause if:**
   - Task is unclear → ask for clarification
   - The required production path, protective boundary, or verification method is missing → update artifacts or ask for clarification
   - Implementation reveals a design issue → suggest updating artifacts
   - Error or blocker encountered → report and wait for guidance
   - A blocking method is `failed`, `skipped`, or `unavailable` without an accepted owner exception → keep the task incomplete
   - User interrupts

7. **Verify contract traceability**

   Before final completion:
   - Re-read every task and match its expected result to the production implementation/ownership path and recorded evidence. Do not infer completion from checkboxes.
   - For `behavior` and higher levels, confirm each changed requirement/scenario has implementation, evidence for the exact outcome, and a result.
   - A mock does not satisfy a required loopback/integration path; a rejection assertion does not satisfy a required success outcome; a facade test does not cover a direct public/server/default path unless the same ownership path is proven. A claim that something never happens requires an observation — a counter, a probe, a recorded absence in an artifact — not reasoning about control flow.
   - For protective boundaries, run the applicable negative/adversarial scenarios selected in design, including relevant bypass and alternate CLI/API/console/supervisor/restart/embedding paths. For a protective boundary, show each adversarial test failing with its guard removed, and record that it did.
   - Re-open persisted certification evidence through its independent verifier. Runner inline assertions or a stored-but-unchecked digest are insufficient.

8. **Handle flaky or timing-sensitive failures**

   If a blocking gate fails and a rerun passes:
   - keep the first failure in the record;
   - diagnose the check in isolation;
   - fix confirmed instability or classify it explicitly under `docs/QUALITY.md`;
   - rerun the complete blocking gate. Never report a one-off rerun as if the first failure did not happen.

9. **Perform an independent final review**

   Before claiming completion, start a fresh adversarial review pass over proposal, design, specs, tasks, final diff, and recorded results without trusting checkboxes. Look for spec/code mismatch, unverified claims, wrong-outcome tests, unreachable doubles, optimistic defaults, bypass paths, unbounded operations, runner/verifier conflation, and stale evidence. A design claim that a library, runtime, or platform guarantees X, when a safety decision rests on it, must cite an executed probe; reasoning about documented behavior is not evidence.

   For a `high-risk boundary` or `release/certification` change, use another agent/model or an equivalent isolated review context and record which method was used. A re-reading of the diff is not an adversarial pass. For `release/certification` work the independent context executes code — builds hostile inputs, runs them, records their output — and the record names what was run. Repair mechanical findings; record semantic or structural findings under the project's coherence rules.

   Final release/certification evidence must name the exact tracked revision and applicable digests. A later tracked commit makes it stale and requires the blocking gate again.

10. **On completion or pause, show status**

   Display:
   - Tasks completed this session
   - Overall progress: "N/M tasks complete"
   - If all done: suggest archive
   - If paused: explain why and wait for guidance

**Output During Implementation**

```
## Implementing: <change-name> (schema: <schema-name>)

Working on task 3/7: <task description>
[...implementation happening...]
✓ Task complete

Working on task 4/7: <task description>
[...implementation happening...]
✓ Task complete
```

**Output On Completion**

```
## Implementation Complete

**Change:** <change-name>
**Schema:** <schema-name>
**Progress:** 7/7 tasks complete ✓

### Completed This Session
- [x] Task 1
- [x] Task 2
...

All tasks complete! Ready to archive this change.
```

**Output On Pause (Issue Encountered)**

```
## Implementation Paused

**Change:** <change-name>
**Schema:** <schema-name>
**Progress:** 4/7 tasks complete

### Issue Encountered
<description of the issue>

**Options:**
1. <option 1>
2. <option 2>
3. Other approach

What would you like to do?
```

**Guardrails**
- Keep going through tasks until done or blocked
- Always read context files before starting (from the apply instructions output)
- If task is ambiguous, pause and ask before implementing
- If implementation reveals issues, pause and suggest artifact updates
- Keep code changes minimal and scoped to each task
- Update a task checkbox only after its declared verification result is recorded
- Pause on errors, blockers, or unclear requirements - don't guess
- Use contextFiles from CLI output, don't assume specific file names
- Before final completion, trace every completed task to its stated result, production path, exact outcome, and verification evidence
- An aggregate green suite is not proof of a task scenario that did not run
- Do not declare completion when a required negative scenario, independent verifier, final-revision binding, or owner decision for a non-passing blocking result is missing

**Fluid Workflow Integration**

This skill supports the "actions on a change" model:

- **Can be invoked anytime**: Before all artifacts are done (if tasks exist), after partial implementation, interleaved with other actions
- **Allows artifact updates**: If implementation reveals design issues, suggest updating artifacts - not phase-locked, work fluidly
