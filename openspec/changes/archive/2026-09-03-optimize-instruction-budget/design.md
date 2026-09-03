## Context

Корневой `AGENTS.md` содержит 15 617 символов, payload `template/base/AGENTS.md` — 17 793; это 33 410 символов в двух independently used always-loaded entry points. Подробности verification, coherence, task design и sequencing одновременно присутствуют в `source/canonical-rules/`, `template/base/docs/AGENT_WORKFLOW.md` и чек-листах. Тонкие skill adapters уже показывают рабочий pattern: короткий автоматически обнаруживаемый файл называет trigger и canonical source, а полная процедура загружается только при применении.

Предыдущее решение D-005 сохранило дублирование ради самодостаточности payload. Оно не запрещает новый подход: payload будет ссылаться только на файлы, которые приезжают с ним, поэтому самодостаточность сохраняется. Владелец теперь явно поставил instruction footprint в критерии качества.

Изменение относится к уровню `behavior`: оно меняет способ доставки обязательных правил агенту, но не затрагивает защитную или внешнюю boundary.

## Goals / Non-Goals

**Goals:**

- уменьшить символы в automatically loaded entry points не менее чем на 35% для root и payload `AGENTS.md` по отдельности;
- сохранить каждое действующее обязательство либо непосредственно в entry point, либо в shipped canonical source с точным trigger чтения;
- измерять raw UTF-8 bytes как воспроизводимый proxy для token cost и защищать budget проверкой;
- завершить полный coherence audit по семи срезам и отделить его находки от instruction-budget решения.

**Non-Goals:**

- оптимизировать архив OpenSpec, README или on-demand skills только ради их размера;
- обещать точное число tokens, зависящее от модели и tokenizer;
- менять product workflow, уровень verification либо автоматически обновлять существующие проекты;
- объединять root и payload governance в общий runtime-файл, которого не будет в сгенерированном проекте.

## Decisions

### 1. Считать отдельно always-loaded entry points и on-demand sources

Budget применяется к `AGENTS.md`, `template/base/AGENTS.md`, `template/base/CLAUDE.md` и client discovery adapters. `source/canonical-rules/`, `docs/AGENT_WORKFLOW.md`, checklists и canonical skills измеряются в отчёте, но не ограничиваются тем же потолком: они входят в контекст только при trigger.

Альтернатива — суммировать все Markdown instructions репозитория — отклонена: это не соответствует фактической цене одного запроса и поощряет удаление полезных on-demand процедур.

### 2. Entry point остаётся индексом обязательств

В `AGENTS.md` остаются scope, safety invariants, root/payload boundary, правила выбора workflow и точные triggers. Подробные task design, verification, sequencing и coherence procedures читаются из canonical source перед planning, implementation, review, reconcile или audit соответственно. Формулировка trigger требует прочитать файл полностью, а не предлагает его как справку.

Для root используются `source/canonical-rules/workflow.md`, `verification.md`, `coherence.md`; root-specific OpenSpec branch, release и payload rules остаются в root `AGENTS.md`. Для generated project используется shipped `docs/AGENT_WORKFLOW.md`, `docs/QUALITY.md` и checklists.

Альтернатива — оставить короткое резюме каждой процедуры вместе со ссылкой — отклонена: резюме снова становится второй нормативной копией.

### 3. Проверка использует абсолютные потолки и обязательные addresses

Новый `scripts/verify-instruction-budget.sh`:

- печатает размер каждого entry point и on-demand corpus;
- ограничивает root и payload `AGENTS.md` потолком 10 000 bytes каждый, а `CLAUDE.md` — 1 000 bytes;
- проверяет наличие canonical addresses и ключевых triggers;
- не использует оценку tokens как pass/fail критерий.

Потолок выше целевого результата оставляет место для новых критичных invariants, но не позволяет вернуть нынешнее крупное дублирование. Процент сокращения проверяется и фиксируется в change evidence относительно baseline, а не вычисляется в будущих запусках из mutable Git history.

### 4. Полный coherence audit остаётся отдельной матрицей результата

Срезы 1–3 выполняются механическими probes; срезы 4–7 — сопоставлением specs, payload, adapters и inbound references. Mechanical findings исправляются. Semantic/structural findings получают запись в `docs/DEBT.md` только при наличии обеих цитат; архив не редактируется.

## Risks / Trade-offs

- [Агент не откроет файл по ссылке] → trigger формулируется как обязательное действие; при сомнении он применяется fail-closed; verification script проверяет address и эту fallback-фразу, а workflow tests проверяют нужные канонические фразы в конечном shipped corpus, не обязательно в `AGENTS.md`.
- [Сокращение случайно удалит уникальное правило] → перед заменой строится mapping текущих sections к destination; проверка ищет обязательные paths/triggers, затем change проходит diff review и все существующие workflow probes.
- [Byte ceiling станет бессмысленной vanity metric] → budget применяется только к автоматически загружаемым entry points; функциональные assertions остаются отдельными и имеют приоритет.
- [Дополнительное чтение увеличит цену сложного запроса] → сложная работа всё равно требует полной процедуры; экономия предназначена для простых запросов и для исключения нерелевантных процедур.
- [Новая версия потребует upgrade существующих проектов] → это совместимый `MINOR`: новые проекты получают компактный payload, существующие принимают его только через explicit upgrade.
