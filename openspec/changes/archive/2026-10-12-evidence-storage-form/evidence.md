# Evidence — evidence-storage-form

Уровень: `behavior`. Меняется текстовый workflow и проверочный скрипт; защитных границ и certification artifact нет. Проверяется согласованность инструкций, а не фактическое поведение модели. Ревизия: незакоммиченное рабочее дерево поверх `0e9fe2e` на ветке `feature/evidence-storage-form`; release commit, tag и archive не выполнялись, поэтому evidence не привязан к финальному commit. Сырых выводов нет: все итоги ниже, каталог сырых выводов в Workframe не заводился.

## Задачи 1.1 и 1.2 — сценарии delta

Путь root: `source/canonical-rules/verification.md`, раздел `Evidence Form` (+ ссылка из раздела Proportional Evidence Levels) и `coherence.md`, Two Levels. Путь payload: `AGENTS.md` (без изменений, уже маршрутизирует) → `docs/AGENT_WORKFLOW.md`, `Contract-Driven Verification / Evidence Form` и `Level One: Reconcile` → `feature-change.md` (Verification) и `release-readiness.md` → шаблон `docs/QUALITY.md`, `Evidence Form`.

| Сценарий / требование | Адрес правила | Наблюдаемый результат | Итог |
| --- | --- | --- | --- |
| Тип данных, не размер | verification.md и AGENT_WORKFLOW.md / Evidence Form, таблица | Шесть строк таблицы из задачи, фраза «by the kind of data, not by file size» | passed |
| Успешный полный gate | та же таблица; feature-change / Verification; пример успеха | Команда, ревизия, счётчики, exit code, длительность — в VCS; пословный вывод — вне VCS | passed |
| Отсутствие ошибки ≠ успех | Evidence Form, абзац о положительной записи; feature-change | «not an observation of success», «not recorded as `passed`» | passed |
| Первый провал при зелёном повторе | Evidence Form, строка Failures и итоговый абзац; пример провала | Выдержка в VCS, полный лог по хэшу; правило Flaky не изменено | passed |
| Проба снятия защиты | Evidence Form, итоговый абзац; Protective Boundaries не изменены | Итог пробы записывается в сводке; сырой вывод — дамп пробы, вне VCS | passed |
| Certification evidence | Evidence Form, строка Release/certification и абзац о хранении; Execution And Certification не изменён | Минимальный объём для verifier в VCS, при reconcile не удаляется | passed |
| Сырые выводы перед archive | coherence.md / Two Levels; AGENT_WORKFLOW / Level One; release-readiness | Удаление сырых выводов change — шаг reconcile; в VCS только сводки | passed |
| Тулинг уровня behavior | Evidence Form, итоговый абзац | «было/стало + зелёный полный gate» достаточно; ревью, пробы, привязка — для границ и certification | passed |
| Генератор, формат, каталог в QUALITY.md | Evidence Form; шаблон QUALITY.md / Evidence Form | Три pending-пункта; Workframe ничего не предписывает | passed |
| Данные продукта и тестов вне правила | строка таблицы | «not evidence logs; this rule does not apply» | passed |
| Примеры сводок успеха и провала | AGENT_WORKFLOW.md / Evidence Form | Два блока `text`; в canonical source — встроенный пример успеха | passed |
| AGENTS.md и skills без изменений | `git diff main -- template/base/AGENTS.md template/modules` | пустой diff | passed |

Сверка на противоречия: правило observation («not reasoning about control flow») усилено, не ослаблено; правило первого провала сохраняет запись в VCS; «show … failing with its guard removed, and record that it did» выполняется записью в сводке; independent verifier по-прежнему открывает artifact из VCS. Итог: passed.

## Задача 1.3 — проба формы свидетельств

- `scripts/verify-contract-driven-workflow.sh --probe-evidence-form` на версиях `AGENT_WORKFLOW.md` и `verification.md` из `main`: exit 1, `Missing contract phrase … by the kind of data, not by file size` — проба не вакуумна. Итог: passed (ожидаемый отказ).
- `--self-test`: три новые мутации (по одной на каждую фразу) отвергнуты, `Negative method fixtures rejected.`, exit 0. Итог: passed.
- Свежая установка через `init-project.sh` несёт правило: проба на `fresh/docs/AGENT_WORKFLOW.md` в основном прогоне. Итог: passed.

## Задача 2.1 — выпуск

`VERSION` = 0.8.0 (MINOR: совместимая новая возможность payload). `CHANGELOG.md` — раздел `0.8.0 - 2026-10-12`. `docs/UPGRADING.md` — `Adopting The Evidence Form` и пункт в `When To Upgrade`. README на двух языках — по абзацу. `git diff main --stat -- openspec/changes/archive docs/CONCEPTS.md` пуст. Итог: passed.

## Задача 2.2 — gate

Первый прогон: три команды вернули exit 127 — дефект вызова в цикле (zsh не разбил строку команды на слова), сами проверки не запускались. Повтор с `eval`, затем финальный прогон после последней правки:

```text
openspec validate evidence-storage-form --strict | Change is valid | exit 0
scripts/verify-agent-adapters.sh | Agent adapters verified | exit 0
scripts/verify-contract-driven-workflow.sh | Contract-driven workflow verified | exit 0
scripts/verify-contract-driven-workflow.sh --self-test | address + method fixtures rejected | exit 0
scripts/verify-instruction-budget.sh | verified; root AGENTS 6530/10000, payload AGENTS 6075/10000 bytes | exit 0
git diff --check | no whitespace errors | exit 0
```

Проверки подтверждают структуру, маршрутизацию, установку и наличие ключевых фраз; смысл правила проверен матрицей выше.

## Задача 2.3 — финальное review и reconcile

Повторное перечитывание proposal/design/spec/tasks, итогового diff и evidence текущим агентом (для уровня behavior отдельный контекст не требуется). Найдены и исправлены две mechanical-неточности: строка Failures читалась как «выдержка … полностью» (заменено на «every failure»); пример провала ссылался на несуществующую «next entry». Порядок абзацев в `QUALITY.md` восстановлен после вставки. Новых payload-файлов нет, placeholder добавлены только намеренные `pending` в шаблон `QUALITY.md`, как и в соседних секциях. Semantic/structural находок и регрессий нет. Итог: можно предлагать archive после release commit.
