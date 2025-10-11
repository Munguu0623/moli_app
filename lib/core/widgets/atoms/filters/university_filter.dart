// lib/filters/university_filter.dart
import 'package:flutter/material.dart';

enum UniLocation { ub, rural }

enum UniType { public, private }

class UniversityFilter {
  final String keyword;
  final UniLocation? location;
  final UniType? type;
  final RangeValues tuition; // сая ₮
  final RangeValues entryScore; // 400–800
  final List<String> categories; // ["IT","Санхүү",...]

  const UniversityFilter({
    this.keyword = '',
    this.location,
    this.type,
    this.tuition = const RangeValues(1, 10),
    this.entryScore = const RangeValues(400, 800),
    this.categories = const [],
  });

  UniversityFilter copyWith({
    String? keyword,
    UniLocation? location,
    UniType? type,
    RangeValues? tuition,
    RangeValues? entryScore,
    List<String>? categories,
  }) => UniversityFilter(
    keyword: keyword ?? this.keyword,
    location: location ?? this.location,
    type: type ?? this.type,
    tuition: tuition ?? this.tuition,
    entryScore: entryScore ?? this.entryScore,
    categories: categories ?? this.categories,
  );

  bool get isEmpty =>
      keyword.isEmpty &&
      location == null &&
      type == null &&
      tuition == const RangeValues(1, 10) &&
      entryScore == const RangeValues(400, 800) &&
      categories.isEmpty;
}
