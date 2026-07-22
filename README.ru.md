# Workframe

Переиспользуемый рабочий каркас для проектов с AI-ассистированной разработкой.

English version: [README.md](README.md).

Workframe не является фреймворком приложения. Это операционный каркас проекта: концепты, правила для агентов, OpenSpec workflow, дизайн-дисциплина и политика обновлений, которые можно перенести в новый software-проект и адаптировать под его домен.

## Для Чего Это

Используй Workframe, когда заводишь новый проект или приводишь существующий проект к понятному процессу работы с AI-агентами.

Каркас рассчитан на разные типы проектов: Telegram-боты, Django-приложения, scraping-сервисы, frontend-приложения, библиотеки, инфраструктурные утилиты и похожие software-проекты.

## Структура Репозитория

```text
workframe/
├─ AGENTS.md
├─ README.md
├─ README.ru.md
├─ CHANGELOG.md
├─ openspec/                 # OpenSpec самого Workframe
├─ .codex/                   # локальные skills для работы над Workframe
├─ docs/
│  ├─ CONCEPTS.md            # продуктовая конституция Workframe
│  └─ UPGRADING.md
├─ template/
│  ├─ base/                  # файлы, которые копируются почти в каждый проект
│  └─ modules/               # опциональные payload-модули
├─ source/
│  ├─ canonical-rules/       # нейтральные правила-источник
│  ├─ adapters/              # адаптеры под AI-клиентов
│  └─ profiles/              # заметки для типов проектов
└─ examples/                 # примеры; по умолчанию не копируются
```

`template/` — это payload, который попадает в новый проект. Остальные директории объясняют, адаптируют или демонстрируют этот payload.

Root `AGENTS.md`, `docs/CONCEPTS.md`, `openspec/` и `.codex/` управляют самим Workframe. Файлы внутри `template/` — это payload для создаваемых проектов.

## Быстрый Старт

1. Создай новый проектный репозиторий.
2. Примени базовый каркас и нужные модули.
3. Заполни `docs/CONCEPTS.md` под реальный продукт.
4. Закоммить начальную workflow-обвязку.
5. Первое настоящее продуктовое изменение начинай через OpenSpec; если оно определяет стек, выведи и реализуй начальный quality pipeline в том же change.

Пример:

```bash
/path/to/workframe/scripts/init-project.sh \
  --target /path/to/new-project \
  --with codex-skills \
  --with design-pencil
```

Можно копировать файлы вручную, если хочется более медленного, но полностью видимого процесса.

## Что Копировать

В большинство новых проектов копируются:

- `template/base/AGENTS.md`
- `template/base/docs/CONCEPTS.md`
- `template/base/docs/AGENT_WORKFLOW.md`
- `template/base/docs/QUALITY.md`
- `template/base/docs/checklists/`
- `template/base/openspec/config.yaml`
- `template/base/.project-workframe-version`

Опциональные модули копируются только когда подходят:

- `template/modules/codex-skills/` для локальных Codex skills.
- `template/modules/design-pencil/` для проектов с дизайн-артефактами, Pencil или taste references.
- `template/modules/frontend-quality/` для frontend-heavy проектов.

При ручном копировании бери payload внутри модуля, а не служебный README самого модуля:

- `template/modules/codex-skills/.codex/`
- `template/modules/design-pencil/.codex/`
- `template/modules/frontend-quality/docs/`

По умолчанию не копируй в новый проект:

- `source/`
- `examples/`
- `CHANGELOG.md` самого Workframe.

## Главные Правила

- `docs/CONCEPTS.md` является конституцией проекта, когда файл существует.
- Нетривиальные изменения поведения, интеграции и рефакторинги проходят через OpenSpec.
- OpenSpec artifacts пишутся по-русски по умолчанию.
- Technical identifiers, commands, filenames, branch names, API names и code symbols остаются на английском там, где это уместно.
- Один OpenSpec change соответствует одной git branch.
- Change, который вводит или существенно меняет исполняемую технологическую поверхность, также обновляет project-specific quality pipeline и `docs/QUALITY.md`.
- Существующие пользовательские изменения не откатываются без явной просьбы.
- Design workflow включен по умолчанию; Pencil MCP опционален и считается выключенным, пока runtime явно его не предоставляет.

## Quality-Слой

Workframe поставляет текстовый verification contract, а не готовый набор инструментов. Когда стек становится понятен, тот же OpenSpec change выводит проверки из surfaces и рисков проекта, выбирает подходящие tools, реализует их конфигурацию и automation в целевом репозитории и фиксирует текущие команды в `docs/QUALITY.md`.

Проверки объявляются как `blocking`, `advisory` или `not applicable`. Это позволяет начать с минимального pipeline, постепенно подключать legacy, разделять monorepo по surfaces и использовать эвристические анализаторы, не делая Ruff, mypy, ESLint, Semgrep, Archscope или конкретный CI provider частью Workframe.

## Обновление Существующих Проектов

Workframe не обновляет автоматически проекты, созданные из старых версий. Старые проекты должны оставаться стабильными.

Чтобы обновить существующий проект, создай обычный OpenSpec change внутри этого проекта, сравни его `.project-workframe-version` с текущим Workframe, примени нужные workflow-изменения и закоммить результат в истории этого проекта.

Подробный guide: [docs/UPGRADING.md](docs/UPGRADING.md).

## Маркер Версии

Каждый сгенерированный проект должен хранить:

```text
.project-workframe-version
```

Этот файл фиксирует, какая версия Workframe была применена. Он намеренно простой, чтобы будущие обновления можно было ревьюить вручную.

## Дизайн-Слой

Workframe включает дизайн-дисциплину по умолчанию, но не требует, чтобы Pencil MCP был доступен в каждой сессии.

Если Pencil MCP недоступен, агенты не должны редактировать `.pen` файлы. Они могут работать по экспортированным screenshots, задокументированным дизайн-решениям или попросить пользователя включить Pencil MCP в новой сессии.

## Статус

Это начальная выжимка из реального workflow. Первый приоритет — ясность, а не автоматизация. Включенный init script намеренно маленький: он копирует base payload и выбранные модули, а проектные решения оставляет владельцу.
