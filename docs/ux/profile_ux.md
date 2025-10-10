🧭 1️⃣ Profile хэсгийн зорилго
🎯 Зорилго:
Хэрэглэгч өөрийн мэдээлэл, хадгалсан сургуулиуд, мэргэжлийн тестийн дүн, зөвлөгөөний товлолуудыг нэг дор удирдах.
💡 UX санаа:
 “Нэг цонх — бүх зүйл”: хэрэглэгч login хийсний дараа өөрийн бүх үйл ажиллагааг хянах, засах, хадгалах боломжтой.

🧩 2️⃣ Хэрэглэгчийн урсгал
Алхам
UX зорилго
Үндсэн UI элемент
1️⃣ Profile Overview
Хэрэглэгчийн үндсэн мэдээлэл харах
Нэр, зураг, email, гишүүнчлэлийн түвшин
2️⃣ Saved Items
Хадгалсан сургуулиуд, мэргэжлүүд, нийтлэлүүд
Card list, delete/edit товч
3️⃣ Test Results
Тестийн үр дүнг дахин харах
RIASEC code, топ мэргэжил, дахин тест өгөх CTA
4️⃣ Booking & Consultations
Зөвлөгөөний түүх, ирэх уулзалтууд
Schedule list + “Start chat” товч
5️⃣ Subscription & Payments
Premium төлбөр, гишүүнчлэлийн төлөв
Status badge + “Renew” / “Upgrade” CTA
6️⃣ Settings & Logout
Хэл, мэдэгдэл, logout
Toggle switches + logout confirmation


🧱 3️⃣ Profile Overview – Wireframe бүтэц
AppBar:  ←  Профайл
──────────────────────────────
👤 Хэрэглэгчийн зураг (circle avatar)
Нэр: Номин-Эрдэнэ  
Имэйл: nomin@example.com  
Гишүүнчлэл: Premium 🟢
[Профайл засах] товч
──────────────────────────────
Хэсгийн жагсаалт:
📚 Хадгалсан сургуулиуд (5)
🎓 Тестийн дүн (RIASEC – SEC)
💬 Зөвлөгөөний түүх (2)
💳 Гишүүнчлэл ба төлбөр
⚙️ Тохиргоо
──────────────────────────────
Logout → “Гарах”


🟦 4️⃣ Saved Items Screen
Хэсэг
Тайлбар
Сургуулиуд
Card list (logo + нэр + 💰 төлбөр + 📍байршил) + [Харах] [Устгах]
Мэргэжил / Нийтлэлүүд
Card design адил — хураангуй текст, CTA [Нээх]
Empty state: “Та одоогоор хадгалсан зүйлгүй байна 😊 — эхлэл рүү орж хайгаарай.”




🟩 5️⃣ Test Results Screen
Header: “Таны тестийн үр дүн”


RIASEC код: “SEC” (Social – Enterprising – Conventional)


Гол шинжүүд: 🧠 Хүмүүстэй ажиллах • 💼 Манлайлах • 📊 Журамтай


Top 3 мэргэжил: card list


CTA: [Дахин тест өгөх] [Мэргэжлүүд үзэх]



🟠 6️⃣ Consultations & History
Хэсэг
Тайлбар
Ирэх уулзалтууд
Advisor name + date/time + CTA [Чат эхлүүлэх]
Өнгөрсөн зөвлөгөө
Rating + “Дахин зөвлөгөө авах” товч
Empty state: “Танд товлосон уулзалт байхгүй.”




🟣 7️⃣ Subscription & Payments
💎 Таны гишүүнчлэл: Premium
Хугацаа: 2025.12.01 хүртэл
QPay → автоматаар сунгах идэвхтэй ✅
──────────────────────────────
[Гишүүнчлэлээ шинэчлэх]
[Premium контентуудыг үзэх]


🧠 8️⃣ Settings Screen
Тохиргоо
Сонголт
Аппын хэл
Монгол / English
Push мэдэгдэл
ON/OFF toggle
Dark mode
ON/OFF
Тусламж
FAQ / Support линк
Logout
“Та гарахдаа итгэлтэй байна уу?” confirm popup


🎨 9️⃣ Дизайн зарчим
Элемент
Тайлбар
Profile avatar:
96px circle, edit icon overlay
Color tone:
Violet gradient (#6F63F7 → #9D5CFF)
Card corner:
Rounded 12px
Section icons:
Material icons (outlined)
CTA style:
Full width buttons, primary color
Empty states:
Soft илтгэх иллюстраци + тайлбар текст


📊 10️⃣ KPI (UX үзүүлэлт)
Хэмжүүр
Зорилтот утга
Profile → Edit click rate
≥ 25%
Test result revisit rate
≥ 40%
Consultation repeat rate
≥ 30%
Subscription renewal
≥ 50%
Logout accidental click
≤ 3%


✅ Definition of Done (MVP)
✅ Profile overview + edit option
 ✅ Saved items list
 ✅ Test result reconnect + CTA
 ✅ Consultation list + history
 ✅ Subscription section + QPay renewal
 ✅ Settings + logout confirmation
 ✅ Firebase events: profile_opened, saved_item_clicked, test_result_viewed, logout_clicked

