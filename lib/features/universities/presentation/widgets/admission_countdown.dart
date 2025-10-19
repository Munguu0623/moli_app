// lib/features/universities/presentation/widgets/admission_countdown.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/atoms/countdown_badge.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/admission_info.dart';

/// Элсэлтийн мэдээлэл + countdown
class AdmissionCountdown extends StatelessWidget {
  final AdmissionInfo admissionInfo;

  const AdmissionCountdown({super.key, required this.admissionInfo});

  @override
  Widget build(BuildContext context) {
    final daysRemaining = admissionInfo.daysRemaining;
    final isActive = admissionInfo.isActive;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient:
            isActive
                ? const LinearGradient(
                  colors: [Color(0xFFDCFCE7), Color(0xFFF0FDF4)],
                )
                : const LinearGradient(
                  colors: [Color(0xFFFEF3C7), Color(0xFFFEF9C3)],
                ),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: isActive ? AppColors.success : AppColors.accent,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isActive ? Icons.check_circle_outline : Icons.schedule,
                color: isActive ? AppColors.success : AppColors.accent,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isActive ? 'Элсэлт явагдаж байна' : 'Элсэлт удахгүй эхэлнэ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isActive ? AppColors.success : AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          if (isActive && daysRemaining > 0) ...[
            const SizedBox(height: 12),
            CountdownBadge(
              targetDate: admissionInfo.applyEndDate,
              format: CountdownFormat.full,
              icon: Icons.local_fire_department,
            ),
          ],
          if (!isActive) ...[
            const SizedBox(height: 8),
            Text(
              'Эхлэх: ${_formatDate(admissionInfo.applyStartDate)}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          _buildInfoRow('Эхлэх:', _formatDate(admissionInfo.applyStartDate)),
          const SizedBox(height: 6),
          _buildInfoRow('Дуусах:', _formatDate(admissionInfo.applyEndDate)),
          const SizedBox(height: 6),
          _buildInfoRow('Шаардлага:', admissionInfo.requirements),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}
