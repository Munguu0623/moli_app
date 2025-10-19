// lib/features/universities/application/compare_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/university.dart';

/// Харьцуулах сагс (2-3 их сургууль)
final compareCartProvider =
    StateNotifierProvider<CompareCartNotifier, List<University>>((ref) {
      return CompareCartNotifier();
    });

class CompareCartNotifier extends StateNotifier<List<University>> {
  CompareCartNotifier() : super([]);

  /// Нэмэх (max 3)
  void add(University university) {
    if (state.length >= 3) {
      // Хэрэв 3 байвал эхнийг арилгаад шинийг нэм
      state = [...state.sublist(1), university];
    } else {
      if (!state.any((u) => u.id == university.id)) {
        state = [...state, university];
      }
    }
  }

  /// Хасах
  void remove(String universityId) {
    state = state.where((u) => u.id != universityId).toList();
  }

  /// Тогтоох (contains check)
  void toggle(University university) {
    if (state.any((u) => u.id == university.id)) {
      remove(university.id);
    } else {
      add(university);
    }
  }

  /// Бүгдийг арилгах
  void clear() {
    state = [];
  }

  /// Тухайн их сургууль сагсанд байгаа эсэх
  bool contains(String universityId) {
    return state.any((u) => u.id == universityId);
  }
}

/// Харьцуулах сагсны тоо
final compareCartCountProvider = Provider<int>((ref) {
  return ref.watch(compareCartProvider).length;
});
