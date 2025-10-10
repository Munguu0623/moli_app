Flutter High-Performance Code Standards (MVP→Scale)
0) Гол зорилт ба төсөлд мөрдөх “budget”

60 fps (frame budget ≤ 16.67ms), jank ≤ 1%.

Хүйтэн асалт (cold start, release) ≤ 1.8s (Android mid-range), ≤ 1.2s (iOS).

APK/AAB өсөлт: < 20 MB / feature.

Суудал (runtime) санах ой: Home анхны render үед ≤ 120MB; List/Detail навигацийн хооронд нэмэгдэл ≤ +40MB.

Сүлжээ: гол листүүд ≤ 1 RTT (кэштэй), зураг lazy, resized.

1) Архитектур ба модульчлал

Feature-based (domain/data/presentation/application) – өмнө санал болгосон бүтэц.

State management: Riverpod (AsyncNotifier/Notifier). UI-гийн түр state бол StatefulWidget/ValueNotifier OK.

Boundary дүрэм: presentation → application(usecase/provider) → domain(repo iface) → data(repo impl).

Харилцан хамаарал: presentation data руу шууд орохыг хоригло.

2) Гүйцэтгэл: UI rendering ба rebuild хяналт

const-ийг дайчил: бүх статик Widget/Style/EdgeInsets/BorderRadius.

Keys: динамик жагсаалтад ValueKey/ObjectKey ашиглаж diff-ийг зөв удирд.

Rebuild зогсоох:

Их өгөгдөхтэй виджетийг Stateless + external state (provider.select)-ээр нарийн хяна.

List item дотор ref.watch → ref.watch(provider.select((s)=>s.fieldForThisRow(id))).

Lists:

ListView.builder, SliverList/SliverGrid. shrinkWrap: true-г асар их хэмжээгээр бүү хэрэглэ.

Item-ийн өндөр тогтвортой бол itemExtent/prototypeItem.

CacheExtent-ийг багаас дунд (экран ± 2–3) тохируул.

Images:

Зураг бүрт зүсэлт/хэмжилт сервер дээр; client талд cacheWidth/height зааж өг.

precacheImage зөвхөн дараагийн дэлгэцийн hero/critical asset-д.

cached_network_image + memoryCacheWidth/height.

Clip/Opacity/Shadow:

Clip/BackdropFilter/ShaderMask их хэрэглэхээс зайлсхий.

BoxShadow бага зэрэг (single soft shadow).

Animations:

Impeller (iOS)-д OK, гэхдээ 60fps-д CPU-heavy аним бүү хий.

AnimatedBuilder/TweenAnimationBuilder, Lottie-г бага зэргийн хэмжээнд.

RepaintBoundary: скроллддог том item, chart, map гэх мэтэд тусгаарлаж repaint-ийг хязгаарла.

3) Асинхрон урсгал ба сүлжээ

Dio:

Global instance + Interceptor: auth header, retry (экспоненциал 3x), connectivity check, JSON logging (dev-д л).

Cancellation: UI гарвал CancelToken дамжуулж цуцал.

Timeouts: connect 5s, receive 10s (critical calls 15s).

Pagination: Cursor/offset-оор, onEndReached дебоунс 300ms.

Caching давхарга:

Stale-while-revalidate: Isar/Hive-д local snapshot → UI render → network refresh.

TTL per endpoint (жишээ: universities list 24h, advisors 6h, tests meta 72h).

Error model: NetworkError | ApiError | AuthError | Unexpected – UI-д ялгаж харуул.

4) Санах ой ба нөөц

Big object lifecycle: VideoController, MapController, AnimationController-ыг dispose заавал.

Images: том зурагт Image.memory-г зайлсхий; боломжгүй бол Uint8List-ийг LRU кэшлэ.

Streams/Subscriptions: UI-гаас гарахад цацалт заавал зогсоо.

Isolates/compute: том JSON parse, мөнгөний формат, зураг decode зэрэг CPU-хүнд ажлыг тусгаарла.

5) Навигаци ба state хадгалалт

GoRouter (эсвэл shell + IndexedStack) – табуудын state хадгалахын тулд IndexedStack.

Deep link/guard зөвхөн router түвшинд; UI-д логик бүү хутга.

Backstack-ийг хэт уртасгахгүй; modal bottom sheets-д useSafeArea.

6) Forms & Validation

Урт формд reactive_forms эсвэл form_builder.

Валидац хуудсыг дахин зурж болохоор хүнд болгохгүй: тусдаа widget + ValueNotifier/select.

7) Олон хэл, хүртээмж

gen-l10n (flutter generate: true), AppLocalizations.of(context)!.

Текст scalable: textScaleFactor-ыг хаахгүй (design-ын эвдрэлгүй).

Semantics/labels: үндсэн товчлуурууд, навигац, hero-д тайлбар өг.

8) Логжилт, аналитик, онцгой алдаа

Prod: зөөлөн лог (WARN/ERROR), PII бүү логло.

Crash: Crashlytics/Sentry – userId-г hash/анонимжуул.

Analytics event map: Test/University/Advisor урсгалд заавал (нэршил тогтмол, параметр schema).

9) Аюулгүй байдал

JWT SecureStorage; refresh Interceptor; token-ийг Memory-д бүү хадгал (зөвхөн runtime).

SSL pinning (хэрэв шаардлагатай).

Deeplink урсгалд параметр шалгалт; WebView-д javascriptMode: restricted.

10) Package бодлого

“Core only” бодлого: go_router, riverpod, dio, freezed/json_serializable, isar/hive, cached_network_image, intl.

Хориглох:

setState-д тулгуурласан глобал state (Provider/InheritedWidget-ээр “юу ч явдаг” архитектур).

Хэт олон UI animation/blur/shadow.

FutureBuilder олон давхар давтагдсан – оронд нь provider.

11) Code style & lint

Effective Dart + доорх lint:

analysis_options.yaml (ишлэл):

include: package:flutter_lints/flutter.yaml
linter:
  rules:
    always_declare_return_types: true
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    prefer_final_locals: true
    prefer_single_quotes: true
    avoid_redundant_argument_values: true
    cascade_invocations: true
    avoid_dynamic_calls: true
    prefer_relative_imports: true
    directives_ordering: true
    use_super_parameters: true
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"


Нэршил:

Файл: snake_case.dart, Класс: PascalCase, Provider: xxxProvider, Notifier: XxxNotifier.

Feature фолдер: features/universities/...

12) Riverpod дүрэм (чухал)

ref.watch-ийг UI entry түвшинд; list item дотор select л ашигла.

AsyncNotifier: build() нь заавал side-effect-гүй (logging OK, UI навигац NO).

Provider override: тест дээр network→fake, repo→fake.

Loading state: AsyncValue.guard, UI-д when(data/error/loading).

13) Дохио/сүлжээ оновчлол

Debounce: хайлт/шүүлт 300–500ms.

Throttle: scroll-based ачаалалт 200ms.

Prefetch: дараагийн дэлгэцийн metadata (зургуудыг биш) prefetchлэнэ.

14) Зураг/видео бодлого

Server-side resize (srcset-тэй адил): card = 200–300px өргөн; detail = 600–800px.

Image.network → CachedNetworkImage + cacheWidth.

Video: autoplay feed-ийг хоригло; visible-д орсон үед л preload; dispose хатуу мөрдөнө.

15) CI/CD & чанарын хаалга

CI Jobs: analyze, format check, unit+widget tests, size tracker (apk/aab өсөлт fail threshold: +2MB).

PR Checklist (заавал):

Lint 0 алдаа

New public API-д dartdoc

Widget test (амжилттай)

Performance note (хэрэв animation/list нэмсэн бол тайлбар)

Strings → l10n

Images → cacheWidth/height

Network call → cancelable + TTL/Cache бодлого

Dispose баталгаажсан (controllers, subscriptions)

16) Definition of Done (feature)

UX flow ажиллаж, 60fps (profile build)

Network cancelable + cache TTL тодорхой

Strings → l10n

Images → cacheWidth/height

Provider select ашигласан (list item)

Dispose баталгаажсан

Widget test 1+ нэмж өгсөн

CI lint/test ногоон