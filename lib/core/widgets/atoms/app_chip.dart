// lib/ui/atoms/app_chip.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class AppChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const AppChip(this.label, {super.key, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.primary : AppColors.chipBlue;
    final fg = selected ? Colors.white : AppColors.textPrimary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
        child: Text(
          label,
          style: TextStyle(color: fg, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
