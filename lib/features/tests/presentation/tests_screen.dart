// lib/features/tests/presentation/tests_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../core/widgets/atoms/app_card.dart';
import '../../../core/widgets/atoms/badges.dart';
import '../data/mock_tests.dart';
import 'test_intro_screen.dart';

/// Тестүүдийн жагсаалт харуулах хуудас
class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Тестүүд'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Text(
                  'Өөртөө тохирох тестээ сонгоорой',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.2, duration: 400.ms),

            const Gap(8),

            Text(
                  'Тестүүд нь таны сонирхол, чадвар, зан төлөвийг тодорхойлоход тусална',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms, delay: 100.ms)
                .slideY(begin: 0.2, duration: 400.ms, delay: 100.ms),

            const Gap(24),

            // Tests list
            ...mockTests.asMap().entries.map((entry) {
              final test = entry.value;
              final index = entry.key;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                      onTap:
                          test.isPremium
                              ? () {
                                // TODO: Show premium paywall
                                _showPremiumDialog(context);
                              }
                              : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const TestIntroScreen(),
                                  ),
                                );
                              },
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Icon
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color:
                                  test.isPremium
                                      ? AppColors.accent.withOpacity(0.1)
                                      : AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                test.icon,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          const Gap(16),

                          // Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        test.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    if (test.isPremium) const PremiumBadge(),
                                  ],
                                ),
                                const Gap(4),
                                Text(
                                  test.description,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.help_outline,
                                      size: 14,
                                      color: AppColors.textTertiary,
                                    ),
                                    const Gap(4),
                                    Text(
                                      '${test.questionCount} асуулт',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                    const Gap(12),
                                    Icon(
                                      Icons.schedule,
                                      size: 14,
                                      color: AppColors.textTertiary,
                                    ),
                                    const Gap(4),
                                    Text(
                                      '${test.durationMinutes} минут',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Arrow
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color:
                                test.isPremium
                                    ? AppColors.accent
                                    : AppColors.primary,
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: (200 + index * 100).ms)
                    .slideX(
                      begin: 0.2,
                      duration: 400.ms,
                      delay: (200 + index * 100).ms,
                    ),
              );
            }),

            const Gap(24),
          ],
        ),
      ),
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                const Icon(Icons.stars, color: AppColors.accent),
                const Gap(8),
                const Text('Premium тест'),
              ],
            ),
            content: const Text(
              'Энэ тест нь Premium хэрэглэгчдэд зориулагдсан. Premium болж нарийвчилсан дүн шинжилгээ аваарай.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Цуцлах'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Navigate to premium subscription
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                ),
                child: const Text('Premium болох'),
              ),
            ],
          ),
    );
  }
}
