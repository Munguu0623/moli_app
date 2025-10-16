// lib/features/tests/presentation/test_result_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../../../core/widgets/atoms/app_card.dart';
import '../application/test_provider.dart';

/// Тестийн үр дүнгийн хуудас - RIASEC код болон санал
class TestResultScreen extends ConsumerWidget {
  const TestResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(testResultProvider);

    if (result == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            'Тест бөглөөгүй байна',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Таны үр дүн',
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Go back to home/tests screen
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(16),

            // RIASEC Code Card
            Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Таны RIASEC код',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        result.code,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 8,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        _getCodeDescription(result.code),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.9, 0.9), duration: 600.ms),

            const Gap(24),

            // Traits Section
            Text(
                  'Таны гол шинж чанарууд',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideX(begin: -0.1, duration: 600.ms, delay: 200.ms),

            const Gap(12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  result.traits.asMap().entries.map((entry) {
                    return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(
                          duration: 400.ms,
                          delay: (300 + entry.key * 100).ms,
                        )
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          duration: 400.ms,
                          delay: (300 + entry.key * 100).ms,
                        );
                  }).toList(),
            ),

            const Gap(32),

            // Scores Section
            Text(
                  'Дэлгэрэнгүй оноо',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 600.ms)
                .slideX(begin: -0.1, duration: 600.ms, delay: 600.ms),

            const Gap(12),

            ...result.scores.entries.map((entry) {
              final maxScore = 25; // 5 questions * 5 max per question
              final percentage = (entry.value / maxScore).clamp(0.0, 1.0);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ScoreBar(
                  category: entry.key,
                  score: entry.value,
                  percentage: percentage,
                  delay:
                      700 +
                      result.scores.keys.toList().indexOf(entry.key) * 100,
                ),
              );
            }),

            const Gap(32),

            // CTA Buttons
            Text(
                  'Дараагийн алхам',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 1200.ms)
                .slideX(begin: -0.1, duration: 600.ms, delay: 1200.ms),

            const Gap(16),

            AppButton.primary(
                  '🎯 Тохирох мэргэжлүүдийг харах',
                  expanded: true,
                  onPressed: () {
                    // TODO: Navigate to career recommendations
                    debugPrint('View recommended careers');
                  },
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 1300.ms)
                .slideY(begin: 0.2, duration: 600.ms, delay: 1300.ms),

            const Gap(12),

            AppButton.secondary(
                  '🎓 Сургуулиудыг үзэх',
                  expanded: true,
                  onPressed: () {
                    // TODO: Navigate to universities
                    debugPrint('View universities');
                  },
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 1400.ms)
                .slideY(begin: 0.2, duration: 600.ms, delay: 1400.ms),

            const Gap(12),

            AppButton.secondary(
                  '💬 Зөвлөгөө авах',
                  expanded: true,
                  onPressed: () {
                    // TODO: Navigate to advisors
                    debugPrint('Get consultation');
                  },
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 1500.ms)
                .slideY(begin: 0.2, duration: 600.ms, delay: 1500.ms),

            const Gap(24),
          ],
        ),
      ),
    );
  }

  String _getCodeDescription(String code) {
    final Map<String, String> descriptions = {
      'R': 'Realistic - Практик, техник чиглэлтэй',
      'I': 'Investigative - Судлаач, шинжээч',
      'A': 'Artistic - Бүтээлч, уран сайхны',
      'S': 'Social - Нийгмийн, хамтын ажиллагаа',
      'E': 'Enterprising - Бизнес, манлайлал',
      'C': 'Conventional - Зохион байгуулалт, эмх цэгц',
    };

    final parts = code.split('');
    return parts
        .map((letter) => descriptions[letter]?.split(' - ')[0] ?? letter)
        .join(', ');
  }
}

/// RIASEC категорийн оноо харуулах bar
class _ScoreBar extends StatelessWidget {
  final String category;
  final int score;
  final double percentage;
  final int delay;

  const _ScoreBar({
    required this.category,
    required this.score,
    required this.percentage,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final categoryNames = {
      'R': 'Realistic',
      'I': 'Investigative',
      'A': 'Artistic',
      'S': 'Social',
      'E': 'Enterprising',
      'C': 'Conventional',
    };

    return AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$category - ${categoryNames[category]}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppGradients.brand,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$score / 25',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 12,
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: AppColors.border,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: delay.ms)
                  .slideX(begin: -0.5, duration: 800.ms, delay: delay.ms),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: delay.ms)
        .slideX(begin: -0.1, duration: 400.ms, delay: delay.ms);
  }
}
