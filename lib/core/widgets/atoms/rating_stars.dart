// lib/ui/atoms/rating_stars.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class RatingStars extends StatelessWidget {
  final double rating; // 0..5
  final int count;
  const RatingStars({super.key, required this.rating, this.count = 5});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final filled = i + 1 <= rating.round();
        return Icon(
          Icons.star_rounded,
          size: 16,
          color: filled ? AppColors.accent : AppColors.textTertiary,
        );
      }),
    );
  }
}
