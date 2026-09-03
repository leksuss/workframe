## 1. Baseline и contract map

- [x] 1.1 Зафиксировать в change evidence baseline размеров automatically loaded и on-demand instruction surfaces и mapping каждого раздела текущих `AGENTS.md` к retained invariant либо shipped canonical destination; затронуты root и `template/base/`, уникальные обязательства нельзя потерять; проверить mapping повторным чтением обоих исходных файлов и destination paths.
- [x] 1.2 Выполнить обязательные срезы coherence audit 1–3 для всего репозитория без `openspec/changes/archive/`; mechanical findings исправить, semantic/structural не менять; проверить paths, placeholders и declared payload существующими probes и записать результаты.

## 2. Компактные entry points

- [x] 2.1 Сократить root `AGENTS.md` до scope/safety/routing и Workframe-specific invariants, адресовав `source/canonical-rules/{workflow,verification,coherence}.md` точными triggers; результат должен сохранить root/template boundary, branch/release и destructive-change gates; проверить mapping из 1.1 и размер не более 10 000 bytes.
- [x] 2.2 Сократить `template/base/AGENTS.md` до project invariants и trigger-based addresses на shipped `docs/AGENT_WORKFLOW.md`, `docs/QUALITY.md` и checklists; generated project остаётся самодостаточным и не требует `source/`; проверить mapping, init-project fixture и размер не более 10 000 bytes.
- [x] 2.3 Обновить `template/base/CLAUDE.md`, generic/client adapter notes, README и `docs/UPGRADING.md`, чтобы они не называли on-demand workflow always-on и объясняли новый routing без пересказа процедур; проверить все упомянутые paths и согласие английской/русской README.

## 3. Budget verification

- [x] 3.1 Добавить `scripts/verify-instruction-budget.sh`, который измеряет declared entry points/on-demand corpus, применяет абсолютные byte ceilings и проверяет canonical paths/triggers; production ownership path — repository verification scripts; проверить happy path и временные over-budget/missing-address hostile fixtures.
- [x] 3.2 Адаптировать `scripts/verify-contract-driven-workflow.sh` к новому ownership split: точные verification obligations должны проверяться в canonical corpus, а `AGENTS.md` — по trigger/address; проверить, что удаление address ломает gate, а изменение canonical guard phrase по-прежнему обнаруживается.

## 4. Полный аудит и выпуск

- [x] 4.1 Выполнить пропорциональные срезы coherence audit 4–7: specs↔implementation, duplication/divergence, dead artifacts и structure; записать evidence, исправить только mechanical findings, а подтверждённые semantic/structural findings вне scope занести в `docs/DEBT.md` с обеими цитатами.
- [x] 4.2 Запустить `openspec validate optimize-instruction-budget --strict`, все repository verification scripts и проверку generated-project fixture; записать scenario → production path → evidence → result и сохранить первую ошибку, если blocking gate потребует rerun.
- [x] 4.3 Выполнить reconcile изменённых артефактов, выбрать `MINOR`, обновить `VERSION` и перенести записи `CHANGELOG.md` в датированную секцию; проверить отсутствие placeholders, актуальность specs/tasks и соответствие final diff записанному instruction-footprint evidence.
