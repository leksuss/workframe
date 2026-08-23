## Why

Первый coherence audit в проекте, созданном из Workframe, показал две смежные болезни payload. Часть файлов приезжает в проект без единого правила, которое их адресует: `docs/checklists/feature-change.md`, `design-change.md`, `release-readiness.md`, `frontend-quality.md` и `.project-workframe-version` не упомянуты ни в `template/base/AGENTS.md`, ни в `template/base/docs/AGENT_WORKFLOW.md` — агент, читающий правила проекта, о них не узнаёт никогда. Одновременно ручной апгрейд проекта ничем не защищён от пересказа: большие файлы правил агент скопировал побайтово, а `SKILL.md` аудита и чек-лист аудита изложил по памяти, и расхождение в 109 строк обнаружилось только через полгода, вручную запущенным аудитом.

## What Changes

- Дать каждому чек-листу payload адрес в `template/base/AGENTS.md` — по одной ссылке в том разделе, где чек-лист применяется, без переноса его содержания в правила.
- Дать адрес `.project-workframe-version` и самому апгрейду: короткий раздел `Workframe Payload` в `template/base/AGENTS.md` о том, что маркер записывает, и о том, что канонические файлы при апгрейде копируются, а не излагаются своими словами.
- Внести в `template/base/docs/checklists/feature-change.md` два шага, которые правила уже требуют, а чек-лист не называл: проверку `docs/DEBT.md` перед proposal и reconcile перед завершением.
- Расширить `scripts/check-workframe-update.sh`: обход всего `template/base` и установленных modules с состоянием `equal` / `differs` / `missing` для каждого файла, отдельная секция project-local файлов, которые расходиться обязаны, и фактический уровень содержимого проекта, вычисленный сравнением с шаблонами выпущенных версий, а не взятый из маркера.
- Сделать побайтовое равенство канонических файлов условием завершения апгрейда: пункт в `template/base/docs/checklists/release-readiness.md`, строка в срезе 5 `template/base/docs/checklists/coherence-audit.md` и запрет пересказа в `docs/UPGRADING.md` → `What Not To Do`.
- Выпустить обратно совместимую возможность как `0.4.0`.

## Capabilities

### New Capabilities

- `payload-addressing`: файл, приезжающий в проект, обязан иметь адрес в правилах этого проекта; указатель ссылается на файл, а не пересказывает его; чек-лист называет шаги правила, которое обслуживает.

### Modified Capabilities

- `project-upgrade-check`: проверка сравнивает установленный payload с шаблоном пофайлово, отделяет канонические файлы от project-local, выводит фактический уровень содержимого и перестаёт полагаться на маркер; побайтовое равенство канонических файлов становится условием завершения апгрейда и повторяется срезом аудита.

## Impact

Затронуты generated project payload (`template/base/AGENTS.md`, три чек-листа), `scripts/check-workframe-update.sh`, root `docs/UPGRADING.md`, `README.md`, `README.ru.md`, `VERSION` и `CHANGELOG.md`. Модуль `frontend-quality` получает адрес через условную ссылку в базовых правилах, состав его payload не меняется. Существующие проекты не изменяются: они увидят новое поведение только при собственном upgrade change. `/Users/andrey/sites/tendril` и `/Users/andrey/sites/leksus/cashback_bro` проверяются расширенной командой как read-only диагностика, без правок в этих проектах.
