import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

/// Generic cached image widget with shape support
class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxShape shape;
  final Widget? errorWidget;
  final BoxFit? fit;

  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.shape = BoxShape.rectangle,
    this.errorWidget,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final defaultError = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: AppColors.chipBlue, shape: shape),
      child:
          errorWidget ??
          Icon(Icons.person, size: width * 0.5, color: AppColors.primary),
    );

    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      placeholder: (_, __) => defaultError,
      errorWidget: (_, __, ___) => defaultError,
    );

    if (shape == BoxShape.circle) {
      image = ClipOval(child: image);
    }

    return image;
  }
}

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
