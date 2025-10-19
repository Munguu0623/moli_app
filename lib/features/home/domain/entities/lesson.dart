// lib/features/home/domain/entities/lesson.dart

/// Нэг хичээл (багцын доторх)
class Lesson {
  final String id;
  final String title;
  final String duration; // "12:34" форматтай
  final String youtubeUrl;
  final int order; // Хичээлийн дараалал

  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.youtubeUrl,
    required this.order,
  });
}
