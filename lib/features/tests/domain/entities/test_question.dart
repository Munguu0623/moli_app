// lib/features/tests/domain/entities/test_question.dart

/// RIASEC тестийн асуулт
class TestQuestion {
  final String id;
  final int number; // 1-30
  final String text;
  final String category; // R, I, A, S, E, C

  const TestQuestion({
    required this.id,
    required this.number,
    required this.text,
    required this.category,
  });
}
