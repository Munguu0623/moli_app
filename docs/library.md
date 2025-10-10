Routing

go_router – declarative, deep-link/guard/redirect сайтай.

State & DI

hooks_riverpod (эсвэл riverpod + riverpod_annotation + build_runner)

flutter_hooks (сонголттой; UI-н жижиг state-д цэвэр болгодог)

Network

dio – retry/interceptor, cancel, FormData сайн.

pretty_dio_logger – dev лог.

(сонголттой) retrofit + retrofit_generator – typed REST client.

json_serializable эсвэл freezed – DTO/model + equality, copyWith.

Storage / Cache

flutter_secure_storage – токен/JWT.

shared_preferences – жижиг тохиргоо.

isar эсвэл hive – офлайн кэш/листүүд, тестийн завсар хадгалалт.

UI & Design System

flutter_svg, cached_network_image, shimmer – хурдан, цэвэр UI.

flutter_animate эсвэл lottie – lightweight animation.

gap – spacing токен шиг ашиглахад амар.

Forms / Validation

reactive_forms эсвэл flutter_form_builder – олон талбартай форм.

Localization

flutter_localizations (stock gen-l10n)

intl – огноо/тоо формат.

Analytics / Crash

firebase_core, firebase_analytics, firebase_crashlytics

(сонголттой) sentry_flutter

Notifications

firebase_messaging – push.

awesome_notifications (optional local schedule).

Auth (Spring Boot/JWT-тэй нийцүүлж)

jwt_decode (optional) – exp уншихад.

Refresh-ийг dio interceptor дотор хий (дээрх жишээ шиг).

Env/Config

flutter_dotenv эсвэл өөрийн Env класс (flavor-оор).

Dev & Codegen

build_runner, freezed, json_serializable, riverpod_generator

Testing

flutter_test, mocktail, integration_test

riverpod_test (сонголттой) эсвэл provider override ашиглаарай.