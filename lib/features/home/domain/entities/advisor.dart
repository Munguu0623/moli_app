// lib/features/home/domain/entities/advisor.dart

/// Зөвлөхийн entity модель
class Advisor {
  final String id;
  final String name;
  final String title;
  final String imageUrl;
  final double rating;
  final String price;

  const Advisor({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.price,
  });
}
