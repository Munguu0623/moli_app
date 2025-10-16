// lib/features/tests/domain/entities/test.dart

/// Тестийн төрөл
class TestInfo {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int questionCount;
  final int durationMinutes;
  final bool isPremium;
  final bool isCompleted;
  final String? completedDate;

  const TestInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.questionCount,
    required this.durationMinutes,
    required this.isPremium,
    this.isCompleted = false,
    this.completedDate,
  });
}
