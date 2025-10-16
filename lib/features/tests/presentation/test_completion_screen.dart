// lib/features/tests/presentation/test_completion_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../../shared/design/design_system.dart';
import '../../../core/widgets/atoms/app_card.dart';
import 'test_result_screen.dart';

/// Тест дууссан үеийн хуудас (celebration screen)
class TestCompletionScreen extends ConsumerStatefulWidget {
  const TestCompletionScreen({super.key});

  @override
  ConsumerState<TestCompletionScreen> createState() =>
      _TestCompletionScreenState();
}

class _TestCompletionScreenState extends ConsumerState<TestCompletionScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate to result after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const TestResultScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: AppCard(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Confetti/Success animation
                  Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: AppGradients.brand,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 64,
                          color: Colors.white,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1.2, 1.2),
                        duration: 400.ms,
                      )
                      .then()
                      .scale(
                        begin: const Offset(1.2, 1.2),
                        end: const Offset(1, 1),
                        duration: 200.ms,
                      ),

                  const Gap(32),

                  // Completion message
                  Text(
                        '🎉 Амжилттай!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .slideY(begin: 0.3, duration: 600.ms, delay: 400.ms),

                  const Gap(16),

                  Text(
                        'Та бүх асуултад хариулж дууслаа.\nТаны үр дүнг бэлтгэж байна...',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 600.ms)
                      .slideY(begin: 0.2, duration: 600.ms, delay: 600.ms),

                  const Gap(40),

                  // Loading indicator
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 800.ms),

                  const Gap(16),

                  Text(
                    'Таны RIASEC кодыг тооцоолж байна',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
