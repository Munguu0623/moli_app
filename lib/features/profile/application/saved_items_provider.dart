// lib/features/profile/application/saved_items_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../features/universities/application/bookmark_provider.dart';
import '../../../features/universities/data/mock_universities.dart';
import '../../../features/universities/domain/models/university.dart';
import '../../../features/occupations/data/mock_occupations.dart';
import '../../../features/occupations/domain/entities/occupation.dart';

/// Хадгалсан их сургуулиуд (бодит өгөгдөл)
final savedUniversitiesProvider = Provider<List<University>>((ref) {
  final bookmarkedIds = ref.watch(bookmarkedUniversitiesProvider);
  return mockUniversities.where((u) => bookmarkedIds.contains(u.id)).toList();
});

/// Хадгалсан мэргэжлүүдийн ID (mock)
final bookmarkedOccupationsProvider =
    StateNotifierProvider<BookmarkedOccupationsNotifier, List<String>>((ref) {
      return BookmarkedOccupationsNotifier();
    });

class BookmarkedOccupationsNotifier extends StateNotifier<List<String>> {
  BookmarkedOccupationsNotifier() : super([]);

  void toggle(String occupationId) {
    if (state.contains(occupationId)) {
      state = state.where((id) => id != occupationId).toList();
    } else {
      state = [...state, occupationId];
    }
  }

  void add(String occupationId) {
    if (!state.contains(occupationId)) {
      state = [...state, occupationId];
    }
  }

  void remove(String occupationId) {
    state = state.where((id) => id != occupationId).toList();
  }

  bool isBookmarked(String occupationId) {
    return state.contains(occupationId);
  }
}

/// Хадгалсан мэргэжлүүд (бодит өгөгдөл)
final savedOccupationsProvider = Provider<List<Occupation>>((ref) {
  final bookmarkedIds = ref.watch(bookmarkedOccupationsProvider);
  return mockOccupations.where((o) => bookmarkedIds.contains(o.id)).toList();
});

/// Хадгалсан нийтлэлүүдийн ID (mock)
final bookmarkedArticlesProvider =
    StateNotifierProvider<BookmarkedArticlesNotifier, List<String>>((ref) {
      return BookmarkedArticlesNotifier();
    });

class BookmarkedArticlesNotifier extends StateNotifier<List<String>> {
  BookmarkedArticlesNotifier() : super([]);

  void toggle(String articleId) {
    if (state.contains(articleId)) {
      state = state.where((id) => id != articleId).toList();
    } else {
      state = [...state, articleId];
    }
  }

  void add(String articleId) {
    if (!state.contains(articleId)) {
      state = [...state, articleId];
    }
  }

  void remove(String articleId) {
    state = state.where((id) => id != articleId).toList();
  }

  bool isBookmarked(String articleId) {
    return state.contains(articleId);
  }
}

/// Хадгалсан нийтлэлүүд (mock өгөгдөл - блог feature хараахан бүрэн хийгдээгүй)
final savedArticlesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final bookmarkedIds = ref.watch(bookmarkedArticlesProvider);
  // Mock articles
  final mockArticles = [
    {
      'id': 'article_1',
      'title': 'Software Engineer болохын тулд юу судлах вэ?',
      'excerpt': 'Програм хангамжийн инженер болох замнал...',
      'imageUrl': null,
    },
    {
      'id': 'article_2',
      'title': 'Их сургуулийн элсэлтийн шалгалтад бэлдэх',
      'excerpt': 'ЭЕШ-д амжилттай бэлдэх аргууд...',
      'imageUrl': null,
    },
  ];
  return mockArticles
      .where((a) => bookmarkedIds.contains(a['id'] as String))
      .toList();
});

/// Нийт хадгалсан зүйлсийн тоо
final totalSavedItemsCountProvider = Provider<int>((ref) {
  final universities = ref.watch(savedUniversitiesProvider).length;
  final occupations = ref.watch(savedOccupationsProvider).length;
  final articles = ref.watch(savedArticlesProvider).length;
  return universities + occupations + articles;
});
