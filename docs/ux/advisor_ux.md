🧭 1️⃣ Advisor Section-ийн зорилго
🎯 Зорилго:
Сурагчийг өөрийн сонирхсон чиглэлд туршлагатай мэргэжилтэнтэй холбох — 1:1 чат эсвэл видео зөвлөгөө авах боломж олгох.
UX зарчим:
Итгэл төрүүлэх (verified badge, үнэлгээ, туршлага)


Шийдвэрийг хурдан гаргах (filter + booking CTA тод)


Хялбар харилцаа (chat UX ойлгомжтой)



🧩 2️⃣ Хэрэглэгчийн урсгал
Алхам
UX зорилго
UI элемент
1️⃣ Advisor List
Зөвлөхүүдийг browsing хийх
Search/filter, verified badge, price, rating
2️⃣ Advisor Profile
Мэргэжилтний дэлгэрэнгүй мэдээлэл
Name, title, experience, rating, “Book consultation” CTA
3️⃣ Booking Flow
Цаг сонгож зөвлөгөө хүсэх
Calendar picker, confirmation modal
4️⃣ Chat Session
1:1 зөвлөгөөний өрөө
Real-time chat (Firebase/WebSocket)
5️⃣ Feedback Screen
Сэтгэгдэл, үнэлгээ өгөх
Star rating, comment box, submit


🧱 3️⃣ Advisor List (Main screen) — Wireframe structure
AppBar:  ←  Мэргэжлийн зөвлөхүүд    🔍 Filter
─────────────────────────────
Search bar: “Салбар / чиглэл / нэрээр хайх”
─────────────────────────────
Filter chips:
[IT] [Санхүү] [Боловсрол] [Анагаах] [Premium]
─────────────────────────────
Scrollable list:
👤 Батзаяа  •  МУИС – IT багш
⭐ 4.8 (25 үнэлгээ)  •  💬 Chat / 🎥 Video  
💰 10,000₮ / session  •  ⏱ 20 минут  
🟢 Available today  
[→ Дэлгэрэнгүй]
─────────────────────────────
Sticky bottom bar:
[Сонгосон 1 зөвлөгөө]  [→ Цаг товлох]
─────────────────────────────


🟦 4️⃣ Advisor Profile (Detail)
Блок
Тайлбар
Header
Photo + Name + Title + Verified badge
Experience
“10 жил туршлагатай” + LinkedIn link
Expertise tags
#CareerPlanning #IT #ScholarshipAdvice
Languages
Монгол / English
Availability
Calendar preview (slot buttons)
Pricing
“Chat – 5,000₮ / Video – 10,000₮”
CTA sticky bar
[Chat товлох] [Video товлох]
Social proof
Rating ⭐ 4.8 / Reviews list (3 сэтгэгдэл)


🟩 5️⃣ Booking Flow (Popup / Screen)
Popup Title:  “Зөвлөгөө товлох”
──────────────────────────────
📅 Сонгох өдөр: 2025.10.12
🕐 Цаг: [16:00] [17:00] [18:00]
💬 Төрөл: (o) Chat   ( ) Video
💰 Үнэ: 10,000₮
──────────────────────────────
CTA: [Хүсэлт илгээх]
──────────────────────────────

System Response:
“🎉 Таны хүсэлт илгээгдлээ. Баталгаажуулах хүртэл хүлээнэ үү.”
→ Мэргэжилтэнд notification очно.

🧠 6️⃣ Consultation Chat (MVP)
Элемент
UX тайлбар
Header
Advisor name + Back button + Timer (“17:45 left”)
Chat bubbles
Text + File preview + Link cards
Input bar
Text field + “Send” + Attachment icon
State indicator
“Online”, “Typing…”
Post-chat
“Session ended” modal + “Rate this advisor”


🟠 7️⃣ Feedback Screen
🎯 Таны зөвлөгөө дууслаа.
Advisor: Батзаяа
⭐ ⭐ ⭐ ⭐ ☆
“Таны зөвлөгөө маш тус болсон!”
[Илгээх]

Data model: rating, comment, advisor_id


UX Behavior: rating → instant feedback + confetti animation


Next action CTA: [Өөр зөвлөх үзэх] / [Dashboard руу буцах]



🎨 8️⃣ Дизайн ба зан төлөв
Элемент
UX санаа
Color tone:
Ногоон / Цэнхэр (итгэл төрүүлэх)
Avatar size:
64–80px card дээр
Badge:
“Verified Expert” хөх цэнхэр тэмдэг
CTA buttons:
Rounded 12px, prominent
Calendar picker:
Soft blur modal
Feedback animation:
Light confetti, fade-in stars


📊 9️⃣ KPI (UX metrics)
Metric
Target
Advisor view → booking CTR
≥ 20%
Booking → completed session
≥ 70%
Feedback submitted
≥ 50%
Avg rating
≥ 4.5
Repeat consultation rate
≥ 30%


✅ 10️⃣ Definition of Done (MVP)
✅ Advisor list + filter + verified badge
 ✅ Profile detail + booking popup
 ✅ Chat (text only) real-time
 ✅ Feedback system
 ✅ Analytics: advisor_viewed, booking_created, session_completed, feedback_submitted

