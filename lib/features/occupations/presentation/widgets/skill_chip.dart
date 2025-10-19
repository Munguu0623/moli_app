// lib/features/occupations/presentation/widgets/skill_chip.dart

import 'package:flutter/material.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/entities/skill.dart';

/// Ур чадварын chip widget
class SkillChip extends StatelessWidget {
  final Skill skill;
  final bool showLevel;

  const SkillChip({super.key, required this.skill, this.showLevel = true});

  /// Level-ээр өнгө сонгох
  Color _getLevelColor() {
    switch (skill.level) {
      case SkillLevel.beginner:
        return AppColors.info; // Цэнхэр
      case SkillLevel.intermediate:
        return AppColors.warning; // Улбар шар
      case SkillLevel.advanced:
        return AppColors.success; // Ногоон
    }
  }

  /// Level-ийн icon
  IconData? _getLevelIcon() {
    if (!showLevel) return null;
    switch (skill.level) {
      case SkillLevel.beginner:
        return Icons.circle;
      case SkillLevel.intermediate:
        return Icons.circle;
      case SkillLevel.advanced:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelColor = _getLevelColor();
    final levelIcon = _getLevelIcon();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: levelColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: levelColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (levelIcon != null) ...[
            Icon(levelIcon, size: 8, color: levelColor),
            const SizedBox(width: 6),
          ],
          Text(
            skill.name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: levelColor,
            ),
          ),
          if (showLevel) ...[
            const SizedBox(width: 4),
            Text(
              '•',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: levelColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              skill.levelLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: levelColor.withOpacity(0.8),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
