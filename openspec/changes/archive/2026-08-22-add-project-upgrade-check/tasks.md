## 1. Контракт выпуска и marker

- [x] 1.1 Выпустить `0.3.0` в `VERSION` и `CHANGELOG.md`, дополнить root release governance Git-тегами и исправить placeholder Purpose в основной SemVer-spec. Результат: каждый релиз имеет версию, changelog и планируемый тег. Проверка: валидный SemVer, `v0.2.0` указывает на release commit, OpenSpec validation.
- [x] 1.2 Расширить template marker и init так, чтобы `modules` отражали `agent-skills` и выбранные optional modules. Результат: новый project marker воспроизводимо описывает состав Workframe. Проверка: smoke init с двумя modules и точное содержимое marker.

## 2. Read-only проверка и документация

- [x] 2.1 Реализовать `scripts/check-workframe-update.sh --target`, который читает marker, выводит versions, modules, release notes и состояния review-файлов, не изменяя target. Результат: агент получает фактический upgrade brief. Проверка: smoke проверки для marker с modules и legacy marker без них, hash target до/после совпадает.
- [x] 2.2 Обновить README и `docs/UPGRADING.md` стандартной командой и коротким prompt для агента. Результат: владелец запускает проверку и поручает review без неявного источника. Проверка: команды, пути и правила согласованы со скриптом.

## 3. Верификация и выпуск

- [ ] 3.1 Выполнить Bash syntax checks, smoke scenarios, strict OpenSpec validation и reconcile затронутых файлов. После commit создать аннотированный `v0.3.0`. Результат: проверки проходят, release можно архивировать. Проверка: `git tag -v` или `git cat-file -t v0.3.0` возвращает annotated tag.
