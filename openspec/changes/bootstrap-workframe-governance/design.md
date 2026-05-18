## Context

Workframe одновременно является:

- самостоятельным проектом, который нужно развивать;
- шаблоном, который копирует payload в новые проекты;
- хранилищем optional modules, adapters, profiles и examples.

Без явного разделения легко случайно редактировать `template/base/AGENTS.md`, когда нужно изменить правила самого Workframe, или наоборот.

## Decision

Вводится разделение:

```text
AGENTS.md                     # правила работы над Workframe repo
docs/CONCEPTS.md              # конституция Workframe как продукта
openspec/                     # OpenSpec changes/specs самого Workframe
.codex/skills/                # локальные skills для работы над Workframe

template/base/                # payload для каждого нового проекта
template/modules/             # optional payload modules
source/                       # canonical notes, adapters, profiles
examples/                     # reference examples, not default payload
```

`bootstrap-workframe-governance` не пытается ретроактивно представить initial scaffold как заранее предложенный OpenSpec change. Он фиксирует реальность: первая версия была bootstrap, а последующие non-trivial изменения должны идти через Workframe root OpenSpec.

## Root vs Template Rules

- Изменения в root `AGENTS.md` влияют на работу над Workframe.
- Изменения в `template/base/AGENTS.md` влияют на новые проекты, созданные из Workframe.
- Изменения в root `openspec/` описывают развитие Workframe.
- Изменения в `template/base/openspec/` меняют payload OpenSpec для новых проектов.
- Root `.codex/skills/` нужен для текущего Workframe repo.
- `template/modules/codex-skills/.codex/skills/` остается копируемым модулем для target projects.

## Bootstrap Policy

Initial scaffold commit считается bootstrap exception. Его не нужно переписывать, пересоздавать или искусственно архивировать.

После завершения этого change действует обычное правило: non-trivial Workframe изменения проходят через root OpenSpec и matching `feature/<change-id>` branch.

## Upgrade Policy

Эта governance-структура не должна автоматически менять проекты, уже созданные из Workframe. Для них остается правило из `docs/UPGRADING.md`: upgrade является обычным change внутри target project.
