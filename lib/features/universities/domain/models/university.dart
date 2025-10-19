// lib/features/universities/domain/models/university.dart

enum UniType { public, private }

/// Их сургуулийн entity модель
class University {
  final String id;
  final String name;
  final String logoUrl;
  final String location;
  final UniType type;
  final int foundedYear;
  final String website;
  final bool verified;
  final double rating; // 0.0 - 5.0
  final int totalPrograms;
  final String tuitionRange; // "4.5M - 6.2M₮"
  final int avgEntryScore; // 400 - 800
  final bool hasDormitory;
  final String description;
  final String? campusImageUrl;

  const University({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.location,
    required this.type,
    required this.foundedYear,
    required this.website,
    required this.verified,
    required this.rating,
    required this.totalPrograms,
    required this.tuitionRange,
    required this.avgEntryScore,
    required this.hasDormitory,
    required this.description,
    this.campusImageUrl,
  });

  String get typeLabel => type == UniType.public ? 'Төрийн' : 'Хувийн';
}
