// lib/ui/atoms/badges.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key, this.size = 16});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(.12), // ✅ Blue
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.info), // ✅ Blue border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            color: AppColors.info,
            size: size,
          ), // ✅ Blue icon
          const SizedBox(width: 4),
          Text(
            'Verified',
            style: TextStyle(
              color: AppColors.info, // ✅ Blue text
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class LockBadge extends StatelessWidget {
  const LockBadge({super.key});
  @override
  Widget build(BuildContext context) =>
      Icon(Icons.lock, size: 18, color: AppColors.textTertiary);
}

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: AppColors.accent.withOpacity(.15),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.stars, size: 16, color: AppColors.accent),
        SizedBox(width: 4),
        Text(
          'Premium',
          style: TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
