// lib/features/universities/domain/models/program.dart

/// Хөтөлбөрийн модель
class Program {
  final String id;
  final String universityId;
  final String name;
  final String category; // IT, Бизнес, Эрүүл мэнд гэх мэт
  final String duration; // "4 жил"
  final String language; // "Монгол", "Англи"
  final int entryScore; // 400-800
  final String tuitionPerYear; // "5,200,000₮"
  final String description;
  final List<String> mainSubjects; // Гол хичээлүүд
  final List<String> relatedCareerIds; // Холбогдох мэргэжлүүд

  const Program({
    required this.id,
    required this.universityId,
    required this.name,
    required this.category,
    required this.duration,
    required this.language,
    required this.entryScore,
    required this.tuitionPerYear,
    required this.description,
    required this.mainSubjects,
    required this.relatedCareerIds,
  });
}
