// lib/features/home/domain/entities/university.dart

/// Их сургуулийн entity модель
class University {
  final String id;
  final String name;
  final String logoUrl;
  final String location;
  final String tuition;
  final int programs;

  const University({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.location,
    required this.tuition,
    required this.programs,
  });
}

