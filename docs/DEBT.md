# Divergence And Debt Register

Durable record of Workframe's own `semantic` and `structural` findings, plus deferred work that outlived the change that discovered it.

The rules for filling and spending this register are in root `AGENTS.md`, section `Coherence`. The neutral source is `source/canonical-rules/coherence.md`. This file is the register itself.

This register covers the Workframe repository. Projects generated from Workframe keep their own `docs/DEBT.md`, shipped from `template/base/docs/DEBT.md`.

An empty register is the normal state. Do not fill it to look thorough.

## What Belongs Here

- `semantic` findings: a contradiction between two statements, or between a spec and the payload.
- `structural` findings: work that needs refactoring.
- Unfinished `## Фаза 2. Углубление` items, moved here before their change is archived.

`mechanical` findings — broken links, placeholders, references to removed entities, stale commands — are repaired immediately and never recorded here.

## Entry Format

Write entries in Russian by default, keeping paths, commands, identifiers, and code symbols in English.

Each entry records an identifier `D-<NNN>` that is never reused, a one-line title, and:

- `Класс` — `semantic` or `structural`;
- `Найдено` — date and source (reconcile of a change, or an audit id);
- `Где` — exact locations of both sides of the divergence;
- `Расхождение` — what each side actually says;
- `Возможные разрешения` — the options, without choosing one;
- `Статус` — `open`, `accepted` with a change id, `resolved` with a change id, `rejected` with a reason, or `stale`.

Entries are never deleted silently. A resolved or rejected entry keeps its record.

## Entries

### D-001 — Проверка дублирования инструкций в adapters не работает для трёх скиллов из четырёх

- Класс: semantic
- Найдено: 2026-08-18, reconcile change `add-coherence-lifecycle`
- Где: `scripts/verify-agent-adapters.sh:15` ↔ `openspec/specs/multi-agent-workflow-adapters/spec.md`
- Расхождение: скрипт проверяет отсутствие в adapter фразы `Implement tasks from an OpenSpec change.` — это описание одного скилла, `openspec-apply-change`, но проверка выполняется в цикле для всех четырёх. Для `openspec-explore`, `openspec-propose` и `openspec-archive-change` условие не может сработать. Проверено: вклейка полного канонического текста (288 строк) в `.claude/skills/openspec-explore/SKILL.md` оставляет результат скрипта `Agent adapters verified.`, exit 0
- Возможные разрешения: (a) сверять с описанием соответствующего скилла из его canonical frontmatter; (b) проверять отсутствие структурных маркеров полной инструкции, например `**Steps**`; (c) сравнивать объём adapter с порогом
- Статус: open
