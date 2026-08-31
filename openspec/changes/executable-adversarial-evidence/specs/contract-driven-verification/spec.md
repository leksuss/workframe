## MODIFIED Requirements

### Requirement: Adversarial verification защитных границ
Workframe MUST требовать risk-based negative/adversarial verification, когда change затрагивает credentials/secrets/redaction; authentication/authorization/permissions/allow-lists; network/external adapters; timeouts/cancellation/budgets/resource limits; streaming/bounded payloads; persistent storage/atomic writes/rollback; idempotency/CAS/leases/restart; public API/server/embedding defaults; certified evidence/manifests/digests/revision binding; либо irreversible/externally visible side effects.

Когда решение принимается по данным, которых код не контролирует, Workframe MUST требовать перечисления каждого поля этих данных, которое решение читает, и одного враждебного случая на поле. Список MUST храниться в change artifacts, и полнота adversarial-покрытия MUST оцениваться против него, а не против авторского суждения о применимости.

Для защитной границы Workframe MUST требовать демонстрации того, что каждый adversarial-тест падает при снятом предохранителе, и записи этого факта.

#### Scenario: UI скрывает обход server API
- **WHEN** UI запрещает действие, но прямой API path может выполнить его
- **THEN** adversarial review проверяет facade и direct server path
- **AND** change не проходит, если `POST` или эквивалентный bypass разрешён

#### Scenario: Выбор adversarial scenarios по риску
- **WHEN** change затрагивает одну защитную границу
- **THEN** design выбирает применимые сценарии из missing/extra fields, headers/permissions/allow-list, body without length, stalled dependency, retry/collision, stale/tampered artifact, optimistic default, partial write/rollback и alternative ownership paths
- **AND** не требует выполнения неприменимого универсального списка

#### Scenario: Перечисление доверяемых полей
- **WHEN** решение читает `thresholds`, состав корпуса результатов и признак включённого tier из артефакта, который сам же проверяется
- **THEN** change artifacts содержат список этих полей и по одному враждебному случаю на каждое
- **AND** adversarial-покрытие считается неполным, пока какое-либо перечисленное поле не имеет своего случая

#### Scenario: Вакуумный adversarial-тест
- **WHEN** adversarial-тест защитной границы проходит и при снятом предохранителе
- **THEN** тест не считается доказательством границы
- **AND** запись о прогоне со снятым предохранителем является обязательной частью evidence

#### Scenario: Bounded response проверяется после загрузки
- **WHEN** implementation проверяет размер только после полной materialization body
- **THEN** resource-boundary review классифицирует operation как unbounded
- **AND** positive test полного ответа не закрывает negative bounded-payload requirement

#### Scenario: Allow-list обойдён
- **WHEN** permissions присутствуют, но обязательная capability отсутствует в allow-list
- **THEN** negative verification проверяет именно allow-list denial path
- **AND** наличие permissions само по себе не считается доказательством authorization contract

#### Scenario: Dependency зависает до readiness
- **WHEN** external или browser/runtime dependency не отвечает до открытия service port
- **THEN** timeout/cancellation verification доказывает bounded fail-closed outcome
- **AND** happy-path startup test недостаточен

### Requirement: Task completion основан на контракте результата
Workframe MUST запрещать отмечать неатомарную задачу выполненной, пока её ожидаемый наблюдаемый результат, production surface или ownership path, существенные ограничения и verification method не определены и последний фактически не выполнен. Исключение MUST быть явно принято owner и записано с `skipped` или `unavailable` result.

Утверждение о том, что нечто никогда не происходит, MUST подтверждаться наблюдением — счётчиком, пробой или зафиксированным отсутствием в артефакте — и MUST NOT приниматься на основании рассуждения о потоке управления.

#### Scenario: Общий suite зелёный, нужного scenario нет
- **WHEN** общий test suite проходит, но заявленный task verification scenario в нём отсутствует
- **THEN** suite не считается доказательством этой задачи
- **AND** checkbox остаётся незакрытым до выполнения method или owner exception

#### Scenario: Mock не достигает production ownership path
- **WHEN** задача требует loopback integration path, а test выполняет только mock fetch
- **THEN** traceability выявляет отсутствие evidence для требуемого path
- **AND** задача не считается выполненной

#### Scenario: Test подтверждает другой outcome
- **WHEN** spec требует два успешных append-only observation, а test ожидает `EEXIST`
- **THEN** reviewer сопоставляет exact expected outcome с assertion и обнаруживает расхождение
- **AND** failed requirement не сертифицируется зелёным test result

#### Scenario: Утверждение об отсутствии двойной отправки
- **WHEN** задача утверждает, что действие не отправляется дважды, и опирается на чтение потока управления
- **THEN** утверждение не принимается без счётчика, пробы или зафиксированного отсутствия в артефакте
- **AND** задача остаётся незакрытой до появления наблюдения

### Requirement: Независимый финальный adversarial review
Перед предложением archive Workframe MUST требовать новый review-pass proposal, design, specs, tasks, final diff и verification results без доверия уже выставленным checkbox. Для high-risk changes review MUST выполняться другой моделью/агентом либо эквивалентным отдельным review context.

Design claim о том, что библиотека, рантайм или платформа гарантируют некоторое поведение, MUST ссылаться на выполненную пробу, когда на этом claim держится решение о безопасности. Рассуждение о задокументированном поведении MUST NOT приниматься как evidence.

Для уровня `release/certification` перечитывание диффа MUST NOT засчитываться как adversarial pass: независимый контекст MUST исполнять код — строить враждебные входы, запускать их и записывать вывод, — а запись MUST называть, что именно было запущено.

#### Scenario: Final review обнаруживает неподтверждённое утверждение
- **WHEN** checkbox выставлен, но final diff или evidence не доказывает task claim
- **THEN** reviewer возвращает задачу в non-complete state
- **AND** не принимает checkbox как доказательство

#### Scenario: Review находит semantic или structural mismatch
- **WHEN** final pass находит spec/code divergence или structural finding
- **THEN** finding записывается по coherence policy и не разрешается молча
- **AND** mechanical finding исправляется до archive proposal

#### Scenario: Гарантия рантайма принята рассуждением
- **WHEN** обоснование безопасности опирается на утверждение, что рантайм гарантирует определённый порядок или отсутствие эффекта
- **THEN** review блокирует принятие claim до выполненной пробы
- **AND** проба применяется и к предложенному исправлению, а не только к исходной реализации

#### Scenario: Независимый контекст только перечитал дифф
- **WHEN** change уровня `release/certification` записывает финальный review, состоявший из перечитывания диффа
- **THEN** review не считается adversarial pass
- **AND** archive блокируется до прогона враждебных входов с записью того, что было запущено

### Requirement: Archive readiness закрывается доказательствами
Workframe MUST запрещать объявлять change готовым к archive при task без verification result; blocking `skipped`/`unavailable` без owner decision; незарегистрированном spec/code mismatch; boundary без negative tests; stale revision evidence; неперепроверяемом certification artifact; непренесённом depth backlog; либо скрытом residual risk.

Для уровня `release/certification` archive MUST также блокироваться, когда финальный независимый контекст не исполнял код и запись не называет запущенное.

#### Scenario: Evidence соответствует предыдущему commit
- **WHEN** final evidence записан для revision, отличной от текущей tracked revision
- **THEN** evidence получает stale/non-passing status
- **AND** blocking gate повторяется на final revision до archive readiness

#### Scenario: После evidence появился tracked commit
- **WHEN** после final evidence создаётся новый tracked commit
- **THEN** прежний evidence перестаёт считаться final
- **AND** change не объявляется ready на его основании
