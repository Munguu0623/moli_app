// lib/ui/organisms/university_card.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';
import '../atoms/app_card.dart';
import '../atoms/badges.dart';
import '../atoms/cached_image.dart';

class UniversityCard extends StatelessWidget {
  final String logoUrl;
  final String name;
  final String location;
  final String tuition;
  final int programs;
  final bool verified;
  final int? entryScore;
  final bool isBookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;

  const UniversityCard({
    super.key,
    required this.logoUrl,
    required this.name,
    required this.location,
    required this.tuition,
    required this.programs,
    this.verified = true,
    this.entryScore,
    this.isBookmarked = false,
    this.onTap,
    this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 280,
        child: AppCard(
          padding: EdgeInsets.zero,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadius.cardCompact),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    CachedRoundImage(
                      url: logoUrl,
                      size: 56,
                      placeholder: const Icon(
                        Icons.school,
                        size: 32,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (verified) const VerifiedBadge(size: 14),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$location • $tuition / жил',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                'Хөтөлбөр: $programs',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                              if (entryScore != null) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.chipBlue,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '📈 $entryScore',
                                    style: const TextStyle(
                                      fontSize: 11,
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
                    ),
                    if (onBookmark != null)
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color:
                              isBookmarked
                                  ? AppColors.accent
                                  : AppColors.textTertiary,
                          size: 20,
                        ),
                        onPressed: onBookmark,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
