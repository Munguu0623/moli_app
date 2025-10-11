# Git Commit Standard — Багийн гарын авлага (MN)

> **TL;DR**
> Баг бүхэлдээ **Conventional Commits**-ийг мөрдөж, богино тодорхой гарчиг, хэрэгтэй тайлбар, issue/PR холбоос, автоматаар шалгах `commitlint + husky` тохиргоотой байна. `feat/fix/docs/refactor/test/chore` гэх мэт төрөл ашиглаж, салбарын нэршил, PR дүрэм, changelog үүсгэх процессыг нэг мөр болгож мөрдөнө.

---

### 1 `type` — заавал

Дараах төрлүүдээр commit хийнэ:

* `feat`: Шинэ боломж
* `fix`: Алдаа засвар
* `docs`: Баримт/README, тайлбар
* `refactor`: Логик өөрчлөлт (шинэ боломж/алдаа засвар биш)
* `perf`: Гүйцэтгэл сайжруулалт
* `test`: Тест нэмэх/засах
* `build`: Build систем, багц хамаарал өөрчлөлт
* `ci`: CI скрипт/дээж өөрчлөлт
* `style`: Формат, цэг таслал, хоосон мөр (утга өөрчлөхгүй)
* `chore`: Өдөр тутмын үйлчилгээний өөрчлөлт (кодын утга өөрчлөхгүй)

---

## 2) Жишээ commit мессежүүд

```
feat(auth): social login нэмэв

Google ба Apple OAuth дэмжив. Existing session flow-т өөрчлөлт оруулсан.

```

```
fix(api): order total тооцоолол дахь rounding алдааг засав

Tax-inclusive тооцоонд float -> decimal руу шилжүүлэв.

```

```
refactor(db): repository давхардлыг арилгав

DAO давхаргыг нэгтгэж, shared transaction helper нэмж, rollback case-уудыг нэмлээ.
```

```
perf(image): thumbnail үүсгэх хугацааг 40% бууруулав

Batch resize + cached IO хэрэглэсэн.
```

```
docs(readme): local setup зааврыг шинэчлэв
```

```
feat(api)!: invoice model-д breaking өөрчлөлт

customerId талбарыг mandatory болгож, dueDate-г dateOnly болгосон.

BREAKING CHANGE: хуучин createInvoice(payload) дуудлага payload.customerId заавал.
```


---

## 3) Branch нэршил

* `type/scope-short-summary`
* Жишээ: `feat/auth-social-login`, `fix/api-order-rounding`, `docs/readme-setup`
* Урттасах бол `-` залгаж товч тайлбар нэмнэ

### 4 Үндсэн салбарууд

* `master`: үргэлж deploy-д бэлэн зөвхөн prod - руу гаргах үед бэлэн болсонг pull merge авна.
* `develop` (GitFlow): тогтмол интеграцийн салбар

### 4.1 Дэд салбарууд (GitHub Flow эсвэл Trunk-Based)

* Ажил бүр `master`/`develop`-оос салгаж, **богино настай** байлга

---

## 5) BREAKING CHANGE тэмдэглэх

* Гарчигт `!` эсвэл footer-д `BREAKING CHANGE:`
* Миграци/шилжилтийн зааврыг тодорхой бич

Жишээ:

```
feat(api)!: v2 list invoices endpoint

BREAKING CHANGE: /v1/invoices устсан. /v2/invoices хэрэглэ. Client SDK >= 2.0.0.
```

---

## 6) Хэлний бодлого

* Коммит **гарчиг**: аль нэг хэл дээр **тогтвортой** бай
* **Body** хэсэгт техникийн тайлбар англиар, баг дотоод хэрэглээ монголоор байж болно
* Issue/PR шаблон англиар (automation tooling-тэй нийцүүлэхэд амар)

---

## 7) Commit хэмжээ ба давтамж

* Жижиг, атомик commit; нэг зорилготой бай
* Хамааралгүй файлуудыг тусдаа commit/PR болго

---

## 8) Revert ба Cherry-pick

* Буруу орсон бол `revert: <original header>` хэлбэр ашигла

