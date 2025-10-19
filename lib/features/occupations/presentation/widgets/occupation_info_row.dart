// lib/features/occupations/presentation/widgets/occupation_info_row.dart

import 'package:flutter/material.dart';
import '../../../../shared/design/design_system.dart';

/// Мэргэжлийн дэлгэрэнгүй мэдээллийн мөр
class OccupationInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const OccupationInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: effectiveColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppRadius.cardCompact),
        border: Border.all(color: effectiveColor.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: effectiveColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: effectiveColor, size: 22),
          ),

          const SizedBox(width: 12),

          // Label + Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: effectiveColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
