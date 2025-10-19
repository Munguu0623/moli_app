// lib/features/home/domain/entities/course_bundle.dart
import 'lesson.dart';

/// Хичээлийн багц (Udemy style)
class CourseBundle {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String totalDuration; // "2 цаг 30 мин"
  final int totalLessons;
  final List<Lesson> lessons;

  const CourseBundle({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.totalDuration,
    required this.totalLessons,
    required this.lessons,
  });
}
