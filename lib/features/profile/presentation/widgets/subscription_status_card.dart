// lib/features/profile/presentation/widgets/subscription_status_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/user.dart';

/// Subscription status харуулах card
class SubscriptionStatusCard extends StatelessWidget {
  final User user;

  const SubscriptionStatusCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: user.isPremium ? AppGradients.brand : null,
        color: user.isPremium ? null : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                user.isPremium
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                user.isPremium ? '💎' : '🆓',
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.subscriptionTier.label,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:
                            user.isPremium
                                ? Colors.white
                                : AppColors.textPrimary,
                      ),
                    ),
                    if (user.isPremium &&
                        user.subscriptionExpiryDate != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Дуусах: ${DateFormat('yyyy.MM.dd').format(user.subscriptionExpiryDate!)}',
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              user.isPremium
                                  ? Colors.white.withOpacity(0.9)
                                  : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Auto renewal status
          if (user.isPremium) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    user.autoRenewal ? Icons.check_circle : Icons.info_outline,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    user.autoRenewal
                        ? 'Автоматаар сунгах идэвхтэй'
                        : 'Автоматаар сунгах идэвхгүй',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Free tier message
          if (!user.isPremium) ...[
            const SizedBox(height: 12),
            const Text(
              'Premium болж бүх боломжуудыг ашиглаарай',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }
}
