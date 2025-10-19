// lib/features/occupations/application/occupations_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_occupations.dart';
import '../domain/entities/occupation.dart';

/// Бүх мэргэжлүүдийн жагсаалт provider
final occupationsProvider = Provider<List<Occupation>>((ref) {
  return mockOccupations;
});

/// Чиглэлээр шүүсэн мэргэжлүүдийн жагсаалт provider
final occupationsByCategoryProvider = Provider.family<List<Occupation>, String>(
  (ref, categoryId) {
    final allOccupations = ref.watch(occupationsProvider);
    return allOccupations.where((occ) => occ.categoryId == categoryId).toList();
  },
);

/// Тодорхой ID-тай мэргэжил provider
final occupationProvider = Provider.family<Occupation?, String>((
  ref,
  occupationId,
) {
  final allOccupations = ref.watch(occupationsProvider);
  try {
    return allOccupations.firstWhere((occ) => occ.id == occupationId);
  } catch (e) {
    return null;
  }
});

/// Хайлтын provider (нэрээр хайх)
final occupationSearchProvider = Provider.family<List<Occupation>, String>((
  ref,
  query,
) {
  if (query.isEmpty) return [];

  final allOccupations = ref.watch(occupationsProvider);
  final lowerQuery = query.toLowerCase();

  return allOccupations.where((occ) {
    return occ.name.toLowerCase().contains(lowerQuery) ||
        occ.summary.toLowerCase().contains(lowerQuery) ||
        occ.code.toLowerCase().contains(lowerQuery);
  }).toList();
});
