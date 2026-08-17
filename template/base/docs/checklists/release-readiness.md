# Release Readiness Checklist

Use this before publishing, deploying, merging, or archiving meaningful work.

- The implemented behavior matches the active OpenSpec change.
- Specs and tasks reflect the final behavior.
- `docs/QUALITY.md` matches the implemented pipeline and current canonical commands.
- Declared blocking checks passed; any `skipped` or `unavailable` result has an explicit reason and owner decision about its impact.
- Applicable advisory findings were triaged as `confirmed`, `false positive`, or `deferred`.
- Important manual verification was performed where automated checks are insufficient.
- Documentation close to the changed behavior was updated.
- No placeholder remains in any artifact this change created or modified, including specs synced during archive.
- Entities this change removed are gone from every reference across the repository.
- Unfinished `## Фаза 2. Углубление` items were moved to `docs/DEBT.md` before archive.
- `semantic` and `structural` findings noticed during the change were recorded in `docs/DEBT.md` rather than silently repaired.
- No unrelated user changes were reverted or mixed in.
- Known risks, accepted exceptions, deferred findings, and follow-up work are documented.
- The user has explicitly requested any merge, archive, push, deployment, or destructive operation.
