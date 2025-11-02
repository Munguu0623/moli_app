import 'package:flutter_riverpod/legacy.dart';
import 'university_filter.dart';

// Энгийн StateProvider ашиглах нь илүү хялбар
final universityFilterProvider = StateProvider<UniversityFilter>(
  (ref) => const UniversityFilter(),
);
