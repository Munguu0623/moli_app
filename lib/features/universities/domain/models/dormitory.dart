// lib/features/universities/domain/models/dormitory.dart

/// Дотуур байрны мэдээлэл
class Dormitory {
  final String universityId;
  final String name; // "Оюутны байр №5"
  final String pricePerMonth; // "150,000₮"
  final String roomType; // "2 ортой өрөө"
  final List<String> facilities; // ["Wi-Fi", "Угаалтуур", "Нойлын өрөө"]
  final bool available; // Чөлөөт байр байгаа эсэх
  final String? imageUrl;

  const Dormitory({
    required this.universityId,
    required this.name,
    required this.pricePerMonth,
    required this.roomType,
    required this.facilities,
    required this.available,
    this.imageUrl,
  });
}
