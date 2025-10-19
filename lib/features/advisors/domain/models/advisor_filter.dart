// lib/features/advisors/domain/models/advisor_filter.dart

import 'package:flutter/material.dart';
import 'advisor.dart';

/// Зөвлөхүүдийн шүүлтүүр
class AdvisorFilter {
  final String keyword;
  final List<AdvisorExpertise> expertise;
  final RangeValues priceRange; // 0 - 20,000
  final List<String> languages;
  final bool availableToday;

  const AdvisorFilter({
    this.keyword = '',
    this.expertise = const [],
    this.priceRange = const RangeValues(0, 20000),
    this.languages = const [],
    this.availableToday = false,
  });

  /// Шүүлтүүр хоосон эсэх
  bool get isEmpty =>
      keyword.isEmpty &&
      expertise.isEmpty &&
      priceRange.start == 0 &&
      priceRange.end == 20000 &&
      languages.isEmpty &&
      !availableToday;

  /// Идэвхтэй шүүлтүүрийн тоо
  int get activeFilterCount {
    int count = 0;
    if (keyword.isNotEmpty) count++;
    if (expertise.isNotEmpty) count += expertise.length;
    if (priceRange.start != 0 || priceRange.end != 20000) count++;
    if (languages.isNotEmpty) count += languages.length;
    if (availableToday) count++;
    return count;
  }

  AdvisorFilter copyWith({
    String? keyword,
    List<AdvisorExpertise>? expertise,
    RangeValues? priceRange,
    List<String>? languages,
    bool? availableToday,
  }) {
    return AdvisorFilter(
      keyword: keyword ?? this.keyword,
      expertise: expertise ?? this.expertise,
      priceRange: priceRange ?? this.priceRange,
      languages: languages ?? this.languages,
      availableToday: availableToday ?? this.availableToday,
    );
  }

  /// Бүх шүүлтүүр арилгах
  AdvisorFilter clear() {
    return const AdvisorFilter();
  }
}
