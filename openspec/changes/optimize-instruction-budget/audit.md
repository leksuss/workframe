# Instruction Footprint And Coherence Audit

## Baseline

Измерение выполнено до правок entry points. `characters` получены через `wc -m`, `bytes` — через `wc -c`; budget использует bytes.

| Surface | Loading class | Characters | Bytes |
| --- | --- | ---: | ---: |
| root `AGENTS.md` | always-loaded for Workframe | 15 617 | 15 681 |
| `template/base/AGENTS.md` | always-loaded in generated project | 17 793 | 17 859 |
| `template/base/CLAUDE.md` | Claude entry point | 359 | 359 |
| root `source/canonical-rules/*.md` | on demand | 24 672 | 24 898 |
| payload workflow, quality and four checklists | on demand | 38 878 | 39 113 |

Root и payload `AGENTS.md` не складываются как цена одного запроса: они принадлежат разным project contexts. Baseline `33 410 characters` показывает общий объём двух копий, которые нужно сопровождать, а экономия оценивается для каждой поверхности отдельно.

## Contract Map

### Root `AGENTS.md`

| Existing section | Destination | Trigger/address retained in entry point |
| --- | --- | --- |
| Project Context | retained | before non-trivial change: `docs/CONCEPTS.md` |
| Feature Workflow | split | before planning/implementation: `source/canonical-rules/workflow.md`; root approval gates retained |
| OpenSpec Task Design | canonical | before proposal/task design: `source/canonical-rules/verification.md` |
| Contract-Driven Verification | canonical | before implementation/verification/review: `source/canonical-rules/verification.md` |
| Work Sequencing | canonical | before planning/implementation of large work: `source/canonical-rules/workflow.md` |
| OpenSpec And Git Branches | split | generic one-change/one-branch rule in `workflow.md`; Workframe archive/merge sequence retained |
| Git Safety | retained | always active |
| Documentation Discipline | retained | always active for repository changes |
| Workframe Versioning | retained | completion/archive trigger |
| Coherence | canonical | before reconcile/audit: `source/canonical-rules/coherence.md`; root/template boundary retained |
| Bootstrap Note | retained | history interpretation |

### Payload `template/base/AGENTS.md`

| Existing section | Destination | Trigger/address retained in entry point |
| --- | --- | --- |
| Session Handoff | retained compactly | before mutations: repository/OpenSpec state |
| Project Context | retained compactly | before non-trivial work: concepts and project rules |
| Feature Workflow | `docs/AGENT_WORKFLOW.md` + checklists | non-trivial planning/implementation |
| OpenSpec Task Design | `docs/AGENT_WORKFLOW.md` | proposal/task design |
| Contract-Driven Verification | `docs/AGENT_WORKFLOW.md` + `docs/QUALITY.md` | implementation/verification/review |
| Quality Pipeline | `docs/AGENT_WORKFLOW.md` + `docs/QUALITY.md` | technology-surface change |
| Work Sequencing | `docs/AGENT_WORKFLOW.md` | system/large feature planning and implementation |
| OpenSpec And Git Branches | split | generic details in workflow; approval and active-branch gates retained |
| Git Safety | retained | always active |
| Documentation Discipline | retained compactly | repository changes |
| Coherence | workflow + release/audit checklists | reconcile/archive/audit triggers |
| Design Discipline | `docs/checklists/design-change.md` | design work |
| Workframe Payload | retained compactly | payload upgrade/change |

Повторное чтение destinations подтвердило наличие task design, sequencing, verification evidence, quality pipeline, coherence classification/reconcile/audit и design steps. Уникальные root release и payload-upgrade obligations остаются в entry points.

## Optimized Footprint

| Surface | Baseline bytes | Final bytes | Reduction |
| --- | ---: | ---: | ---: |
| root `AGENTS.md` | 15 681 | 6 263 | 60.1% |
| `template/base/AGENTS.md` | 17 859 | 5 808 | 67.5% |
| `template/base/CLAUDE.md` | 359 | 380 | −5.8% |

Claude's 21-byte increase makes the loading split explicit; its combined entry path (`CLAUDE.md` + payload `AGENTS.md`) falls from 18 218 to 6 188 bytes (66.0%). On-demand corpora remain available and are reported separately.

## Coherence Audit Results

### Slice 1 — Referential Integrity

`passed`. Проверены Markdown links вне `openspec/changes/archive/`, синтаксис всех `scripts/*.sh`, referenced payload paths и исполняемые repository verification commands. Broken links не найдены.

Mechanical repair: `template/base/docs/checklists/coherence-audit.md` теперь требует `docs/QUALITY.md` только когда он существует. Payload всегда поставляет файл, а root Workframe использует этот checklist без root `docs/QUALITY.md`.

### Slice 2 — Placeholders

`passed`. Поиск `TBD|TODO|FIXME|pending`, `Update ... after` и `Replace this row` проверен вручную. Совпадения относятся к самой процедуре поиска, upgrade guidance или к spec-required состоянию `pending stack selection` в `template/base/docs/QUALITY.md`; незаполненных артефактов не найдено.

### Slice 3 — Declared Against Actual

`passed`. README payload table сопоставлена с `template/base/` и optional modules; 86 tracked non-archive files проверены. `scripts/init-project.sh` и verification fixtures остаются окончательным executable evidence после реализации.

### Slices 4–7

#### Slice 4 — Specs Against Implementation

`passed`. Все 10 active specs и change delta проверены `openspec validate --all --strict` (11/11). Existing behavior имеет executable paths в `init-project.sh`, `check-workframe-update.sh`, adapter и contract gates; новое behavior принадлежит `scripts/verify-instruction-budget.sh` и compact entry points. Неподтверждённого spec/code расхождения не найдено.

#### Slice 5 — Duplication And Divergence

`passed`. Длинное дублирование root/payload `AGENTS.md` устранено, D-005 пересмотрена и закрыта этим change. Совпадающие строки в client adapters являются обязательными короткими discovery pointers в разных client-specific paths и проверяются `verify-agent-adapters.sh`; это не независимые копии workflow. Полные root skills и payload canonical skills загружаются по требованию, принадлежат разным runtime contexts и не входят в per-request footprint.

#### Slice 6 — Dead Artifacts

`passed`. Heuristic поиска файлов без буквального inbound path выделил client discovery paths, templates, licenses и root local skills. Для каждого класса существует не текстовая ownership path: client discovery convention, `init-project.sh`, design skill reference либо root skill loader. Отсутствие literal path не принято как доказательство неиспользования; подтверждённых dead artifacts нет.

#### Slice 7 — Structure

`passed`. Главный overgrown always-loaded слой разделён на compact router и focused on-demand sources. `docs/AGENT_WORKFLOW.md`, canonical rules и skills остаются крупнее entry points, но каждый имеет одну workflow responsibility и загружается только при trigger. Новых structural findings не обнаружено.

Новых `semantic` или `structural` записей не создано. D-005 изменена с `rejected` на `resolved` после нового явного решения владельца; остальные записи реестра сохраняют актуальные resolved/stale states.

## Verification Matrix

| Requirement/scenario | Production ownership path | Evidence | Result |
| --- | --- | --- | --- |
| Baseline distinguishes loading classes | change `audit.md` | deterministic `wc -m`/`wc -c` measurements and file classification | passed |
| Existing obligations have a destination | root/payload entry points plus canonical files | section-by-section contract map and destination re-read | passed |
| Coherence slices 1–3 | repository docs, scripts and payload | link probe, placeholder review, shell syntax and declared/actual comparison | passed |
| Root entry stays within budget and routes every canonical procedure | root `AGENTS.md` | `scripts/verify-instruction-budget.sh`; 6 263 / 10 000 bytes | passed |
| Payload entry stays within budget and routes shipped procedures | `template/base/AGENTS.md`, `CLAUDE.md` | budget gate; 5 808 / 10 000 and 380 / 1 000 bytes | passed |
| Uncertain trigger fails closed | root/payload `AGENTS.md`, canonical workflow | required fallback phrase checked by instruction-budget gate | passed |
| Over-budget and missing-address cases fail closed | `scripts/verify-instruction-budget.sh` | `--self-test` hostile fixtures | passed |
| Contract guards remain in canonical ownership paths | workflow docs and verification script | `scripts/verify-contract-driven-workflow.sh --self-test` | passed |
| Existing and changed specs match executable behavior | specs, payload and verification scripts | `openspec validate --all --strict`: 11 passed, 0 failed; all repository scripts passed | passed |
| Fresh and upgrade payload paths preserve the routing split | `init-project.sh`, generated and upgrade fixtures | `scripts/verify-contract-driven-workflow.sh` | passed |
| Coherence slices 4–7 | specs, adapters, references and structure | strict validation, duplication scan, inbound-reference heuristic, final structural review | passed |
| Final reconcile covers current worktree | all changed artifacts | `git diff --check`, strict OpenSpec validation, shell syntax, adapter/budget/contract gates, Markdown-link probe | passed |

Все blocking checks прошли с первого запуска; failed/rerun history отсутствует. Change не создаёт persisted certification artifact и не относится к `release/certification`, поэтому revision-bound independent verifier не применяется. Аннотированный tag создаётся после release commit по обычному archive workflow, а не в незакоммиченном worktree.
