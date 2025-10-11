// lib/ui/organisms/advisor_card.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';
import '../atoms/app_card.dart';
import '../atoms/badges.dart';
import '../atoms/rating_stars.dart';

class AdvisorCard extends StatelessWidget {
  final String name;
  final String title;
  final String imageUrl;
  final double rating;
  final String price;
  final bool locked;

  const AdvisorCard({
    super.key,
    required this.name,
    required this.title,
    required this.imageUrl,
    this.rating = 4.8,
    this.price = '10,000₮',
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 220,
        child: AppCard(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.chipBlue,
                    child: ClipOval(
                      child: Image.network(
                        imageUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 32,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const VerifiedBadge(),
                  const Spacer(),
                  if (locked) const Icon(Icons.lock, size: 18),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  RatingStars(rating: rating),
                  const Spacer(),
                  Text(
                    price,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
