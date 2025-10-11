import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';

class PriceTag extends StatelessWidget {
  final int price;
  final String? duration;
  final int? oldPrice;
  final int? discountPercentage;
  final IconData? icon;
  final Color? backgroundColor;
  final bool isLarge;

  const PriceTag({
    super.key,
    required this.price,
    this.duration,
    this.oldPrice,
    this.discountPercentage,
    this.icon,
    this.backgroundColor,
    this.isLarge = false,
  });

  String _formatPrice(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasDiscount = oldPrice != null && discountPercentage != null;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 16 : 12,
        vertical: isLarge ? 12 : 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: isLarge ? 20 : 16, color: AppColors.primary),
            SizedBox(width: isLarge ? 8 : 6),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasDiscount) ...[
                Row(
                  children: [
                    Text(
                      '${_formatPrice(oldPrice!)}₮',
                      style: TextStyle(
                        fontSize: isLarge ? 13 : 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textTertiary,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.textTertiary,
                        decorationThickness: 2,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-$discountPercentage%',
                        style: TextStyle(
                          fontSize: isLarge ? 11 : 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
              ],
              Row(
                children: [
                  Text(
                    '${_formatPrice(price)}₮',
                    style: TextStyle(
                      fontSize: isLarge ? 20 : 16,
                      fontWeight: FontWeight.w700,
                      color: hasDiscount ? AppColors.error : AppColors.primary,
                      height: 1,
                    ),
                  ),
                  if (duration != null) ...[
                    SizedBox(width: isLarge ? 8 : 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.chipBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        duration!,
                        style: TextStyle(
                          fontSize: isLarge ? 12 : 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
