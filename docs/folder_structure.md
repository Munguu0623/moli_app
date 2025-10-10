


lib/
├─ app/                    # entry, DI, routing, theme
│  ├─ app.dart
│  ├─ router.dart
│  ├─ theme/
│  │  ├─ colors.dart
│  │  ├─ typography.dart
│  │  └─ theme.dart
│  ├─ localization/        # l10n wrappers
│  └─ di/                  # providers for global singletons
│
├─ core/                   # cross-cutting concerns
│  ├─ config/              # env, feature flags
│  ├─ network/             # http/dio client, interceptors
│  ├─ error/               # failures, exceptions
│  ├─ utils/               # formatters, validators
│  ├─ storage/             # secure storage, prefs
│  ├─ analytics/           # Firebase/GA4 events
│  └─ widgets/             # shared UI atoms (Button, Chip, EmptyState)
│
├─ data/                   # shared DTOs & mappers (if reuse across features)
│  ├─ dto/
│  └─ mappers/
│
├─ features/
│  ├─ home/                # Нүүр (CTA, personalized feeds)
│  ├─ tests/               # RIASEC тестийн бүх урсгал
│  ├─ occupations/         # мэргэжлийн жагсаалт/дэлгэрэнгүй
│  ├─ universities/        # их сургуулиуд (лист, detail, compare)
│  ├─ advisors/            # зөвлөх (лист, профайл, booking, чат)
│  ├─ profile/             # хадгалсан зүйлс, тестийн дүн, захиалгууд
│  └─ blog/                # нийтлэлүүд
│
├─ shared/                 # design system level
│  ├─ design/              # spacing, radius, shadows, gradients
│  ├─ icons/
│  └─ localization/        # helper extensions for tr()
│
└─ main_dev.dart | main_prod.dart | main_stg.dart


universities/
├─ data/
│  ├─ models/          # DTO (json) + Freezed
│  ├─ sources/
│  │  ├─ remote/       # REST endpoints (get list/detail/compare)
│  │  └─ local/        # cache (Hive/Isar)
│  └─ repositories/    # impl (combine remote + cache)
├─ domain/
│  ├─ entities/        # pure models UI-д хэрэгтэй талбартай
│  └─ repositories/    # abstract interfaces
├─ application/
│  ├─ usecases/        # fetchList, fetchDetail, compare
│  └─ providers/       # Riverpod Notifier/AsyncNotifier
└─ presentation/
   ├─ screens/         # ListScreen, DetailScreen, CompareScreen
   ├─ widgets/         # UniversityCard, FilterSheet, CompareTable
   └─ routing/         # feature routes (sub-routes)


// app/router.dart
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    ShellRoute( // BottomNav for main sections
      builder: (_, __, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/tests', builder: (_, __) => const TestIntroScreen()),
        GoRoute(path: '/universities', builder: (_, __) => const UniListScreen()),
        GoRoute(path: '/advisors', builder: (_, __) => const AdvisorListScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
      ],
    ),
    GoRoute(path: '/universities/:id', builder: (_, s) => UniDetailScreen(id: s.pathParameters['id']!)),
  ],
);
