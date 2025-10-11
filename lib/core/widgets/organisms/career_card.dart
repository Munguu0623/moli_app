// lib/ui/organisms/career_card.dart
import 'package:flutter/material.dart';
import '../../../shared/design/design_system.dart';
import '../atoms/app_card.dart';
import '../atoms/bookmark_button.dart';

class CareerCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String summary;
  final String outlook; // 📈/⚖️/⬇️ гэх мэт
  final String salary;
  final bool isTrending; // "Эрэлттэй" badge
  final bool isNew; // "Шинэ" badge
  final bool isSaved;
  final VoidCallback? onSave;

  const CareerCard({
    super.key,
    required this.icon,
    required this.title,
    required this.summary,
    required this.outlook,
    required this.salary,
    this.isTrending = false,
    this.isNew = false,
    this.isSaved = false,
    this.onSave,
  });

  // Badge өнгө
  Color _getBadgeColor() {
    if (isTrending) return AppColors.chipOrange;
    if (isNew) return AppColors.chipBlue;
    return AppColors.chipBlue;
  }

  Color _getBadgeTextColor() {
    if (isTrending) return const Color(0xFFEA580C);
    if (isNew) return AppColors.primary;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 250,
        child: AppCard(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Icon + Badge + Bookmark
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Simple Icon Container
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.chipBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, size: 22, color: AppColors.primary),
                  ),
                  const SizedBox(width: 6),
                  // Badge
                  if (isTrending || isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _getBadgeColor(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isTrending ? '🔥 Эрэлттэй' : '✨ Шинэ',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: _getBadgeTextColor(),
                        ),
                      ),
                    ),
                  const Spacer(),
                  // Bookmark
                  BookmarkButton(
                    initial: isSaved,
                    onChanged: onSave != null ? (_) => onSave!() : null,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Summary
              Text(
                summary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              // Outlook + Salary
              Row(
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.chipGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${outlook} ${outlook.contains('📈')
                            ? 'Өсөлттэй'
                            : outlook.contains('⬇️')
                            ? 'Буурч'
                            : 'Тогтвор'}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '💰 $salary',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
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
