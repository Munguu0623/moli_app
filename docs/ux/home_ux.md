🧭 1️⃣ Home UX-ийн гол зорилго
🎯 Зорилго:
“Сурагчийг платформын үнэ цэнэ рүү татах — тест өгөх, контент үзэх, мэргэжил судлах, зөвлөгөө авах үйлдлийг хялбар ойлгуулах.”
UX зарчим:
Нүүр хуудас нь “dashboard биш, landing feed” байх.


Гоё visual, CTA-ууд ил гарсан.


Нэвтрээгүй хэрэглэгч → сонирхуулах контент,
 Нэвтэрсэн хэрэглэгч → personalized recommendation.



🏗️ 2️⃣ Нүүр хуудасны ерөнхий бүтэц (Layout hierarchy)
Бүс
Үүрэг
UI элемент
A. AppBar / Header
Лого + мэдэгдэл
🔔 Notification icon, App logo / avatar
B. Hero Section
Тест өгөхийг уриалах
Banner “Тест өгөөд ирээдүйгээ мэд!” → [Тест өгөх] [Premium Test 🪙]
C. Premium Video Section
Мэргэжлийн зөвлөгөөний хичээлүүд
Horizontal scroll cards (advisor thumbnail + subject)
D. Trending / Insights
Эрэлттэй чиглэлүүд
Tag chip-үүд: #IT #Санхүү #Эрүүлмэнд
E. Personalized Section (if logged in)
Хувийн зөвлөмжүүд


→ “🧠 Танд тохирох мэргэжил 5”




→ “🎓 Тохирох их сургууль 5”




→ “📈 Эрэлттэй чиглэлүүд”




F. Footer / Explore bar
Мэдээллийн холбоос
“Мэдээ ба нийтлэл”, “Тэтгэлэг”, “Зөвлөгөө авах” quick link-үүд


💡 3️⃣ UX behavior logic
Нөхцөл
Үзэгдэх элемент
Guest (нэвтрээгүй)
“Тест өгөх” banner + Premium promo + Trending career list
Logged-in + Test done
Personalized cards (career + university recommendations)
Logged-in + No test yet
CTA popup “Тестээ өгөөд ирээдүйгээ мэд!”
Premium user
Нэмэлт “Видео хичээл” хэсэг идэвхтэй
Guest → Save хийвэл
Login popup “Бүртгүүлж хадгалах уу?”


🎨 4️⃣ UI элементүүдийн зохион байгуулалт (Mobile screen layout)
AppBar:  Moli logo (left)   🔔 (right)

─────────────────────────────
🎯 Banner section
“Тест өгөөд ирээдүйгээ мэд!”
[Тест өгөх]   [Premium Test 🪙]
─────────────────────────────
🎥 Видео зөвлөгөө (carousel)
[AdvisorCard][AdvisorCard][AdvisorCard]
─────────────────────────────
📈 Эрэлттэй чиглэлүүд
#IT  #Бизнес  #Анагаах  #Инженер  #Дизайн
─────────────────────────────
🧠 Танд тохирох мэргэжлүүд (if logged in)
[CareerCard][CareerCard][CareerCard]
─────────────────────────────
🎓 Танд тохирох сургуулиуд (if logged in)
[UniversityCard][UniversityCard][UniversityCard]
─────────────────────────────
📰 Мэдээ, блог
[ArticleCard][ArticleCard]
─────────────────────────────
BottomNav:  Home | Tests | Universities | Advisors | Profile


🔐 5️⃣ Access logic
Feature
Login хэрэгтэй юу
Тайлбар
Тест өгөх
❌ Үгүй
Guest орж болно
Premium Test
✅ Тийм
Subscription
Видео хичээл үзэх
✅ Тийм
Premium only
Save career / university
✅ Тийм
Хадгалах үед login popup
Dashboard feed
✅ Тийм
Personalized data load


📊 6️⃣ UX KPI (success metrics)
Хэмжүүр
Зорилтот утга
Home → Test click rate
≥ 40%
Premium CTA click
≥ 10%
Personalized section engagement
≥ 50%
Time on Home (avg)
≥ 25 секунд
Banner scroll-through
≥ 90% visibility


🧠 7️⃣ UX tone & visual direction
Color: gradient blue/violet (consistent with onboarding)


Card style: rounded 16px, soft shadow


Visual balance: 60% text / 40% visuals


Motion: slide-in banners, smooth horizontal scroll
