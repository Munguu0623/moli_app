// lib/features/advisors/presentation/widgets/review_card.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/atoms/app_card.dart';
import '../../../../core/widgets/atoms/rating_stars.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/chat_message.dart';

/// Үнэлгээний карт
class ReviewCard extends StatelessWidget {
  final AdvisorReview review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.chipBlue,
                child:
                    review.studentAvatarUrl != null
                        ? ClipOval(
                          child: Image.network(
                            review.studentAvatarUrl!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 20,
                                color: AppColors.primary,
                              );
                            },
                          ),
                        )
                        : const Icon(
                          Icons.person,
                          size: 20,
                          color: AppColors.primary,
                        ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.studentName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review.dateLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              RatingStars(rating: review.rating.toDouble(), size: 14),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
