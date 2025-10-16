// lib/features/tests/domain/entities/test_answer.dart

/// Тестийн хариулт (1-5 Likert scale)
class TestAnswer {
  final String questionId;
  final int value; // 1-5

  const TestAnswer({required this.questionId, required this.value});
}
