// lib/features/universities/application/bookmark_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Хадгалсан их сургуулиудын ID-ууд
final bookmarkedUniversitiesProvider =
    StateNotifierProvider<BookmarkNotifier, List<String>>((ref) {
      return BookmarkNotifier();
    });

class BookmarkNotifier extends StateNotifier<List<String>> {
  BookmarkNotifier() : super([]);

  /// Нэмэх
  void add(String universityId) {
    if (!state.contains(universityId)) {
      state = [...state, universityId];
    }
  }

  /// Хасах
  void remove(String universityId) {
    state = state.where((id) => id != universityId).toList();
  }

  /// Тогтоох
  void toggle(String universityId) {
    if (state.contains(universityId)) {
      remove(universityId);
    } else {
      add(universityId);
    }
  }

  /// Хадгалсан эсэх шалгах
  bool isBookmarked(String universityId) {
    return state.contains(universityId);
  }

  /// Бүгдийг арилгах
  void clear() {
    state = [];
  }
}

/// Guest эсэх (mock - хэрэглэгч нэвтэрсэн эсэх)
final isGuestProvider = StateProvider<bool>((ref) => true);
