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
- Разрешение: вариант (c) — проверка объёма adapter в сочетании с обязательной ссылкой на канонический файл. Вариант (b) проверен и отклонён: маркер `**Steps**` отсутствует в `openspec-explore`, то есть пропустил бы случай, на котором дефект был воспроизведён. Вариант (a) отклонён: привязывает проверку к тексту upstream-описаний, меняющихся при обновлении OpenSpec CLI
- Статус: resolved, change `add-coherence-audit-skill`

### D-002 — `init-project.sh` ставит README модуля agent-skills как README генерируемого проекта

- Класс: semantic
- Найдено: 2026-08-18, аудит `coherence-audit-2026-08`, срез 3
- Где: `scripts/init-project.sh:61` ↔ `template/modules/agent-skills/README.md:1`
- Расхождение: строка `cp -R "$ROOT_DIR/template/modules/agent-skills/." "$TARGET/"` копирует и README модуля. Воспроизведено: инициализация в пустой каталог даёт `README.md` с первой строкой `# Portable Agent Skills Module`, побайтово совпадающий с README модуля. Ни таблица payload в `README.md`, ни `template/base/` не объявляют README частью payload. Для существующего проекта это перезапись его собственного README. Тот же дефект содержит инструкция ручного копирования в `template/modules/agent-skills/README.md:8`
- Возможные разрешения: (a) исключать README модуля при копировании; (b) перенести документацию модуля из копируемого каталога; (c) переименовать её так, чтобы она не претендовала на корневой README проекта
- Разрешение: вариант (a) в форме перечисления каталогов payload при копировании — тем же приёмом, каким уже ставятся `design-pencil` и `frontend-quality`. Удаление файла после копирования отклонено как опасное: `rm` по фиксированному имени уничтожил бы одноимённый файл проекта. Исключение через `rsync`/`tar` отклонено как новая зависимость. Инструкция ручного копирования в README модуля исправлена вместе со скриптом
- Статус: resolved, change `fix-generated-project-payload`

### D-003 — `source/profiles/` и `examples/` дублируют одну роль, каталог не объявлен в схеме

- Класс: semantic
- Найдено: 2026-08-18, аудит `coherence-audit-2026-08`, срезы 3 и 5
- Где: `source/profiles/` ↔ `examples/` ↔ `docs/CONCEPTS.md:54` ↔ схема репозитория в `README.md:104` и `README.ru.md:104`
- Расхождение: оба каталога содержат по три одноимённых подкаталога `django-app`, `telegram-bot`, `scraper-service`. `source/profiles/django-app/README.md:3` предлагает «use this profile when adapting Workframe to a Django project», `examples/django-app/README.md:3` называет себя «an example profile note». `docs/CONCEPTS.md:54` отсылает к «профилю» вроде `django-app`, не указывая, к какому из двух. Схема репозитория в обоих README перечисляет `examples/`, но не `source/profiles/`
- Возможные разрешения: (a) объединить в один каталог и обновить `docs/CONCEPTS.md` и схему; (b) развести роли явно и объявить оба в схеме; (c) удалить один из каталогов
- Разрешение: вариант (c) по решению владельца — оставлен `examples/`, удалён `source/profiles/`. `examples/` уже присутствовал в схеме обоих README, поэтому правок документации потребовалось меньше. Обновлены `AGENTS.md`, `docs/CONCEPTS.md`, `docs/UPGRADING.md` и три файла в `examples/`; `CHANGELOG.md` не изменён, его запись относится к выпущенной 0.1.0
- Статус: resolved, change `fix-generated-project-payload`

### D-004 — `openspec archive` именует каталог архива по UTC, а репозиторий ведёт даты по локальному времени

- Класс: semantic
- Найдено: 2026-08-18, аудит `coherence-audit-2026-08`, срез 3
- Где: `openspec/changes/archive/2026-08-18-add-coherence-lifecycle/.openspec.yaml` ↔ имя каталога, присвоенное CLI при архивации
- Расхождение: при архивации в 01:48 MSK CLI назвал каталог `2026-08-17-add-coherence-lifecycle`, тогда как `.openspec.yaml` того же change содержит `created: 2026-08-18`, а остальные архивы датированы по локальному времени. Каталог переименован вручную. Расхождение воспроизводится при любой архивации между 00:00 и 03:00 по местному времени
- Возможные разрешения: (a) документировать переименование как шаг архивации в правилах; (b) принять UTC как конвенцию дат архива и привести к ней `.openspec.yaml`; (c) считать вопрос несущественным и закрыть запись как `rejected`
- Статус: open

### D-005 — Три раздела правил побайтово дублируются между root и payload

- Класс: structural
- Найдено: 2026-08-18, аудит `coherence-audit-2026-08`, срез 5
- Где: `AGENTS.md` ↔ `template/base/AGENTS.md`
- Расхождение: разделы `OpenSpec Task Design`, `Work Sequencing` и `Git Safety` совпадают побайтово. Архитектура предполагает, что источником служит `source/canonical-rules/`, а оба `AGENTS.md` являются адаптациями; для этих трёх разделов адаптация не вносит ничего, кроме риска расхождения. Стоимость наблюдалась: change `add-coherence-lifecycle` правил `Work Sequencing` дважды одинаковым текстом. Файлы выросли до 199 и 216 строк при принципе `docs/CONCEPTS.md:29` о payload, который остаётся достаточно малым для ручного чтения и правки
- Возможные разрешения: (a) оставить как есть, признав дублирование ценой независимости root и payload; (b) вынести совпадающие разделы в отдельный общий файл, на который ссылаются оба; (c) сократить сами разделы, оставив подробности в `docs/AGENT_WORKFLOW.md`
- Разрешение: вариант (a) по решению владельца. Совпадает двадцать непустых строк; вариант (b) невозможен, потому что `template/base/AGENTS.md` обязан работать в проекте, где каталога `source/` не существует, а вариант (c) сокращал бы сами правила ради формы
- Статус: rejected, дублирование принято как цена самодостаточности payload

### D-006 — Схема spec-driven отвергает аудит, не меняющий требований

- Класс: semantic
- Найдено: 2026-08-18, аудит `coherence-audit-2026-08`, при валидации самого change
- Где: `openspec/config.yaml:1` (`schema: spec-driven`) ↔ `template/base/docs/checklists/coherence-audit.md` ↔ `openspec/specs/coherence-lifecycle/spec.md`, требование «Глубокий аудит согласованности»
- Расхождение: правила предписывают оформлять аудит обычным OpenSpec change, но `openspec validate` отвергает change без дельты со словами `Change must have at least one delta. No deltas found.` Воспроизведено на этом аудите: валидация не проходила, пока не появилась дельта `coherence-lifecycle`. Аудит, нашедший только `mechanical`-находки, требований не меняет, а значит не сможет быть оформлен предписанным способом. В этом прогоне дельта нашлась настоящая, что скрыло проблему; в целевом проекте она проявится на первом же чисто механическом аудите
- Возможные разрешения: (a) архивировать такой аудит с `--skip-specs` и задокументировать это как штатный шаг; (b) разрешить аудиту без изменения требований обходиться без OpenSpec change, оформляя его прямой правкой с записью в реестр; (c) выяснить, поддерживает ли OpenSpec схему, допускающую change без дельты, и выбрать её для аудита
- Статус: open
