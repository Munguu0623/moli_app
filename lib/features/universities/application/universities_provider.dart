// lib/features/universities/application/universities_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/filters/university_filter.dart';
import '../data/mock_programs.dart';
import '../data/mock_universities.dart';
import '../domain/models/admission_info.dart';
import '../domain/models/campus_life.dart';
import '../domain/models/dormitory.dart';
import '../domain/models/program.dart';
import '../domain/models/tuition_info.dart';
import '../domain/models/university.dart';

/// Их сургуулиудын жагсаалт (AsyncNotifier)
final universitiesProvider =
    AsyncNotifierProvider<UniversitiesNotifier, List<University>>(
      UniversitiesNotifier.new,
    );

class UniversitiesNotifier extends AsyncNotifier<List<University>> {
  @override
  Future<List<University>> build() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return mockUniversities;
  }

  /// Хайлт + шүүлтүүр логик
  Future<void> applyFilter(UniversityFilter filter) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(milliseconds: 300));

      var filtered = mockUniversities;

      // Keyword хайлт (нэр, байршил)
      if (filter.keyword.isNotEmpty) {
        final keyword = filter.keyword.toLowerCase();
        filtered =
            filtered.where((u) {
              return u.name.toLowerCase().contains(keyword) ||
                  u.location.toLowerCase().contains(keyword);
            }).toList();
      }

      // Байршлын шүүлтүүр
      if (filter.location != null) {
        filtered =
            filtered.where((u) {
              if (filter.location == UniLocation.ub) {
                return u.location.contains('Улаанбаатар');
              } else {
                return !u.location.contains('Улаанбаатар');
              }
            }).toList();
      }

      // Төрлийн шүүлтүүр
      if (filter.type != null) {
        filtered =
            filtered.where((u) {
              return u.type == filter.type;
            }).toList();
      }

      // Төлбөрийн шүүлтүүр (parse tuitionRange)
      final tuitionMin = filter.tuition.start * 1000000; // сая -> төгрөг
      final tuitionMax = filter.tuition.end * 1000000;
      filtered =
          filtered.where((u) {
            // "4.5M - 6.2M₮" -> avg = 5.35M
            final range = u.tuitionRange
                .replaceAll('M', '')
                .replaceAll('₮', '');
            final parts = range.split('-').map((e) => e.trim()).toList();
            if (parts.length == 2) {
              final low = double.tryParse(parts[0]) ?? 0;
              final high = double.tryParse(parts[1]) ?? 0;
              final avg = (low + high) / 2 * 1000000;
              return avg >= tuitionMin && avg <= tuitionMax;
            }
            return true;
          }).toList();

      // Элсэлтийн оноо шүүлтүүр
      filtered =
          filtered.where((u) {
            return u.avgEntryScore >= filter.entryScore.start &&
                u.avgEntryScore <= filter.entryScore.end;
          }).toList();

      // Чиглэлийн шүүлтүүр (categories)
      if (filter.categories.isNotEmpty) {
        filtered =
            filtered.where((u) {
              // Энэ их сургуульд тухайн категорийн хөтөлбөр байгаа эсэх шалгах
              final programs = getProgramsByUniversity(u.id);
              return programs.any(
                (p) => filter.categories.contains(p.category),
              );
            }).toList();
      }

      return filtered;
    });
  }

  /// Дахин ачаалах
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      return mockUniversities;
    });
  }
}

/// Тодорхой их сургуулийн дэлгэрэнгүй мэдээлэл авах
final universityDetailProvider = FutureProvider.family<University?, String>((
  ref,
  universityId,
) async {
  await Future.delayed(const Duration(milliseconds: 200));
  return mockUniversities.where((u) => u.id == universityId).firstOrNull;
});

/// Их сургуулийн хөтөлбөрүүд
final universityProgramsProvider = FutureProvider.family<List<Program>, String>(
  (ref, universityId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return getProgramsByUniversity(universityId);
  },
);

/// Их сургуулийн санхүүгийн мэдээлэл
final universityTuitionProvider = Provider.family<TuitionInfo?, String>((
  ref,
  universityId,
) {
  return mockTuitionInfo[universityId];
});

/// Их сургуулийн байрны мэдээлэл
final universityDormitoryProvider = Provider.family<Dormitory?, String>((
  ref,
  universityId,
) {
  return mockDormitories[universityId];
});

/// Их сургуулийн элсэлтийн мэдээлэл
final universityAdmissionProvider = Provider.family<AdmissionInfo?, String>((
  ref,
  universityId,
) {
  return mockAdmissionInfo[universityId];
});

/// Их сургуулийн кампусын амьдрал
final universityCampusLifeProvider = Provider.family<CampusLife?, String>((
  ref,
  universityId,
) {
  return mockCampusLife[universityId];
});

/// Одоогийн шүүлтүүр
final currentFilterProvider = StateProvider<UniversityFilter>((ref) {
  return const UniversityFilter();
});

/// Програмын дэлгэрэнгүй
final programDetailProvider = Provider.family<Program?, String>((
  ref,
  programId,
) {
  return mockPrograms.where((p) => p.id == programId).firstOrNull;
});

/// Категори бүрийн хөтөлбөрүүд
final programsByCategoryProvider = Provider.family<List<Program>, String>((
  ref,
  category,
) {
  return getProgramsByCategory(category);
});
