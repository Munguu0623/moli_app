import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../design_system.dart';

class CachedRoundImage extends StatelessWidget {
  final String url;
  final double size;
  const CachedRoundImage({super.key, required this.url, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder:
            (_, __) => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.chipBlue,
                borderRadius: BorderRadius.circular(size / 2),
              ),
              child: Icon(
                Icons.person,
                size: size * 0.5,
                color: AppColors.primary,
              ),
            ),
        errorWidget:
            (_, __, ___) => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.chipBlue,
                borderRadius: BorderRadius.circular(size / 2),
              ),
              child: Icon(
                Icons.person,
                size: size * 0.5,
                color: AppColors.primary,
              ),
            ),
      ),
    );
  }
}
