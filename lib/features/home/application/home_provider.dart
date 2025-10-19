// lib/features/home/application/home_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/career.dart';
import '../domain/entities/university.dart';
import '../domain/entities/article.dart';
import '../domain/entities/course_bundle.dart';
import '../domain/entities/trending_tag.dart';
import '../data/mock_data.dart';

/// Нүүр хуудасны мэргэжлийн жагсаалт
final homeCareersProvider = Provider<List<Career>>((ref) {
  return mockCareers;
});

/// Нүүр хуудасны их сургуулийн жагсаалт
final homeUniversitiesProvider = Provider<List<University>>((ref) {
  return mockUniversities;
});

/// Нүүр хуудасны хичээлийн багцууд
final homeCourseBundlesProvider = Provider<List<CourseBundle>>((ref) {
  return mockCourseBundles;
});

/// Нүүр хуудасны нийтлэлийн жагсаалт
final homeArticlesProvider = Provider<List<Article>>((ref) {
  return mockArticles;
});

/// Trending tags - эрэлт хэрэгцээний мэдээлэлтэй
final trendingTagsProvider = Provider<List<TrendingTag>>((ref) {
  return mockTrendingTags;
});

/// Сонгогдсон trending tag
final selectedTrendingTagProvider = StateProvider<TrendingTag?>((ref) {
  return null;
});
