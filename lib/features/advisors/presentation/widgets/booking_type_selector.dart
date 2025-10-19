// lib/features/advisors/presentation/widgets/booking_type_selector.dart

import 'package:flutter/material.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/advisor.dart';

/// Зөвлөгөөний төрөл сонгох
class BookingTypeSelector extends StatelessWidget {
  final ConsultationType selected;
  final ValueChanged<ConsultationType> onChanged;
  final int chatPrice;
  final int videoPrice;

  const BookingTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.chatPrice,
    required this.videoPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Зөвлөгөөний төрөл',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTypeOption(
                context,
                ConsultationType.chat,
                Icons.chat_bubble_outline_rounded,
                'Чат',
                chatPrice,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTypeOption(
                context,
                ConsultationType.video,
                Icons.videocam_outlined,
                'Видео',
                videoPrice,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeOption(
    BuildContext context,
    ConsultationType type,
    IconData icon,
    String label,
    int price,
  ) {
    final isSelected = selected == type;

    return InkWell(
      onTap: () => onChanged(type),
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chipPurple : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? AppShadows.card : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price == 0 ? 'Үнэгүй' : '${_formatPrice(price)}₮',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(price % 1000 == 0 ? 0 : 1)}k';
    }
    return price.toString();
  }
}
