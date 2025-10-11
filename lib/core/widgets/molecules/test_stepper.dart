import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';
import '../atoms/app_progress.dart';
import '../atoms/app_button.dart';

class TestStepper extends StatelessWidget {
  final int index; // одоогийн асуулт (1-ээс)
  final int total; // нийт асуулт
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final Widget question; // асуултын виджет (Likert г.м)

  const TestStepper({
    super.key,
    required this.index,
    required this.total,
    required this.onPrev,
    required this.onNext,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final p = index / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Асуулт $index / $total',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Text(
              '${(p * 100).round()}%',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AppProgressBar(value: p),
        const SizedBox(height: 16),
        question,
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppButton.secondary(
                'Буцах',
                onPressed: onPrev,
                expanded: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.primary(
                'Дараах',
                onPressed: onNext,
                expanded: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
