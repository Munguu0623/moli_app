// lib/features/profile/presentation/widgets/premium_badge.dart

import 'package:flutter/material.dart';
import '../../../../shared/design/design_system.dart';

/// Premium badge widget
class PremiumBadge extends StatelessWidget {
  final bool isPremium;
  final bool showIcon;

  const PremiumBadge({
    super.key,
    required this.isPremium,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPremium) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.textTertiary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Free',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: AppGradients.brand,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            const Text('💎', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
          ],
          const Text(
            'Premium',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
