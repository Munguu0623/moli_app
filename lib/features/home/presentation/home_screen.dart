// lib/features/home/presentation/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../core/widgets/molecules/hero_banner.dart';
import '../../../core/widgets/molecules/section_header.dart';
import '../../../core/widgets/molecules/horizontal_scroller.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../core/widgets/organisms/career_card.dart';
import '../../../core/widgets/organisms/university_card.dart';
import '../../../core/widgets/organisms/advisor_card.dart';
import '../../../core/widgets/organisms/article_card.dart';
import '../../../core/widgets/atoms/app_chip.dart';
import '../../../shared/design/design_system.dart';
import '../application/home_provider.dart';
import '../../tests/presentation/tests_screen.dart';

/// Нүүр хуудас - UX doc (home_ux.md) дагуу
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final careers = ref.watch(homeCareersProvider);
    final universities = ref.watch(homeUniversitiesProvider);
    final advisors = ref.watch(homeAdvisorsProvider);
    final articles = ref.watch(homeArticlesProvider);
    final trendingTags = ref.watch(trendingTagsProvider);
    final selectedTag = ref.watch(selectedTrendingTagProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Moli',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              // TODO: Show notification sheet
              debugPrint('Show notifications');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),

            // Hero Banner Section
            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HeroBanner(
                    onTest: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const TestsScreen()),
                      );
                    },
                    onPremium: () {
                      // TODO: Show premium paywall
                      debugPrint('Show premium paywall');
                    },
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 100.ms)
                .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 100.ms),

            const Gap(24),

            // Premium Video Section (Advisors)
            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SectionHeader(
                    '🎥 Видео зөвлөгөө',
                    onSeeAll: () {
                      // TODO: Navigate to advisors list
                      debugPrint('Navigate to advisors');
                    },
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 200.ms)
                .slideX(begin: -0.1, end: 0, duration: 400.ms, delay: 200.ms),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: HorizontalScroller(
                children:
                    advisors
                        .asMap()
                        .entries
                        .map(
                          (entry) => GestureDetector(
                            onTap: () {
                              // TODO: Navigate to advisor detail
                              debugPrint('Advisor: ${entry.value.name}');
                            },
                            child: AdvisorCard(
                                  name: entry.value.name,
                                  title: entry.value.title,
                                  imageUrl: entry.value.imageUrl,
                                  rating: entry.value.rating,
                                  price: entry.value.price,
                                  locked: false,
                                )
                                .animate()
                                .fadeIn(
                                  duration: 400.ms,
                                  delay: (250 + entry.key * 100).ms,
                                )
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  duration: 400.ms,
                                  delay: (250 + entry.key * 100).ms,
                                ),
                          ),
                        )
                        .toList(),
              ),
            ),

            const Gap(24),

            // Trending Tags Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader('📈 Эрэлттэй чиглэлүүд')
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 500.ms)
                      .slideX(
                        begin: -0.1,
                        end: 0,
                        duration: 400.ms,
                        delay: 500.ms,
                      ),
                  const Gap(12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        trendingTags
                            .asMap()
                            .entries
                            .map(
                              (entry) => AppChip(
                                    entry.value,
                                    selected: selectedTag == entry.value,
                                    onTap: () {
                                      ref
                                          .read(
                                            selectedTrendingTagProvider
                                                .notifier,
                                          )
                                          .state = selectedTag == entry.value
                                              ? null
                                              : entry.value;
                                    },
                                  )
                                  .animate()
                                  .fadeIn(
                                    duration: 300.ms,
                                    delay: (550 + entry.key * 50).ms,
                                  )
                                  .scale(
                                    begin: const Offset(0.8, 0.8),
                                    duration: 300.ms,
                                    delay: (550 + entry.key * 50).ms,
                                  ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),

            const Gap(24),

            // Personalized Careers Section
            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SectionHeader(
                    '🧠 Танд тохирох мэргэжлүүд',
                    onSeeAll: () {
                      // TODO: Navigate to careers list
                      debugPrint('Navigate to careers');
                    },
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 800.ms)
                .slideX(begin: -0.1, end: 0, duration: 400.ms, delay: 800.ms),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: HorizontalScroller(
                children:
                    careers
                        .take(5)
                        .toList()
                        .asMap()
                        .entries
                        .map(
                          (entry) => GestureDetector(
                            onTap: () {
                              // TODO: Navigate to career detail
                              debugPrint('Career: ${entry.value.title}');
                            },
                            child: CareerCard(
                                  icon: entry.value.icon,
                                  title: entry.value.title,
                                  summary: entry.value.summary,
                                  outlook: entry.value.outlook,
                                  salary: entry.value.salary,
                                  isTrending:
                                      entry.key == 0, // Эхний мэргэжил эрэлттэй
                                  isNew: entry.key == 1, // 2 дахь мэргэжил шинэ
                                  isSaved: false, // TODO: Track saved state
                                  onSave: () {
                                    // TODO: Handle bookmark toggle
                                    debugPrint(
                                      'Bookmark career: ${entry.value.title}',
                                    );
                                  },
                                )
                                .animate()
                                .fadeIn(
                                  duration: 400.ms,
                                  delay: (850 + entry.key * 100).ms,
                                )
                                .slideX(
                                  begin: 0.2,
                                  duration: 400.ms,
                                  delay: (850 + entry.key * 100).ms,
                                ),
                          ),
                        )
                        .toList(),
              ),
            ),

            const Gap(24),

            // Personalized Universities Section
            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SectionHeader(
                    '🎓 Танд тохирох сургуулиуд',
                    onSeeAll: () {
                      // TODO: Navigate to universities list
                      debugPrint('Navigate to universities');
                    },
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 1200.ms)
                .slideX(begin: -0.1, end: 0, duration: 400.ms, delay: 1200.ms),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: HorizontalScroller(
                children:
                    universities
                        .take(5)
                        .toList()
                        .asMap()
                        .entries
                        .map(
                          (entry) => GestureDetector(
                            onTap: () {
                              // TODO: Navigate to university detail
                              debugPrint('University: ${entry.value.name}');
                            },
                            child: UniversityCard(
                                  logoUrl: entry.value.logoUrl,
                                  name: entry.value.name,
                                  location: entry.value.location,
                                  tuition: entry.value.tuition,
                                  programs: entry.value.programs,
                                )
                                .animate()
                                .fadeIn(
                                  duration: 400.ms,
                                  delay: (1250 + entry.key * 100).ms,
                                )
                                .slideX(
                                  begin: 0.2,
                                  duration: 400.ms,
                                  delay: (1250 + entry.key * 100).ms,
                                ),
                          ),
                        )
                        .toList(),
              ),
            ),

            const Gap(24),

            // Articles Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                        '📰 Мэдээ, блог',
                        onSeeAll: () {
                          // TODO: Navigate to articles list
                          debugPrint('Navigate to articles');
                        },
                      )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 1500.ms)
                      .slideX(
                        begin: -0.1,
                        end: 0,
                        duration: 400.ms,
                        delay: 1500.ms,
                      ),
                  const Gap(12),
                  ...articles.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Navigate to article detail
                          debugPrint('Article: ${entry.value.title}');
                        },
                        child: ArticleCard(
                              imageUrl: entry.value.imageUrl,
                              title: entry.value.title,
                              subtitle: entry.value.subtitle,
                              isSaved: false, // TODO: Track saved state
                              onSave: () {
                                // TODO: Handle bookmark toggle
                                debugPrint('Bookmark: ${entry.value.title}');
                              },
                            )
                            .animate()
                            .fadeIn(
                              duration: 400.ms,
                              delay: (1550 + entry.key * 100).ms,
                            )
                            .slideY(
                              begin: 0.1,
                              duration: 400.ms,
                              delay: (1550 + entry.key * 100).ms,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Gap(24),
          ],
        ),
      ),
    );
  }
}
