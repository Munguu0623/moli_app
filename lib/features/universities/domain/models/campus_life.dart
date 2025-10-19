// lib/features/universities/domain/models/campus_life.dart

/// Оюутны амьдралын мэдээлэл
class CampusLife {
  final String universityId;
  final List<String> clubs; // Клубууд
  final List<String> internships; // Дадлагын байгууллагууд
  final String facilities; // Байгууламж (сан, спорт зааал гэх мэт)
  final List<String> campusImages; // Кампусын зургууд
  final String studentActivities; // Оюутны үйл ажиллагаа

  const CampusLife({
    required this.universityId,
    required this.clubs,
    required this.internships,
    required this.facilities,
    required this.campusImages,
    required this.studentActivities,
  });
}
