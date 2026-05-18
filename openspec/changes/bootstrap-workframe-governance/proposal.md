## Why

Workframe уже содержит начальный reusable scaffold, README, init script и payload-модули, но сам репозиторий пока не отделяет собственные governance-файлы от файлов, которые копируются в новые проекты.

Нужно зафиксировать bootstrap-переход: первая версия была создана вручную, а дальнейшее развитие Workframe должно идти через те же правила, которые он предлагает другим проектам.

## What Changes

- В корне Workframe добавляется `AGENTS.md` для работы агентов над самим репозиторием.
- Добавляется `docs/CONCEPTS.md` как продуктовая конституция Workframe.
- Добавляется root `openspec/` для изменений Workframe, отдельно от `template/base/openspec/`, который остается payload для новых проектов.
- В корень добавляются локальные Codex OpenSpec skills, чтобы будущие сессии внутри Workframe могли использовать project-local `/opsx` workflow.
- Добавляется OpenSpec change `bootstrap-workframe-governance`, который фиксирует bootstrap exception и правила дальнейшего саморазвития.

## Capabilities

### New Capabilities

- `workframe-governance`: правила self-governance для Workframe как самостоятельного проекта и разграничение root governance vs generated project payload.

### Modified Capabilities

- Нет.

## Impact

- Затрагиваются root governance файлы Workframe: `AGENTS.md`, `docs/CONCEPTS.md`, `openspec/`, `.codex/skills/`.
- `template/base/` и `template/modules/` не меняются в этом change, кроме того что root governance теперь явно описывает их роль.
- GitHub remote и опубликованная история не переписываются.
- Решение согласуется с целями Workframe: workflow остается inspectable, provider-neutral на уровне концепции и vendor-specific только в adapter/module слоях.
