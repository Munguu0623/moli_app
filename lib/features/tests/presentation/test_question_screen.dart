// lib/features/tests/presentation/test_question_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/atoms/likert_scale.dart';
import '../../../core/widgets/atoms/app_button.dart';
import '../../../core/widgets/atoms/app_progress.dart';
import '../application/test_provider.dart';
import 'test_completion_screen.dart';

/// Тестийн асуултын хуудас
class TestQuestionScreen extends ConsumerWidget {
  const TestQuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(testQuestionsProvider);
    final currentIndex = ref.watch(currentQuestionIndexProvider);
    final answers = ref.watch(testAnswersProvider);
    final progress = ref.watch(testProgressProvider);

    final currentQuestion = questions[currentIndex];
    final selectedValue = answers[currentQuestion.id];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showExitDialog(context, ref);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _showExitDialog(context, ref),
          ),
          title: Text(
            'Асуулт ${currentQuestion.number} / ${questions.length}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppProgressBar(value: progress),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(40),

                    // Question number badge
                    Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppGradients.brand,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            'Асуулт ${currentQuestion.number}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: -0.2, duration: 400.ms),

                    const Gap(24),

                    // Question text
                    Text(
                          currentQuestion.text,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 100.ms)
                        .slideY(begin: 0.1, duration: 600.ms, delay: 100.ms),

                    const Gap(48),

                    // Likert scale
                    LikertScale(
                          selectedValue: selectedValue,
                          onChanged: (value) {
                            ref
                                .read(testAnswersProvider.notifier)
                                .saveAnswer(currentQuestion.id, value);
                          },
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          duration: 600.ms,
                          delay: 200.ms,
                        ),

                    const Gap(24),

                    // Scale labels
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Огт тохирохгүй',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'Маш их тохирно',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  ],
                ),
              ),
            ),

            // Bottom buttons
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  16 + MediaQuery.of(context).padding.bottom,
                ),
                child: Row(
                  children: [
                    // Previous button
                    Expanded(
                      child: AppButton.secondary(
                        'Буцах',
                        expanded: true,
                        onPressed:
                            currentIndex > 0
                                ? () {
                                  ref
                                      .read(
                                        currentQuestionIndexProvider.notifier,
                                      )
                                      .state = currentIndex - 1;
                                }
                                : null,
                      ),
                    ),
                    const Gap(12),

                    // Next button
                    Expanded(
                      child:
                          selectedValue == null
                              ? AppButton.secondary(
                                currentIndex == questions.length - 1
                                    ? 'Дуусгах'
                                    : 'Дараагийнх',
                                expanded: true,
                                onPressed: null,
                              )
                              : AppButton.primary(
                                currentIndex == questions.length - 1
                                    ? 'Дуусгах'
                                    : 'Дараагийнх',
                                expanded: true,
                                onPressed: () => _handleNext(context, ref),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNext(BuildContext context, WidgetRef ref) {
    final questions = ref.read(testQuestionsProvider);
    final currentIndex = ref.read(currentQuestionIndexProvider);

    // Mid-point encouragement (after Q15)
    if (currentIndex == 14) {
      _showEncouragementDialog(context, ref);
      return;
    }

    // Last question - go to completion
    if (currentIndex == questions.length - 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const TestCompletionScreen()),
      );
      return;
    }

    // Next question
    ref.read(currentQuestionIndexProvider.notifier).state = currentIndex + 1;
  }

  void _showEncouragementDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppGradients.brand,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.celebration,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const Gap(24),
                const Text(
                  '👏 Сайн байна!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Gap(12),
                const Text(
                  'Та тал хувьд нь ирлээ! Үргэлжлүүлээд үзээрэй.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const Gap(24),
                AppButton.primary(
                  'Үргэлжлүүлэх',
                  expanded: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                    ref.read(currentQuestionIndexProvider.notifier).state =
                        ref.read(currentQuestionIndexProvider) + 1;
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showExitDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Тестээс гарах уу?'),
            content: const Text(
              'Таны хариултууд хадгалагдана. Дараа үргэлжлүүлж болно.',
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: AppButton.ghost(
                      'Цуцлах',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: AppButton.primary(
                      'Гарах',
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.of(context).pop(); // Go back
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
