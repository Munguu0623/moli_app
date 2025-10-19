import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class CachedRoundImage extends StatelessWidget {
  final String url;
  final double size;
  final Widget? placeholder;

  const CachedRoundImage({
    super.key,
    required this.url,
    this.size = 48,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPlaceholder = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.chipBlue,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Icon(Icons.person, size: size * 0.5, color: AppColors.primary),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, __) => placeholder ?? defaultPlaceholder,
        errorWidget: (_, __, ___) => placeholder ?? defaultPlaceholder,
      ),
    );
  }
}
