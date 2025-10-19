// lib/features/universities/presentation/widgets/program_card.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/atoms/app_card.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/program.dart';

/// Хөтөлбөрийн card
class ProgramCard extends StatelessWidget {
  final Program program;
  final VoidCallback? onTap;

  const ProgramCard({super.key, required this.program, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: ValueKey(program.id),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.cardCompact),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          program.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppGradients.brand,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          program.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoItem(
                        icon: Icons.schedule,
                        label: program.duration,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoItem(
                        icon: Icons.language,
                        label: program.language,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoItem(
                        icon: Icons.trending_up,
                        label: 'Оноо: ${program.entryScore}',
                        color: AppColors.info,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoItem(
                        icon: Icons.monetization_on_outlined,
                        label: program.tuitionPerYear,
                        color: AppColors.success,
                      ),
                    ],
                  ),
                  if (program.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      program.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    Color? color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color ?? AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color ?? AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
