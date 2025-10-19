// lib/features/advisors/presentation/advisors_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/search_field.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../shared/design/design_system.dart';
import '../application/advisors_provider.dart';
import '../domain/models/advisor_filter.dart';
import 'advisor_detail_screen.dart';
import 'widgets/advisor_filter_sheet.dart';
import 'widgets/advisor_list_card.dart';

/// Зөвлөхүүдийн жагсаалт хуудас
class AdvisorsListScreen extends ConsumerStatefulWidget {
  const AdvisorsListScreen({super.key});

  @override
  ConsumerState<AdvisorsListScreen> createState() => _AdvisorsListScreenState();
}

class _AdvisorsListScreenState extends ConsumerState<AdvisorsListScreen> {
  @override
  void initState() {
    super.initState();
    // Initial load
    Future.microtask(() {
      ref.read(advisorsProvider.notifier).build();
    });
  }

  @override
  Widget build(BuildContext context) {
    final advisorsAsync = ref.watch(advisorsProvider);
    final currentFilter = ref.watch(currentAdvisorFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Мэргэжлийн зөвлөхүүд',
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
              hint: 'Салбар / чиглэл / нэрээр хайх',
              onChanged: (value) {
                ref
                    .read(currentAdvisorFilterProvider.notifier)
                    .state = currentFilter.copyWith(keyword: value);
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

          // Advisors list
          Expanded(
            child: advisorsAsync.when(
              data: (advisors) {
                if (advisors.isEmpty) {
                  return const EmptyState(
                    title: 'Зөвлөх олдсонгүй',
                    subtitle:
                        'Таны нөхцөлд тохирох зөвлөх олдсонгүй 😕\nШүүлтүүрээ зөөллөөрөй',
                    icon: Icons.person_search_outlined,
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(advisorsProvider.notifier).refresh();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: advisors.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final advisor = advisors[index];

                      return AdvisorListCard(
                        key: ValueKey(advisor.id),
                        advisor: advisor,
                        onTap: () => _navigateToDetail(context, advisor.id),
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
                          height: 220,
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
        ],
      ),
    );
  }

  Widget _buildActiveFilters(AdvisorFilter filter) {
    final chips = <Widget>[];

    // Expertise chips
    for (final exp in filter.expertise) {
      chips.add(
        _buildFilterChip(exp.label, () {
          ref.read(currentAdvisorFilterProvider.notifier).state = filter
              .copyWith(
                expertise: filter.expertise.where((e) => e != exp).toList(),
              );
          _applyFilter();
        }),
      );
    }

    // Price chip
    if (filter.priceRange.start != 0 || filter.priceRange.end != 20000) {
      chips.add(
        _buildFilterChip(
          '${filter.priceRange.start.toInt()}-${filter.priceRange.end.toInt()}₮',
          () {
            ref.read(currentAdvisorFilterProvider.notifier).state = filter
                .copyWith(priceRange: const RangeValues(0, 20000));
            _applyFilter();
          },
        ),
      );
    }

    // Language chips
    for (final lang in filter.languages) {
      chips.add(
        _buildFilterChip(lang, () {
          ref.read(currentAdvisorFilterProvider.notifier).state = filter
              .copyWith(
                languages: filter.languages.where((l) => l != lang).toList(),
              );
          _applyFilter();
        }),
      );
    }

    // Available today chip
    if (filter.availableToday) {
      chips.add(
        _buildFilterChip('Өнөөдөр', () {
          ref.read(currentAdvisorFilterProvider.notifier).state = filter
              .copyWith(availableToday: false);
          _applyFilter();
        }),
      );
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
                ref.read(currentAdvisorFilterProvider.notifier).state =
                    const AdvisorFilter();
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

  void _showFilterSheet(BuildContext context, AdvisorFilter current) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => AdvisorFilterSheet(
            initial: current,
            onApply: (newFilter) {
              ref.read(currentAdvisorFilterProvider.notifier).state = newFilter;
              _applyFilter();
            },
          ),
    );
  }

  void _applyFilter() {
    final filter = ref.read(currentAdvisorFilterProvider);
    ref.read(advisorsProvider.notifier).applyFilter(filter);
  }

  void _navigateToDetail(BuildContext context, String advisorId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AdvisorDetailScreen(advisorId: advisorId),
      ),
    );
  }
}
