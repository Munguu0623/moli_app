// lib/features/tests/presentation/test_intro_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../core/widgets/atoms/app_card.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../application/test_provider.dart';
import 'test_question_screen.dart';

/// Тестийн танилцуулга хуудас - UX doc (test.md) дагуу
class TestIntroScreen extends ConsumerWidget {
  const TestIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'RIASEC Тест'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(40),

              // Icon
              Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.psychology_outlined,
                      size: 64,
                      color: AppColors.primary,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(begin: const Offset(0.5, 0.5), duration: 600.ms),

              const Gap(32),

              // Title
              Text(
                    'Өөрт тохирох мэргэжлээ олоорой!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.2, duration: 600.ms, delay: 200.ms),

              const Gap(16),

              // Subtitle
              Text(
                    '30 асуултад хариулаад өөрийн сонирхол, чадвараа тодорхойлоорой',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideY(begin: 0.2, duration: 600.ms, delay: 400.ms),

              const Gap(40),

              // Info cards
              AppCard(
                    padding: const EdgeInsets.all(16),
                    child: _InfoRow(
                      icon: Icons.timer_outlined,
                      title: 'Хугацаа',
                      subtitle: '5-7 минут',
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 600.ms)
                  .slideX(begin: -0.2, duration: 600.ms, delay: 600.ms),

              const Gap(12),

              AppCard(
                    padding: const EdgeInsets.all(16),
                    child: _InfoRow(
                      icon: Icons.question_answer_outlined,
                      title: 'Асуулт',
                      subtitle: '30 асуулт',
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 700.ms)
                  .slideX(begin: -0.2, duration: 600.ms, delay: 700.ms),

              const Gap(12),

              AppCard(
                    padding: const EdgeInsets.all(16),
                    child: _InfoRow(
                      icon: Icons.insights_outlined,
                      title: 'Үр дүн',
                      subtitle: 'RIASEC код + тохирох мэргэжлүүд',
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 800.ms)
                  .slideX(begin: -0.2, duration: 600.ms, delay: 800.ms),

              const Spacer(),

              // CTA Button
              AppButton.primary(
                    'Тест эхлүүлэх',
                    expanded: true,
                    onPressed: () {
                      // Reset test state
                      ref.read(testAnswersProvider.notifier).reset();
                      ref.read(currentQuestionIndexProvider.notifier).state = 0;

                      // Navigate to question screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TestQuestionScreen(),
                        ),
                      );
                    },
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 1000.ms)
                  .slideY(begin: 0.3, duration: 600.ms, delay: 1000.ms),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Мэдээллийн мөр
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
