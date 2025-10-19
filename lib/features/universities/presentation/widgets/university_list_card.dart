// lib/features/universities/presentation/widgets/university_list_card.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/atoms/app_card.dart';
import '../../../../core/widgets/atoms/badges.dart';
import '../../../../core/widgets/atoms/cached_image.dart';
import '../../../../shared/design/design_system.dart';
import '../../domain/models/university.dart';

/// Жагсаалтын их сургуулийн card (full width)
class UniversityListCard extends StatelessWidget {
  final University university;
  final bool isBookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final VoidCallback? onCompare;

  const UniversityListCard({
    super.key,
    required this.university,
    this.isBookmarked = false,
    this.onTap,
    this.onBookmark,
    this.onCompare,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: ValueKey(university.id),
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
                  Row(
                    children: [
                      CachedRoundImage(
                        url: university.logoUrl,
                        size: 60,
                        placeholder: const Icon(
                          Icons.school,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    university.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (university.verified)
                                  const VerifiedBadge(size: 16),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 14,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  university.location,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        university.type == UniType.public
                                            ? AppColors.chipBlue
                                            : AppColors.chipOrange,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    university.typeLabel,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          university.type == UniType.public
                                              ? AppColors.primary
                                              : AppColors.accent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.monetization_on_outlined,
                        label: '${university.tuitionRange} / жил',
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: Icons.trending_up,
                        label: 'Оноо: ${university.avgEntryScore}',
                        color: AppColors.info,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.school_outlined,
                        label: '${university.totalPrograms} хөтөлбөр',
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            university.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      if (university.hasDormitory) ...[
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.home_outlined,
                          size: 16,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Байр',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.success,
                          ),
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
