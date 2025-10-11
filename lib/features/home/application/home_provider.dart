// lib/features/home/application/home_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/career.dart';
import '../domain/entities/university.dart';
import '../domain/entities/advisor.dart';
import '../domain/entities/article.dart';
import '../data/mock_data.dart';

/// Нүүр хуудасны мэргэжлийн жагсаалт
final homeCareersProvider = Provider<List<Career>>((ref) {
  return mockCareers;
});

/// Нүүр хуудасны их сургуулийн жагсаалт
final homeUniversitiesProvider = Provider<List<University>>((ref) {
  return mockUniversities;
});

/// Нүүр хуудасны зөвлөхийн жагсаалт
final homeAdvisorsProvider = Provider<List<Advisor>>((ref) {
  return mockAdvisors;
});

/// Нүүр хуудасны нийтлэлийн жагсаалт
final homeArticlesProvider = Provider<List<Article>>((ref) {
  return mockArticles;
});

/// Trending tags
final trendingTagsProvider = Provider<List<String>>((ref) {
  return mockTrendingTags;
});

/// Сонгогдсон trending tag
final selectedTrendingTagProvider = StateProvider<String?>((ref) {
  return null;
});
