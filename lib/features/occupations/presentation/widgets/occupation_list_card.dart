// lib/features/occupations/presentation/widgets/occupation_list_card.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/atoms/app_card.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/entities/occupation.dart';

/// Мэргэжлийн жагсаалтын карт (full width)
class OccupationListCard extends StatelessWidget {
  final Occupation occupation;
  final bool isBookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final VoidCallback? onCompare;

  const OccupationListCard({
    super.key,
    required this.occupation,
    this.isBookmarked = false,
    this.onTap,
    this.onBookmark,
    this.onCompare,
  });

  /// Outlook-ын өнгө
  Color _getOutlookColor() {
    switch (occupation.demandOutlook) {
      case DemandOutlook.growing:
        return AppColors.success;
      case DemandOutlook.stable:
        return AppColors.info;
      case DemandOutlook.declining:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final outlookColor = _getOutlookColor();

    return RepaintBoundary(
      key: ValueKey(occupation.id),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.cardCompact),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      // Icon/Image placeholder
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: AppGradients.brand,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.work_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Title + code
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              occupation.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              occupation.code,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Bookmark button
                      if (onBookmark != null)
                        IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color:
                                isBookmarked
                                    ? AppColors.accent
                                    : AppColors.textTertiary,
                            size: 24,
                          ),
                          onPressed: onBookmark,
                        ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Summary
                  Text(
                    occupation.summary,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Info chips row
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.monetization_on_outlined,
                        label: occupation.salaryRange.formattedMedian,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: Icons.trending_up,
                        label: occupation.outlookLabel,
                        color: outlookColor,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Second info row
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.school_outlined,
                        label: '${occupation.relatedProgramsCount} хөтөлбөр',
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      if (occupation.rating != null) ...[
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              occupation.rating!.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const Spacer(),
                      if (onCompare != null)
                        TextButton.icon(
                          onPressed: onCompare,
                          icon: const Icon(Icons.compare_arrows, size: 18),
                          label: const Text('Харьцуулах'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
