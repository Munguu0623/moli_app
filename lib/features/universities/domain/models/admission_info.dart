// lib/features/universities/domain/models/admission_info.dart

/// Элсэлтийн мэдээлэл
class AdmissionInfo {
  final String universityId;
  final DateTime applyStartDate; // Бүртгэл эхлэх
  final DateTime applyEndDate; // Бүртгэл дуусах
  final String requirements; // Шаардлага (ЭЕШ оноо гэх мэт)
  final String applyLink; // Онлайн бүртгэлийн холбоос
  final List<String> requiredDocuments; // Шаардлагатай баримт бичиг

  const AdmissionInfo({
    required this.universityId,
    required this.applyStartDate,
    required this.applyEndDate,
    required this.requirements,
    required this.applyLink,
    required this.requiredDocuments,
  });

  /// Дуусах хугацаа хэдэн өдөр үлдсэн
  int get daysRemaining {
    final now = DateTime.now();
    if (now.isAfter(applyEndDate)) return 0;
    return applyEndDate.difference(now).inDays;
  }

  /// Элсэлт явагдаж байгаа эсэх
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(applyStartDate) && now.isBefore(applyEndDate);
  }
}
