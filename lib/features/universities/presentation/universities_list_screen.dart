// lib/features/universities/presentation/universities_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/filters/university_filter.dart'
    as filter_lib;
import '../../../core/widgets/atoms/filters/university_filter_sheet.dart';
import '../../../core/widgets/atoms/search_field.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/molecules/compare_drawer.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../shared/design/design_system.dart';
import '../application/bookmark_provider.dart';
import '../application/compare_provider.dart';
import '../application/universities_provider.dart';
import '../domain/models/university.dart';
import 'university_detail_screen.dart';
import 'widgets/university_list_card.dart';
import 'compare_screen.dart';

/// Их сургуулиудын жагсаалт хуудас
class UniversitiesListScreen extends ConsumerStatefulWidget {
  const UniversitiesListScreen({super.key});

  @override
  ConsumerState<UniversitiesListScreen> createState() =>
      _UniversitiesListScreenState();
}

class _UniversitiesListScreenState
    extends ConsumerState<UniversitiesListScreen> {
  @override
  void initState() {
    super.initState();
    // Initial load
    Future.microtask(() {
      ref.read(universitiesProvider.notifier).build();
    });
  }

  @override
  Widget build(BuildContext context) {
    final universitiesAsync = ref.watch(universitiesProvider);
    final currentFilter = ref.watch(currentFilterProvider);
    final compareCart = ref.watch(compareCartProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Их сургуулиуд',
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _showFilterSheet(context, currentFilter),
            tooltip: 'Шүүлтүүр',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SearchBarWithFilter(
              hint: 'Сургуулийн нэр эсвэл чиглэлээр хайх',
              onChanged: (value) {
                ref.read(currentFilterProvider.notifier).state = currentFilter
                    .copyWith(keyword: value);
                _applyFilter();
              },
              onOpenFilter: () => _showFilterSheet(context, currentFilter),
            ),
          ),

          // Active filter chips
          if (!currentFilter.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildActiveFilters(currentFilter),
            ),

          // Universities list
          Expanded(
            child: universitiesAsync.when(
              data: (universities) {
                if (universities.isEmpty) {
                  return EmptyState(
                    title: 'Сургууль олдсонгүй',
                    subtitle:
                        'Таны нөхцөлд тохирох сургууль олдсонгүй 😕\nШүүлтүүрээ зөөллөөрөй',
                    icon: Icons.school_outlined,
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(universitiesProvider.notifier).refresh();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: universities.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final university = universities[index];
                      final isBookmarked = ref
                          .watch(bookmarkedUniversitiesProvider)
                          .contains(university.id);

                      return UniversityListCard(
                        key: ValueKey(university.id),
                        university: university,
                        isBookmarked: isBookmarked,
                        onTap: () => _navigateToDetail(context, university.id),
                        onBookmark:
                            () => _handleBookmark(context, university.id),
                        onCompare: () => _handleCompare(context, university),
                      );
                    },
                  ),
                );
              },
              loading:
                  () => ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: 5,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder:
                        (_, __) => const SkeletonBox(
                          height: 140,
                          width: double.infinity,
                        ),
                  ),
              error:
                  (error, stack) => EmptyState(
                    title: 'Алдаа гарлаа',
                    subtitle: error.toString(),
                    icon: Icons.error_outline,
                  ),
            ),
          ),

          // Compare drawer
          if (compareCart.isNotEmpty)
            CompareDrawer(
              items: compareCart.map((u) => u.name).toList(),
              onCompare: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CompareScreen()),
                );
              },
              onClear: () {
                ref.read(compareCartProvider.notifier).clear();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildActiveFilters(filter_lib.UniversityFilter filter) {
    final chips = <Widget>[];

    if (filter.location != null) {
      chips.add(
        _buildFilterChip(
          filter.location == filter_lib.UniLocation.ub ? 'УБ' : 'Хөдөө',
          () {
            ref.read(currentFilterProvider.notifier).state = filter.copyWith(
              location: null,
            );
            _applyFilter();
          },
        ),
      );
    }

    if (filter.type != null) {
      chips.add(
        _buildFilterChip(
          filter.type == filter_lib.UniType.public ? 'Төрийн' : 'Хувийн',
          () {
            ref.read(currentFilterProvider.notifier).state = filter.copyWith(
              type: null,
            );
            _applyFilter();
          },
        ),
      );
    }

    if (filter.categories.isNotEmpty) {
      for (final cat in filter.categories) {
        chips.add(
          _buildFilterChip(cat, () {
            final newCats = [...filter.categories]..remove(cat);
            ref.read(currentFilterProvider.notifier).state = filter.copyWith(
              categories: newCats,
            );
            _applyFilter();
          }),
        );
      }
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          if (i == chips.length) {
            return TextButton.icon(
              onPressed: () {
                ref.read(currentFilterProvider.notifier).state =
                    const filter_lib.UniversityFilter();
                _applyFilter();
              },
              icon: const Icon(Icons.clear_all, size: 16),
              label: const Text('Арилгах'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            );
          }
          return chips[i];
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.chipPurple,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 16, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(
    BuildContext context,
    filter_lib.UniversityFilter current,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => UniversityFilterSheet(
            initial: current,
            onApply: (newFilter) {
              ref.read(currentFilterProvider.notifier).state = newFilter;
              _applyFilter();
            },
          ),
    );
  }

  void _applyFilter() {
    final filter = ref.read(currentFilterProvider);
    ref.read(universitiesProvider.notifier).applyFilter(filter);
  }

  void _navigateToDetail(BuildContext context, String universityId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UniversityDetailScreen(universityId: universityId),
      ),
    );
  }

  void _handleBookmark(BuildContext context, String universityId) {
    ref.read(bookmarkedUniversitiesProvider.notifier).toggle(universityId);
    final isNowBookmarked = ref
        .read(bookmarkedUniversitiesProvider)
        .contains(universityId);
    showAppSnack(
      context,
      isNowBookmarked ? 'Хадгалагдлаа ✓' : 'Хадгалалтаас хасагдлаа',
    );
  }

  void _handleCompare(BuildContext context, University university) {
    ref.read(compareCartProvider.notifier).toggle(university);
    final count = ref.read(compareCartCountProvider);
    showAppSnack(context, 'Харьцуулах: $count сургууль');
  }
}
