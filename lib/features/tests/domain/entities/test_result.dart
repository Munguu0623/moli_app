// lib/features/tests/domain/entities/test_result.dart

/// RIASEC тестийн үр дүн
class TestResult {
  final String code; // Жишээ: "SEC"
  final Map<String, int> scores; // {"S": 25, "E": 22, "C": 20, ...}
  final List<String> traits; // Гол шинж чанарууд
  final List<String> recommendedCareerIds; // Тохирох мэргэжлүүдийн ID

  const TestResult({
    required this.code,
    required this.scores,
    required this.traits,
    required this.recommendedCareerIds,
  });

  /// Хамгийн өндөр оноотой 3 категорийг авах
  static String calculateCode(Map<String, int> scores) {
    final sorted =
        scores.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).map((e) => e.key).join();
  }
}
