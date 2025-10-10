🧭 1️⃣ Тест хэсгийн UX-ийн зорилго
🎯 Зорилго:
Сурагч өөрийн сонирхол, чадвар, зан төлөвийг хурдан, урамтайгаар тодорхойлох.
 “Тест өгөх” → “үр дүн харах” → “дараагийн алхам руу (мэргэжил, сургууль, зөвлөгөө)” логик урсгалыг бүрдүүлэх.

🧩 2️⃣ Тестийн шатлал (User Journey)
Алхам
UX зорилго
UI элемент
1️⃣ Test Intro Screen
Тестийн утга, хугацааг ойлгуулах
Title: “30 асуултад хариулаад өөрт тохирох мэргэжлээ мэд!” ⏱ “5–7 минут” CTA [Тест эхлэх]
2️⃣ Question Screens (1–30)
Хэрэглэгчийг анхаарлыг алдалгүй бөглүүлэх
Question text, 1–5 Likert scale (emoji эсвэл bubble), Progress bar, Sticky CTA [Дараагийн асуулт]
3️⃣ Mid-point Encouragement (after Q15)
Урамшуулж үргэлжлүүлэх
Popup “👏 Та талд нь ирлээ! Үргэлжлүүлээд үзье.”
4️⃣ Test Completion Screen
Тест дууссан мэдрэмж өгөх
Animation (confetti/checkmark), “Таны үр дүн бэлэн боллоо!” [Үр дүнг харах]
5️⃣ Result Summary Screen
RIASEC код, гол шинж чанар
“SEC — Social, Enterprising, Conventional”, тайлбар, Fit chip-үүд, CTA [Мэргэжил харах] [Сургуулиуд үзэх] [Зөвлөгөө авах]


🎨 3️⃣ UX Behavior Logic
Нөхцөл
Хэрэглэгчийн туршлага
Guest (нэвтрээгүй)
10 дахь асуултад хүрэхэд “Үр дүн хадгалахын тулд нэвтрэх үү?” popup гарна.
Logged-in
Тест бүхэлд нь бөглөж, үр дүн Firebase/User DB-д хадгалагдана.
Premium test (Career Deep-fit гэх мэт)
Lock state — “Premium хэрэглэгч нээх боломжтой.”
Test дахин өгөх
“Өмнөх тестийн дүнг шинэчлэх үү?” dialog.
Тест дунд гарах
Progress auto-save → дараа үргэлжлүүлж болно.


🧱 4️⃣ Тест дэлгэцийн UI layout (Question Screen wireframe)
AppBar:   ←  Асуулт 7 / 30      ⏱  02:15
─────────────────────────────
Question Text:
"Би хүмүүст тусалж, зааж зөвлөх дуртай."

Likert scale (horizontal):
😐 1   🙂 2   😊 3   😃 4   🤩 5

Progress bar (50%)
─────────────────────────────
Bottom Sticky CTA:
[Буцах]        [Дараагийн асуулт]
─────────────────────────────


🧠 5️⃣ Дизайн ба туршлага
Элемент
UX санаа
Micro animation
Progress bar дүүрэхэд subtle glow animation
Emoji scale
Оюутнуудад ойлгомжтой, хөгжилтэй байдлаар Likert scale илэрхийлэх
Short question cards
1 асуулт = 1 дэлгэц, cognitive load багасгана
Dark mode support
Шөнө тест өгөхөд тохиромжтой
Reward moment
100% дуусахад confetti animation + motivational quote


🔐 6️⃣ Data & Technical logic
Local save every 5 questions (test_progress.json)


API endpoints:


GET /tests/:id → асуултууд


POST /responses → хэрэглэгчийн хариулт


POST /results → RIASEC код, fit matrix


Result merge → Occupation table (occupation.riasec_tags) → Recommendation



📊 7️⃣ KPI (UX success metrics)
Metric
Зорилтот утга
Test start → finish completion rate
≥ 70%
Avg completion time
≤ 6 мин
Result click-through (→ Occupation)
≥ 60%
Login conversion (mid-test)
≥ 50%
Drop-off rate
≤ 20%


✅ 8️⃣ Definition of Done (MVP)
✅ Test intro, 30 асуултын flow бүрэн ажиллана
 ✅ Progress bar ба Likert UI бүрэн ажиллана
 ✅ Result page (RIASEC code + 3 CTA)
 ✅ Auto-save, resume function
 ✅ Analytics tracking: test_started, test_completed, result_viewed

