🧭 1️⃣ Universities хэсгийн зорилго
🎯 Зорилго:
Хэрэглэгчийг өөрт тохирох сургуулийг олж, дэлгэрэнгүй мэдээллийг харж, харьцуулах боломж олгох.
💡 UX-ийн үндсэн санаа:
 “Wikipedia + Booking.com” хосолсон бүтэц — баталгаатай мэдээлэл + хайлт/шүүлтүүр + compare system.

🧩 2️⃣ Хэрэглэгчийн үндсэн урсгал
Алхам
UX зорилго
UI элемент
1️⃣ Universities List
Бүх сургуулиудыг browsing хийх
Search bar, Filter chips, Grid/List cards
2️⃣ Filters & Sorting
Хэрэглэгчийн сонирхлоор шүүх
Байршил / Төрөл / Төлбөр / Элсэлтийн оноо / Чиглэл
3️⃣ University Detail Page
Сонгосон сургуулийн дэлгэрэнгүйг үзэх
Tab layout: Overview / Majors / Tuition / Campus / Admission
4️⃣ Program Compare View
Хоёр ба түүнээс дээш хөтөлбөрийг харьцуулах
Side-by-side matrix (duration, fee, entry score, fit%)
5️⃣ Apply or Save
Сонголтоо хадгалах эсвэл бүртгэх линк руу очих
CTA [Бүртгүүлэх] [Хадгалах] [Харьцуулах]


🧱 3️⃣ Universities List (Main screen) — Wireframe structure
AppBar:  ←  Их сургуулиуд      🔍  Filter (icon)
──────────────────────────────
Search bar: “Сургуулийн нэр эсвэл чиглэл”
──────────────────────────────
Filter chips:
[УБ] [Хувийн] [≤5 сая₮] [IT чиглэл] [>600 оноо]
──────────────────────────────
Scrollable list (Card design):
[Лого]  Монгол Улсын Их Сургууль (МУИС)
📍 Улаанбаатар • 💰 5,200,000₮ / жил
📈 Элсэлтийн босго: 650
🎓 Хөтөлбөр: 35
⭐ Verified badge
[→ Дэлгэрэнгүй]
──────────────────────────────
Bottom sticky bar:
[Харьцуулах 2]  [→ Харьцуулах]
──────────────────────────────


🟦 4️⃣ University Detail Page (tab layout)
Tab
Content
UI элемент
Overview
Ерөнхий мэдээлэл, байршил, төрөл
Лого, үүсгэн байгуулагдсан он, төлбөрийн муж, verified badge
Majors & Programs
Хөтөлбөрийн жагсаалт
Filter by category, duration, entry score, tuition
Tuition & Scholarships
Санхүүгийн мэдээлэл
Fee breakdown, QPay integration (төлбөрийн тооцоолуур)
Campus Life
Дотуур байр, клуб, зураг
Carousel (байрны зураг, клубууд)
Admission
Элсэлтийн хугацаа, шаардлага
Countdown widget “Бүртгэл дуусахад: 14 хоног үлдлээ”
Actions
CTA sticky bar
[Харьцуулах] [Хадгалах] [Бүртгүүлэх]


🧠 5️⃣ UX Behavior Logic
Нөхцөл
UX шийдэл
Guest
Хадгалах / Харьцуулах дарвал → “Нэвтэрч хадгалах уу?” popup
Logged-in
Compare cart идэвхтэй
Verified universities
Хөх “Verified” badge, update timestamp
Offline mode
Сүүлд үзсэн 3 сургууль офлайн харагдана
Filter → No results
“Таны нөхцөлд тохирох сургууль олдсонгүй 😕 — Шүүлтүүрээ зөөллөөрэй”


🎨 6️⃣ Visual & Design Notes
Элемент
UX санаа
Card design:
Rounded 12px, school logo, concise info
Color coding:
Төрийн = хөх, Хувийн = улбар шар
Quick actions:
“💾 Хадгалах”, “📊 Харьцуулах”, “📝 Бүртгүүлэх” shortcut bar
Infographic style:
Tuition, Entry score, Programs count → icons + numbers
Micro animations:
Scroll-in fade, verified checkmark pulse


📊 7️⃣ KPI (success metrics)
Metric
Target
List → Detail CTR
≥ 40%
Compare click rate
≥ 25%
Apply link click rate
≥ 10%
Average session time
≥ 40s
Saved/bookmarked universities
≥ 30% of users


✅ 8️⃣ Definition of Done (MVP)
✅ Search, Filter, Sort бүрэн ажиллана
 ✅ Card view + Detail tab layout
 ✅ Compare (2–3 schools) боломжтой
 ✅ Apply deep-link ажиллана
 ✅ Firebase events: university_viewed, compare_used, apply_clicked

