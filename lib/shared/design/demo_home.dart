// lib/ui/demo_home.dart
import 'package:flutter/material.dart';
import 'design_system.dart';
import 'atoms/app_button.dart';
import 'atoms/app_chip.dart';
import 'atoms/search_field.dart';
import 'atoms/form_controls.dart';
import 'atoms/states.dart';
import 'atoms/bookmark_button.dart';
import 'atoms/app_progress.dart';
import 'atoms/app_tooltip.dart';
import 'molecules/hero_banner.dart';
import 'molecules/section_header.dart';
import 'molecules/horizontal_scroller.dart';
import 'molecules/paywall_sheet.dart';
import 'molecules/compare_drawer.dart';
import 'molecules/paged_list.dart';
import 'molecules/avatar_uploader.dart';
import 'molecules/notification_sheet.dart';
import 'molecules/chat_input_bar.dart';
import 'molecules/chat_bubble.dart';
import 'molecules/test_stepper.dart';
import 'molecules/app_tabs.dart';
import 'molecules/likert_scale.dart';
import 'organisms/advisor_card.dart';
import 'organisms/university_card.dart';
import 'organisms/career_card.dart';
import 'organisms/article_card.dart';
import 'organisms/university_compare_table.dart';
import 'molecules/sticky_cta.dart';
import 'atoms/filters/university_filter.dart';
import 'atoms/filters/university_filter_sheet.dart';
import 'atoms/filters/university_filter_controller.dart';
import 'atoms/dialogs.dart';
import 'atoms/cached_image.dart';
import 'molecules/offline_banner.dart';
import 'molecules/calendar_slot_picker.dart';
import 'molecules/rating_dialog.dart';
import 'atoms/fit_badge.dart';
import 'atoms/price_tag.dart';
import 'atoms/countdown_badge.dart';
import 'molecules/tag_selector.dart';
import 'molecules/consultation_feedback.dart';
import 'molecules/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/universities/universities_screen.dart'
    show UniversitiesScreen, selectedCompareProvider;

class DemoHome extends ConsumerStatefulWidget {
  const DemoHome({super.key});
  @override
  ConsumerState<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends ConsumerState<DemoHome> {
  int _tab = 0;
  final tags = ['#IT', '#Бизнес', '#Анагаах', '#Инженер', '#Дизайн'];
  String selTag = '#IT';

  // Form controls demo
  bool switchValue = false;
  String segmentValue = 'Бүгд';
  bool checkboxValue = false;
  String? dropdownValue;

  // Avatar uploader demo
  String? avatarUrl;

  // Chat demo
  List<Map<String, dynamic>> chatMessages = [
    {
      'text': 'Сайн уу! Танд хэрхэн туслах вэ?',
      'isMe': false,
      'time': DateTime.now(),
    },
    {
      'text': 'Би IT мэргэжилийн талаар асуух гэсэн',
      'isMe': true,
      'time': DateTime.now(),
    },
  ];

  // Test stepper demo
  int testStepIndex = 1;
  int? selectedAnswer;
  int likertValue = 3; // 1..5

  // New demo state variables
  List<String> selectedTagIds = ['tag1', 'tag3'];

  @override
  Widget build(BuildContext context) {
    final f = ref.watch(universityFilterProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Moli',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder:
                    (_) => NotificationSheet(
                      items: const [
                        'Таны тест бэлэн боллоо!',
                        'Шинэ зөвлөх нэмэгдлээ',
                        'Premium -10% хөнгөлөлттэй',
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _tab,
        children: [
          _buildHomeTab(context, f),
          _buildTestsTab(),
          const UniversitiesScreen(),
          _buildAdvisorsTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CompareDrawer(
            items: ref.watch(selectedCompareProvider),
            onCompare: () {
              final items = ref.read(selectedCompareProvider);
              if (items.length < 2) {
                showAppSnack(
                  context,
                  'Хамгийн багадаа 2 сургууль сонгоно уу',
                  success: false,
                );
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => _UniversityCompareDemo(items: items),
                ),
              );
            },
            onClear: () {
              ref.read(selectedCompareProvider.notifier).state = [];
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _tab,
              onTap: (i) => setState(() => _tab = i),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.background,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textTertiary,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
              selectedIconTheme: const IconThemeData(
                size: 26,
                weight: 600,
                opticalSize: 20,
              ),
              unselectedIconTheme: const IconThemeData(
                size: 24,
                weight: 300,
                opticalSize: 20,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Нүүр',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.psychology_outlined),
                  label: 'Тест',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school_outlined),
                  label: 'Сургууль',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  label: 'Зөвлөх',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Профайл',
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: AppButton.icon(
      //   Icons.help_outline,
      //   onPressed: () {},
      // ),
    );
  }

  // Home tab content
  Widget _buildHomeTab(BuildContext context, UniversityFilter f) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      children: [
        // SearchField - Хайлтын талбар
        SearchBarWithFilter(
          hint: 'Сургуулийн нэр эсвэл чиглэлээр хайх',
          onChanged: (value) {
            ref.read(universityFilterProvider.notifier).state = f.copyWith(
              keyword: value,
            );
          },
          onOpenFilter: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder:
                  (_) => UniversityFilterSheet(
                    initial: f,
                    onApply: (nf) {
                      ref.read(universityFilterProvider.notifier).state = nf;
                    },
                  ),
            );
          },
        ),
        const SizedBox(height: 16),

        HeroBanner(onTest: () {}, onPremium: () {}),
        const SizedBox(height: 16),

        // AppCard болон Badges - Premium агуулга
        const SectionHeader('⭐ Premium Агуулга'),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
            ),
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: const Color(0xFFFFB74D), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFA726).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            children: [
                              Icon(
                                Icons.stars,
                                color: Color(0xFFF57C00),
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Premium',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFF57C00),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Премиум эрхээ идэвхжүүлээд бүх агуулга руу хандаарай',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Зөвлөгөө, тест, курс...',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color(0xFFF57C00),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        const SectionHeader('Зөвлөгөөний видео хичээлүүд'),
        const SizedBox(height: 10),
        HorizontalScroller(
          children: [
            AdvisorCard(
              name: 'Анударь',
              title: 'МУИС – IT багш',
              imageUrl: 'https://i.pravatar.cc/150?img=1',
              locked: true,
            ),
            AdvisorCard(
              name: 'Тэмүүлэн',
              title: 'Data Scientist',
              imageUrl: 'https://i.pravatar.cc/150?img=15',
              locked: false,
            ),
            AdvisorCard(
              name: 'Номин',
              title: 'Career Coach',
              imageUrl: 'https://i.pravatar.cc/150?img=5',
              locked: true,
            ),
          ],
        ),
        const SizedBox(height: 8),

        const SectionHeader('Эрэлттэй чиглэлүүд'),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder:
                (_, i) => AppChip(
                  tags[i],
                  selected: tags[i] == selTag,
                  onTap: () => setState(() => selTag = tags[i]),
                ),
          ),
        ),
        const SizedBox(height: 16),

        const SectionHeader('🧠 Танд тохирох мэргэжлүүд'),
        const SizedBox(height: 10),
        HorizontalScroller(
          children: const [
            CareerCard(
              icon: Icons.analytics,
              title: 'Data Analyst',
              summary: 'Дата шинжилгээ, тайлан, BI.',
              outlook: '📈 Өсөх',
              salary: '3.8M',
            ),
            CareerCard(
              icon: Icons.code,
              title: 'Software Dev',
              summary: 'Backend/Frontend хөгжүүлэлт.',
              outlook: '📈 Өсөх',
              salary: '4.0M',
            ),
          ],
        ),
        const SizedBox(height: 16),

        const SectionHeader('🎓 Танд тохирох сургуулиуд'),
        const SizedBox(height: 10),
        HorizontalScroller(
          children: const [
            UniversityCard(
              logoUrl: 'https://picsum.photos/seed/muuis/100/100',
              name: 'МУИС',
              location: 'Улаанбаатар',
              tuition: '5,200,000₮',
              programs: 35,
            ),
            UniversityCard(
              logoUrl: 'https://picsum.photos/seed/sezis/100/100',
              name: 'СЭЗИС',
              location: 'Улаанбаатар',
              tuition: '4,800,000₮',
              programs: 22,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // RatingStars болон VerifiedBadge - Үнэлгээтэй карт жишээ
        const SectionHeader('🏆 Шилдэг зөвлөхүүд'),
        const SizedBox(height: 10),
        const SectionHeader('Мэдээ ба нийтлэл'),
        const SizedBox(height: 10),
        Stack(
          children: [
            const ArticleCard(
              imageUrl: 'https://picsum.photos/seed/edu1/300/200',
              title: 'Тэтгэлэг авах зөвлөмж',
              subtitle: 'Анхан шатнаас ахисан шат хүртэл...',
            ),
            Positioned(
              top: 8,
              right: 8,
              child: BookmarkButton(
                initial: false,
                onChanged: (saved) {
                  showAppSnack(
                    context,
                    saved ? 'Хадгалагдлаа' : 'Хадгалалтаас хасагдлаа',
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            const ArticleCard(
              imageUrl: 'https://picsum.photos/seed/edu2/300/200',
              title: 'Дэлхийн шилдэг их сургуулиуд',
              subtitle: 'QS Ranking 2025 тойм...',
            ),
            Positioned(
              top: 8,
              right: 8,
              child: BookmarkButton(
                initial: true,
                onChanged: (saved) {
                  showAppSnack(
                    context,
                    saved ? 'Хадгалагдлаа' : 'Хадгалалтаас хасагдлаа',
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Form Controls Demo Section
        const SectionHeader('⚙️ Тохиргоо'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSwitch(
                value: switchValue,
                onChanged: (v) => setState(() => switchValue = v),
                label: 'Мэдэгдэл идэвхтэй',
              ),
              const SizedBox(height: 16),
              const Text(
                'Харагдах горим',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              AppSegmented<String>(
                value: segmentValue,
                options: const ['Бүгд', 'Шинэ', 'Хадгалсан'],
                label: (v) => v,
                onChanged: (v) => setState(() => segmentValue = v),
              ),
              const SizedBox(height: 16),
              AppCheckbox(
                value: checkboxValue,
                onChanged: (v) => setState(() => checkboxValue = v ?? false),
                label: 'Premium агуулга харуулах',
              ),
              const SizedBox(height: 16),
              AppDropdown<String>(
                value: dropdownValue,
                items: const ['Улаанбаатар', 'Дархан', 'Эрдэнэт', 'Чойбалсан'],
                label: (v) => v,
                hint: 'Хот сонгох',
                onChanged: (v) => setState(() => dropdownValue = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // FIT BADGE DEMO
        const SectionHeader('🎯 Тохирох хувь (Fit Badge)'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            FitBadge(
              percentage: 35,
              size: FitBadgeSize.compact,
              tooltipText: '35% тохирч байна',
            ),
            FitBadge(
              percentage: 65,
              size: FitBadgeSize.normal,
              tooltipText: '65% тохирч байна',
            ),
            FitBadge(
              percentage: 92,
              size: FitBadgeSize.large,
              tooltipText: '92% тохирч байна',
            ),
          ],
        ),
        const SizedBox(height: 20),

        // PRICE TAG DEMO
        const SectionHeader('💰 Үнийн шошго (Price Tag)'),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            PriceTag(price: 150000, duration: '1 цаг', icon: Icons.video_call),
            SizedBox(height: 12),
            PriceTag(
              price: 85000,
              oldPrice: 120000,
              discountPercentage: 30,
              duration: '45 мин',
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: 20),

        // COUNTDOWN BADGE DEMO
        const SectionHeader('⏰ Цаг хэмжигч (Countdown Badge)'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            CountdownBadge(
              targetDate: DateTime.now().add(
                const Duration(days: 10, hours: 5),
              ),
              format: CountdownFormat.full,
            ),
            CountdownBadge(
              targetDate: DateTime.now().add(
                const Duration(days: 5, hours: 12),
              ),
              format: CountdownFormat.compact,
              icon: Icons.local_fire_department,
            ),
            CountdownBadge(
              targetDate: DateTime.now().add(const Duration(days: 2, hours: 3)),
              format: CountdownFormat.simple,
            ),
          ],
        ),
        const SizedBox(height: 20),

        // TAG SELECTOR DEMO
        const SectionHeader('🏷️ Таг сонгогч (Tag Selector)'),
        const SizedBox(height: 12),
        TagSelector(
          tags: const [
            TagItem(id: 'tag1', label: 'IT', icon: Icons.computer),
            TagItem(id: 'tag2', label: 'Бизнес', icon: Icons.business),
            TagItem(id: 'tag3', label: 'Анагаах', icon: Icons.local_hospital),
            TagItem(id: 'tag4', label: 'Инженер', icon: Icons.engineering),
            TagItem(id: 'tag5', label: 'Дизайн', icon: Icons.palette),
            TagItem(id: 'tag6', label: 'Хууль', icon: Icons.gavel),
            TagItem(id: 'tag7', label: 'Багшлах', icon: Icons.school),
            TagItem(id: 'tag8', label: 'Уран бүтээл', icon: Icons.brush),
          ],
          selectedIds: selectedTagIds,
          onSelectionChanged: (ids) {
            setState(() {
              selectedTagIds = ids;
            });
          },
          maxVisibleTags: 5,
        ),
        const SizedBox(height: 20),

        // CONSULTATION FEEDBACK DEMO BUTTON
        const SectionHeader('⭐ Үнэлгээ өгөх (Consultation Feedback)'),
        const SizedBox(height: 12),
        AppButton.primary(
          'Үнэлгээ өгөх форм харах',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder:
                  (context) => Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ConsultationFeedback(
                        session: ConsultationSession(
                          advisorName: 'Тэмүүлэн',
                          advisorAvatar: 'https://i.pravatar.cc/150?img=15',
                          date: DateTime.now().subtract(
                            const Duration(hours: 1),
                          ),
                          duration: const Duration(minutes: 45),
                          topic: 'IT мэргэжлийн сонголт',
                        ),
                        onSubmit: (rating, comment) {
                          showAppSnack(
                            context,
                            'Үнэлгээ илгээгдлээ: $rating ⭐',
                          );
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
            );
          },
        ),
        const SizedBox(height: 20),

        // Avatar Uploader Demo
        const SectionHeader('👤 Профайл зураг'),
        const SizedBox(height: 12),
        Center(
          child: AvatarUploader(
            imageUrl: avatarUrl,
            onPick: () {
              setState(() {
                avatarUrl = 'https://i.pravatar.cc/150?img=8';
              });
              showAppSnack(context, 'Зураг солигдлоо!');
            },
          ),
        ),
        const SizedBox(height: 16),

        // Empty State Demo
        const SectionHeader('📭 Хоосон state'),
        const SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: EmptyState(
            title: 'Мэдэгдэл байхгүй',
            subtitle: 'Шинэ мэдэгдэл ирэх үед энд харагдана',
            action: AppButton.primary('Тохиргоо', onPressed: () {}),
          ),
        ),
        const SizedBox(height: 16),

        // Skeleton Loading Demo
        const SectionHeader('⏳ Ачаалж байна...'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Column(
            children: const [
              SkeletonBox(height: 80, width: double.infinity),
              SizedBox(height: 12),
              SkeletonBox(height: 16, width: 200),
              SizedBox(height: 8),
              SkeletonBox(height: 12, width: 150),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Test CompareDrawer
        const SectionHeader('📊 Харьцуулах'),
        const SizedBox(height: 12),
        Text(
          'Сургуулиуд нэмээд, доод талын "→ Харьцуулах" товч дарна уу:',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            AppButton.primary(
              'МУИС нэмэх',
              onPressed: () {
                final current = ref.read(selectedCompareProvider);
                if (!current.contains('МУИС')) {
                  ref.read(selectedCompareProvider.notifier).state = [
                    ...current,
                    'МУИС',
                  ];
                }
              },
            ),
            AppButton.primary(
              'СЭЗИС нэмэх',
              onPressed: () {
                final current = ref.read(selectedCompareProvider);
                if (!current.contains('СЭЗИС')) {
                  ref.read(selectedCompareProvider.notifier).state = [
                    ...current,
                    'СЭЗИС',
                  ];
                }
              },
            ),
            AppButton.primary(
              'ШУТИС нэмэх',
              onPressed: () {
                final current = ref.read(selectedCompareProvider);
                if (!current.contains('ШУТИС')) {
                  ref.read(selectedCompareProvider.notifier).state = [
                    ...current,
                    'ШУТИС',
                  ];
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppButton.primary(
          '👀 Харьцуулалтын жишээ шууд харах',
          expanded: true,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (_) => _UniversityCompareDemo(
                      items: const ['МУИС', 'СЭЗИС', 'ШУТИС'],
                    ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Paywall Sheet Demo
        Row(
          children: [
            Expanded(
              child: AppButton.primary(
                '💎 Premium',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder:
                        (_) => PaywallSheet(
                          onSubscribe: () {
                            Navigator.pop(context);
                            showAppSnack(context, 'Premium идэвхжлээ! 🎉');
                          },
                        ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppButton.primary(
                '📋 PagedList',
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => _PagedListDemo()));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Progress Bar Demo
        const SectionHeader('📊 Progress хэмжигч'),
        const SizedBox(height: 12),
        Column(
          children: [
            AppProgressBar(value: 0.3),
            const SizedBox(height: 8),
            const Text('30% - Эхлэл', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 12),
            AppProgressBar(value: 0.65),
            const SizedBox(height: 8),
            const Text('65% - Дунд үе', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 12),
            AppProgressBar(value: 0.9),
            const SizedBox(height: 8),
            const Text('90% - Бараг дууслаа', style: TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 16),

        // Tooltip Demo
        const SectionHeader('💡 Tooltip тайлбар'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppTooltip(
                message: 'Энэ бол анхааруулга! Та үүнийг уншаарай.',
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Дарж харах',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Row(
                children: const [
                  Text('Тусламж '),
                  InfoTooltipIcon(
                    'Энэ талбарт таны нэр оруулна. Монгол эсвэл англи үсгээр бичнэ үү.',
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // AppTabs Demo
        const SectionHeader('📑 Tabs навигаци'),
        const SizedBox(height: 12),
        AppTabs(
          tabs: const ['Бүгд', 'IT', 'Бизнес'],
          pages: [
            _buildTabContent('Бүгд', '📚 Бүх мэргэжлүүд энд'),
            _buildTabContent('IT', '💻 IT мэргэжлүүд'),
            _buildTabContent('Бизнес', '💼 Бизнесийн чиглэл'),
          ],
        ),
        const SizedBox(height: 16),

        // Test Stepper Demo with LikertScale
        const SectionHeader('📝 Тест Stepper + Likert Scale'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: TestStepper(
            index: testStepIndex,
            total: 5,
            onPrev: () {
              if (testStepIndex > 1) {
                setState(() => testStepIndex--);
              }
            },
            onNext: () {
              if (testStepIndex < 5) {
                setState(() => testStepIndex++);
              } else {
                showAppSnack(context, 'Тест дууслаа! 🎉');
              }
            },
            question: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Та командаар ажиллах дуртай юу?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                LikertScale(
                  value: likertValue,
                  onChanged: (v) => setState(() => likertValue = v),
                  emoji: true,
                  leftHint: 'Огт үгүй',
                  rightHint: 'Маш их тийм',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // // Standalone Likert Scale Demo
        const SectionHeader('😊 Likert Scale (emoji болон текст)'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Column(
            children: [
              const Text(
                'Emoji хувилбар:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              LikertScale(
                value: likertValue,
                onChanged: (v) {
                  setState(() => likertValue = v);
                  showAppSnack(context, 'Сонгосон: $v/5');
                },
                emoji: true,
                leftHint: 'Муу',
                rightHint: 'Сайн',
              ),
              const SizedBox(height: 24),
              const Text(
                'Тоон хувилбар:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              LikertScale(
                value: likertValue,
                onChanged: (v) => setState(() => likertValue = v),
                emoji: false,
                leftHint: '1',
                rightHint: '5',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Chat Demo
        Row(
          children: [
            Expanded(child: const SectionHeader('💬 Chat хэсэг')),
            AppButton.primary(
              'Чат нээх',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (_) => _ChatDemo(
                          messages: chatMessages,
                          onSend: (text) {
                            setState(() {
                              chatMessages.add({
                                'text': text,
                                'isMe': true,
                                'time': DateTime.now(),
                              });
                            });
                          },
                        ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: ListView.builder(
            itemCount: chatMessages.length,
            itemBuilder: (ctx, i) {
              final msg = chatMessages[i];
              return ChatBubble(
                text: msg['text'],
                isMe: msg['isMe'],
                time: msg['time'],
                showTime: i == chatMessages.length - 1,
              );
            },
          ),
        ),
        const SizedBox(height: 80),

        // Dialogs Demo
        const SectionHeader('🔔 Диалог цонхнууд'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: AppButton.primary(
                'Баталгаажуулах',
                onPressed: () async {
                  final confirmed = await showConfirmDialog(
                    context,
                    message: 'Та энэ үйлдлийг хийхдээ итгэлтэй байна уу?',
                  );
                  if (confirmed) {
                    showAppSnack(context, 'Баталгаажсан! ✅');
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppButton.primary(
                'Үнэлэх',
                onPressed: () {
                  showRatingDialog(
                    context,
                    onSubmit: (rating) {
                      showAppSnack(context, '$rating од үнэлгээ өгсөн! ⭐');
                    },
                    onComment: (comment) {
                      if (comment.isNotEmpty) {
                        showAppSnack(context, 'Сэтгэгдэл: $comment');
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // OfflineBanner Demo
        const SectionHeader('📡 Offline баннер'),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Column(
            children: [
              const OfflineBanner(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Интернэт холболт тасарвал автоматаар баннер харагдана',
                  style: const TextStyle(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // CachedImage Demo
        const SectionHeader('🖼️ Cached зургууд'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            CachedRoundImage(url: 'https://i.pravatar.cc/150?img=10', size: 64),
            CachedRoundImage(url: 'https://i.pravatar.cc/150?img=20', size: 80),
            CachedRoundImage(url: 'https://i.pravatar.cc/150?img=30', size: 64),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Кэштэй зургууд хурдан ачаалагддаг',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // CalendarSlotPicker Demo
        const SectionHeader('📅 Календарь & Цаг сонгох'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: CalendarSlotPicker(
            initial: DateTime.now(),
            slots: const [
              TimeOfDay(hour: 9, minute: 0),
              TimeOfDay(hour: 10, minute: 0),
              TimeOfDay(hour: 11, minute: 0),
              TimeOfDay(hour: 14, minute: 0),
              TimeOfDay(hour: 15, minute: 0),
              TimeOfDay(hour: 16, minute: 0),
            ],
            onSelect: (date, slot) {
              final dateStr = '${date.year}/${date.month}/${date.day}';
              final timeStr =
                  '${slot.hour}:${slot.minute.toString().padLeft(2, '0')}';
              showAppSnack(context, 'Сонгосон: $dateStr $timeStr 🗓️');
            },
          ),
        ),
        const SizedBox(height: 16),

        StickyCTA(label: 'Таны сонсох зөвлөмж', onPressed: () {}),
      ],
    );
  }

  // Tests tab content
  Widget _buildTestsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.explore, size: 64, color: AppColors.textSecondary),
          SizedBox(height: 16),
          Text(
            'Тестүүд',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Тестүүд удахгүй нэмэгдэнэ',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  // Advisors tab content
  Widget _buildAdvisorsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 16),
          Text(
            'Зөвлөхүүд',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Зөвлөхүүдтэй чатлах боломжтой',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  // Profile tab content
  Widget _buildProfileTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.person, size: 64, color: AppColors.textSecondary),
          SizedBox(height: 16),
          Text(
            'Профайл',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Таны профайл мэдээлэл',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  // Helper функц - Tabs-н контент үүсгэх
  Widget _buildTabContent(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// PagedList жишээ хуудас
class _PagedListDemo extends StatefulWidget {
  @override
  State<_PagedListDemo> createState() => _PagedListDemoState();
}

class _PagedListDemoState extends State<_PagedListDemo> {
  List<String> items = List.generate(20, (i) => 'Элемент ${i + 1}');
  bool loadingMore = false;

  Future<void> _loadMore() async {
    if (loadingMore) return;
    setState(() => loadingMore = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      final start = items.length;
      items.addAll(List.generate(10, (i) => 'Элемент ${start + i + 1}'));
      loadingMore = false;
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      items = List.generate(20, (i) => 'Элемент ${i + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PagedList жишээ')),
      body: PagedList(
        itemCount: items.length,
        loadingMore: loadingMore,
        onLoadMore: _loadMore,
        onRefresh: _refresh,
        itemBuilder:
            (ctx, i) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.article, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      items[i],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
      ),
    );
  }
}

// Chat жишээ хуудас
class _ChatDemo extends StatefulWidget {
  final List<Map<String, dynamic>> messages;
  final ValueChanged<String> onSend;

  const _ChatDemo({required this.messages, required this.onSend});

  @override
  State<_ChatDemo> createState() => _ChatDemoState();
}

class _ChatDemoState extends State<_ChatDemo> {
  final List<Map<String, dynamic>> localMessages = [];

  @override
  void initState() {
    super.initState();
    localMessages.addAll(widget.messages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат жишээ'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: localMessages.length,
              itemBuilder: (ctx, i) {
                final msg = localMessages[i];
                return ChatBubble(
                  text: msg['text'],
                  isMe: msg['isMe'],
                  time: msg['time'],
                  showTime:
                      i == localMessages.length - 1 ||
                      (i < localMessages.length - 1 &&
                          localMessages[i]['isMe'] !=
                              localMessages[i + 1]['isMe']),
                );
              },
            ),
          ),
          ChatInputBar(
            onSend: (text) {
              setState(() {
                localMessages.add({
                  'text': text,
                  'isMe': true,
                  'time': DateTime.now(),
                });
              });
              widget.onSend(text);

              // Жишээ хариу өгөх (2 секундын дараа)
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  setState(() {
                    localMessages.add({
                      'text': 'Баярлалаа! Танд илүү дэлгэрэнгүй мэдээлэл өгье.',
                      'isMe': false,
                      'time': DateTime.now(),
                    });
                  });
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

// University Compare хуудас
class _UniversityCompareDemo extends StatelessWidget {
  final List<String> items;
  const _UniversityCompareDemo({required this.items});

  @override
  Widget build(BuildContext context) {
    // Жишээ өгөгдөл үүсгэх
    final universities = items.map((name) => _createUniversity(name)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сургууль харьцуулах'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              showAppSnack(context, 'Харьцуулалт хуваалцагдлаа!');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Сонгосон сургуулиудыг харьцуулах',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            '${items.length} сургууль',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          UniversityCompareTable(items: universities),
          const SizedBox(height: 24),
          const Text(
            '💡 Зөвлөмж:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: const Text(
              'Элсэлтийн босго, төлбөр, хөтөлбөрийн тоо зэрэг үзүүлэлтүүдийг харьцуулж таны хэрэгцээнд тохирсон сургуулиа сонгоорой.',
              style: TextStyle(height: 1.5),
            ),
          ),
          const SizedBox(height: 16),
          AppButton.primary(
            'Бүгдийг сонгох',
            expanded: true,
            onPressed: () {
              Navigator.pop(context);
              showAppSnack(context, 'Сургуулиуд сонгогдлоо! 🎉');
            },
          ),
        ],
      ),
    );
  }

  CompareUniversity _createUniversity(String name) {
    // Жишээ өгөгдөл үүсгэх
    switch (name) {
      case 'МУИС':
        return CompareUniversity(
          name: 'МУИС',
          logoUrl:
              'https://upload.wikimedia.org/wikipedia/commons/4/4e/National_University_of_Mongolia_Logo.png',
          location: 'Улаанбаатар',
          tuition: '5,200,000₮',
          entryScore: 650,
          programs: 35,
          dorm: true,
          rating: 4.8,
          verified: true,
        );
      case 'СЭЗИС':
        return CompareUniversity(
          name: 'СЭЗИС',
          logoUrl:
              'https://upload.wikimedia.org/wikipedia/commons/2/28/NUM_Seal.png',
          location: 'Улаанбаатар',
          tuition: '4,800,000₮',
          entryScore: 620,
          programs: 22,
          dorm: true,
          rating: 4.6,
          verified: true,
        );
      case 'ШУТИС':
        return CompareUniversity(
          name: 'ШУТИС',
          logoUrl:
              'https://upload.wikimedia.org/wikipedia/commons/4/4e/National_University_of_Mongolia_Logo.png',
          location: 'Улаанбаатар',
          tuition: '4,500,000₮',
          entryScore: 600,
          programs: 28,
          dorm: false,
          rating: 4.5,
          verified: true,
        );
      default:
        return CompareUniversity(
          name: name,
          logoUrl:
              'https://upload.wikimedia.org/wikipedia/commons/4/4e/National_University_of_Mongolia_Logo.png',
          location: 'Улаанбаатар',
          tuition: '5,000,000₮',
          entryScore: 630,
          programs: 30,
          dorm: true,
          rating: 4.5,
          verified: true,
        );
    }
  }
}
