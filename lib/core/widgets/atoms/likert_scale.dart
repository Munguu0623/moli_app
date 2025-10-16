// lib/core/widgets/atoms/likert_scale.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

/// Likert Scale (1-5) widget with emoji
class LikertScale extends StatelessWidget {
  final int? selectedValue;
  final ValueChanged<int> onChanged;

  const LikertScale({super.key, this.selectedValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final value = index + 1;
        final isSelected = selectedValue == value;

        return GestureDetector(
          onTap: () => onChanged(value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: isSelected ? 72 : 64,
            height: isSelected ? 72 : 64,
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
              boxShadow:
                  isSelected
                      ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                      : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getEmoji(value),
                  style: TextStyle(fontSize: isSelected ? 32 : 28),
                ),
                const SizedBox(height: 4),
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color:
                        isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getEmoji(int value) {
    switch (value) {
      case 1:
        return '😐';
      case 2:
        return '🙂';
      case 3:
        return '😊';
      case 4:
        return '😃';
      case 5:
        return '🤩';
      default:
        return '😐';
    }
  }
}
