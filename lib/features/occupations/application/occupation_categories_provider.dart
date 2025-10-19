// lib/features/occupations/application/occupation_categories_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_occupations.dart';
import '../domain/entities/occupation_category.dart';

/// Мэргэжлийн чиглэлүүдийн жагсаалт provider
final occupationCategoriesProvider = Provider<List<OccupationCategory>>((ref) {
  return mockOccupationCategories;
});

/// Тодорхой ID-тай чиглэл provider
final occupationCategoryProvider = Provider.family<OccupationCategory?, String>(
  (ref, categoryId) {
    final categories = ref.watch(occupationCategoriesProvider);
    try {
      return categories.firstWhere((cat) => cat.id == categoryId);
    } catch (e) {
      return null;
    }
  },
);
