🧭 I. UX стратегийн ерөнхий зарчим
Moli бол decision-support platform — хэрэглэгчийн зам нь “сонголт → итгэл → шийдвэр” гэсэн гурван үе шаттай.
 Бидний UX зорилго:
“Сурагчийг бодохгүйгээр дараагийн алхам руу хөтлөх UX зам гаргах.”

🚶‍♀️ II. Хэрэглэгчийн үндсэн урсгал (Funnel-based UX Map)
Этап
UX зорилго
Үндсэн UI/Interaction
1️⃣ Welcome & Onboarding
Хэрэглэгчийн итгэлийг бий болгох
Splash → Tutorial slides → “Яагаад Moli?”
2️⃣ Self-Assessment
Сонирхол + чадварыг илрүүлэх
RIASEC Test (progress bar + micro-reward)
3️⃣ Career Discovery
Тохирох мэргэжлийг ойлгуулах
Occupation cards + Fit% + Save CTA
4️⃣ Program Selection
Сонголтоо сургалтын түвшинд нарийсгах
Program list → Compare drawer
5️⃣ University Fit
Бодит сургуулийн мэдээллийг шүүх
University list + Filters + Apply link
6️⃣ Consultation
Итгэлцэлтэй зөвлөгөө авах
Advisor list + “Ask Expert” CTA
7️⃣ Conversion
Төлбөртэй зөвлөгөө эсвэл Premium руу хөрвөх
Checkout → Thank-you screen
8️⃣ Retention
Буцааж татах, дахин холбох
Notifications + Recommendations


🧩 III. Алхам алхмаар UX бүтэц
1️⃣ Onboarding & Home UX
🎯 Зорилго: Хэрэглэгчийг 10 секундийн дотор платформын үнэ цэнийг ойлгуулах.
UI flow:
Splash (лого + tagline “Таны ирээдүй — таны мэдлэгтэй сонголт”)


3 onboarding slides:


“Мэргэжлээ зөв сонго”


“Сургуулиа бодитоор харьцуул”


“Зөвлөгөө аваад шийдвэрээ гарга”


CTA: [Тест эхлэх] / [Шууд үзэх]


UX онцлог:
Micro animation (slide transition)


Skip button → reduces friction


Firebase event: onboarding_completed = true



2️⃣ Тестийн UX (RIASEC)
🎯 Зорилго: Сурагчийг анхаарлыг алдалгүйгээр бүх асуултыг бөглүүлэх.
UX элементүүд:
Progress bar “7/30”


Sticky CTA (Доод талд: [Буцах] [Дараах])


Micro-reward (Хагас дундаас: “Та сайн явж байна 👏”)


“Finish” дэлгэц → “Таны код: SEC” + 3 keyword chip


UX metric: Test completion ≥ 70%

3️⃣ Career Recommendation UX (Occupation List)
🎯 Зорилго: Тестийн дүнгээс мэргэжлийн чиглэлээ ойлгуулах.
UI flow:
Occupation cards (name + 1 line summary + 💰salary + 📈outlook)


Filter: чиглэл, цалин, эрэлт


CTA bar: [Хөтөлбөрүүдийг харах] [Зөвлөгөө авах]


UX зөвлөмж:
Card click = Focus view (Animated expand)


Tooltip “Энэ мэргэжил танд 86% тохирно”


Fit color scale (green → blue)


KPI: Occupation→Program CTR ≥60%

4️⃣ Program & University UX
🎯 Зорилго: Мэргэжилтэй холбоотой сургалтуудыг хялбар харьцуулах.
Program screen:
Cards: program name, duration, tuition, university badge


Compare drawer (bottom sheet): “3 хөтөлбөр сонгогдсон”


CTA: [Compare] → matrix view (side-by-side table)


Filter: location, tuition, language


University detail:
Tabbed layout: Overview / Majors / Finance / Life / Admission


Sticky bar: [Харьцуулах] [Хадгалах] [Бүртгүүлэх]


KPI: Program→University CTR ≥35%

5️⃣ Advisor & Consultation UX
🎯 Зорилго: Итгэлцэлтэй зөвлөхтэй холбох.
UI flow:
Advisor list (photo + rating + expertise + “Book now”)


Calendar picker → confirm slot


Chat interface (Firebase real-time)


Rating modal дараа нь


UX элемент:
Verified badge (confidence trigger)


Empty-state: “Танд тохирох зөвлөхийг санал болгож байна”


Notification reminder “Таны зөвлөгөө эхлэхэд 10 минут үлдлээ”


KPI: Advisor booking rate ≥5%

6️⃣ Conversion & Retention UX
🎯 Зорилго: Хэрэглэгчийг буцааж холбох, Premium-д хөрвүүлэх.
UX элементүүд:
“First consultation 50% OFF” popup (behavioral trigger)


Push notification: “Таны оноонд тохирох шинэ хөтөлбөр гарлаа”


History tab: saved universities + tests + chats


Profile progress bar (gamification)


Metric: 30-day retention ≥40%

🧠 IV. UX стратегийн удирдамж (Framework)
1️⃣ Consistency: нэг өнгө, зай, товчийн хэлбэр
 2️⃣ Accessibility: монгол фонт уншихад ойлгомжтой байх (Noto Sans Mongolian)
 3️⃣ Progressive Disclosure: нэг дэлгэцэнд 1 шийдвэр гаргах (no overload)
 4️⃣ Emotional Design: микродинамик элементүүд (confetti, check animation)
 5️⃣ Conversion tracking: Firebase / GA4 event per step