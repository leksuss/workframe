# Divergence And Debt Register

This file is the durable record of findings that an agent must not resolve on its own, plus deferred work that outlived the change that discovered it.

It exists because everything else has a shorter life. A change's `## Фаза 2. Углубление` section is archived with the change. Chat context ends with the session. This file stays.

An empty register is the normal state of a healthy project. Do not fill it to look thorough.

## What Belongs Here

- `semantic` findings: a contradiction between two statements, or between a spec and the code.
- `structural` findings: work that needs refactoring — an overgrown file, blurred boundaries, duplicated logic.
- Unfinished `## Фаза 2. Углубление` items, moved here before their change is archived.

## What Does Not Belong Here

- `mechanical` findings — broken links, placeholders, references to removed entities, stale commands. Repair those immediately instead of recording them.
- Feature ideas and product wishes. This is a register of divergence and debt, not a product backlog.
- Suspicions that cannot be supported by quoting both sides of the divergence with their locations.

## Entry Format

Write entries in Russian by default, keeping paths, commands, identifiers, and code symbols in English — the same rule the project applies to OpenSpec artifacts.

Each entry records:

- an identifier `D-<NNN>`, never reused;
- a one-line title;
- `Класс` — `semantic` or `structural`;
- `Найдено` — date and source (reconcile of a change, or an audit id);
- `Где` — exact locations of both sides of the divergence;
- `Расхождение` — what each side actually says;
- `Возможные разрешения` — the available options, without choosing one;
- `Статус`.

## Statuses

- `open` — recorded, no decision yet.
- `accepted` — the owner decided to resolve it; names the change id that will do so.
- `resolved` — done; names the change id that did it.
- `rejected` — the owner decided not to act; states why.
- `stale` — overtaken by events; confirmed by a later audit.

Entries are never deleted silently. A resolved or rejected entry keeps its record.

## Rules Of Use

- **Filled** by the reconcile step before archive, and by audits.
- **Spent** during planning: before starting a change, check for open entries in the area it will touch anyway. This is the only way debt is repaid in practice.
- **Revalidated** by every audit: entries overtaken by events become `stale`, so the register does not grow monotonically.
- **Forced to a decision**: an entry that survives several audits without movement is put to the owner explicitly. A register nobody reads is the problem it was meant to solve.

## Entries

_None yet._

<!--
Example of the expected shape. Delete nothing above this comment; add real entries
under "Entries" in this form.

### D-001 — Спека session-auth требует ротацию refresh-token, код её не делает

- Класс: semantic
- Найдено: 2026-08-18, reconcile change `add-session-auth`
- Где: `openspec/specs/session-auth/spec.md:44` ↔ `src/auth/session.py:120`
- Расхождение: спека требует ротацию токена при обновлении сессии; код продлевает срок,
  оставляя значение токена прежним
- Возможные разрешения: (a) реализовать ротацию; (b) снять требование из спеки как
  несостоявшееся решение
- Статус: open
-->
