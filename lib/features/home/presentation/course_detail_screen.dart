// lib/features/home/presentation/course_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../shared/design/design_system.dart';
import '../domain/entities/course_bundle.dart';
import '../domain/entities/lesson.dart';

/// Хичээлийн багцын дэлгэрэнгүй хуудас
class CourseDetailScreen extends StatelessWidget {
  final CourseBundle course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Хичээлийн агуулга', showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero зураг
            AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    course.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.chipBlue,
                        child: const Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            size: 64,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0, duration: 400.ms),

            const Gap(20),

            // Гарчиг болон тайлбар
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 100.ms)
                      .slideX(
                        begin: -0.1,
                        end: 0,
                        duration: 400.ms,
                        delay: 100.ms,
                      ),
                  const Gap(8),
                  Text(
                        course.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 150.ms)
                      .slideX(
                        begin: -0.1,
                        end: 0,
                        duration: 400.ms,
                        delay: 150.ms,
                      ),
                  const Gap(16),
                  Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.chipBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.play_circle_outline,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${course.totalLessons} хичээл',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.access_time,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            course.totalDuration,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 200.ms)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        duration: 400.ms,
                        delay: 200.ms,
                      ),
                ],
              ),
            ),

            const Gap(24),

            // Хичээлүүдийн жагсаалт
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                        'Хичээлүүд',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 250.ms)
                      .slideX(
                        begin: -0.1,
                        end: 0,
                        duration: 400.ms,
                        delay: 250.ms,
                      ),
                  const Gap(12),
                  ...course.lessons.asMap().entries.map((entry) {
                    final index = entry.key;
                    final lesson = entry.value;
                    return _LessonItem(lesson: lesson, index: index);
                  }),
                ],
              ),
            ),

            const Gap(24),
          ],
        ),
      ),
    );
  }
}

/// Хичээлийн эдгээр бүлэг
class _LessonItem extends StatelessWidget {
  final Lesson lesson;
  final int index;

  const _LessonItem({required this.lesson, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(lesson.youtubeUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Видео нээх боломжгүй байна')),
            );
          }
        }
      },
      child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Lesson number badge
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.chipBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${lesson.order}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Lesson title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            lesson.duration,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Play icon
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
          )
          .animate()
          .fadeIn(duration: 400.ms, delay: (300 + index * 50).ms)
          .slideX(begin: 0.1, duration: 400.ms, delay: (300 + index * 50).ms),
    );
  }
}
