// lib/features/occupations/presentation/occupations_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/search_field.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../shared/design/design_system.dart';
import '../application/occupation_categories_provider.dart';
import '../application/occupations_provider.dart';
import '../domain/entities/occupation.dart';
import 'occupation_detail_screen.dart';
import 'widgets/occupation_list_card.dart';

/// Тухайн чиглэлийн мэргэжлүүдийн жагсаалт
class OccupationsListScreen extends ConsumerStatefulWidget {
  final String categoryId;

  const OccupationsListScreen({super.key, required this.categoryId});

  @override
  ConsumerState<OccupationsListScreen> createState() =>
      _OccupationsListScreenState();
}

class _OccupationsListScreenState extends ConsumerState<OccupationsListScreen> {
  // Filter states
  String _sortBy = 'name'; // name, salary, outlook
  DemandOutlook? _filterOutlook;
  String _searchQuery = '';

  // Активтай filter тоолох
  int get _activeFilterCount {
    int count = 0;
    if (_filterOutlook != null) count++;
    if (_sortBy != 'name') count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(occupationCategoryProvider(widget.categoryId));
    var occupations = ref.watch(
      occupationsByCategoryProvider(widget.categoryId),
    );

    if (category == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Мэргэжлүүд')),
        body: const EmptyState(
          title: 'Чиглэл олдсонгүй',
          subtitle: 'Энэ чиглэл олдохгүй байна',
          icon: Icons.error_outline,
        ),
      );
    }

    // Apply search
    if (_searchQuery.isNotEmpty) {
      occupations =
          occupations.where((occ) {
            return occ.name.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                occ.summary.toLowerCase().contains(_searchQuery.toLowerCase());
          }).toList();
    }

    // Apply filter
    if (_filterOutlook != null) {
      occupations =
          occupations
              .where((occ) => occ.demandOutlook == _filterOutlook)
              .toList();
    }

    // Apply sort
    occupations = List.from(occupations);
    switch (_sortBy) {
      case 'name':
        occupations.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'salary':
        occupations.sort(
          (a, b) => b.salaryRange.median.compareTo(a.salaryRange.median),
        );
        break;
      case 'outlook':
        occupations.sort((a, b) {
          final order = {
            DemandOutlook.growing: 0,
            DemandOutlook.stable: 1,
            DemandOutlook.declining: 2,
          };
          return order[a.demandOutlook]!.compareTo(order[b.demandOutlook]!);
        });
        break;
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: category.name,
        showBackButton: true,
        actions: [
          // Sort button
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() => _sortBy = value);
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: 'name', child: Text('Нэрээр')),
                  const PopupMenuItem(
                    value: 'salary',
                    child: Text('Цалингаар'),
                  ),
                  const PopupMenuItem(
                    value: 'outlook',
                    child: Text('Ирээдүйгээр'),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar with filter indicator
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: SearchBarWithFilter(
                    hint: 'Мэргэжил хайх...',
                    onChanged: (query) {
                      setState(() => _searchQuery = query);
                    },
                    onOpenFilter: () {
                      // Show filter bottom sheet
                      _showFilterSheet(context);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Active filters display
          if (_filterOutlook != null || _sortBy != 'name') ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.chipBlue.withOpacity(0.3),
              child: Row(
                children: [
                  const Icon(
                    Icons.filter_list,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (_filterOutlook != null) ...[
                            _buildActiveFilterChip(
                              label: _getOutlookLabel(_filterOutlook!),
                              onRemove: () {
                                setState(() => _filterOutlook = null);
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (_sortBy != 'name') ...[
                            _buildActiveFilterChip(
                              label: 'Эрэмбэлэх: ${_getSortLabel(_sortBy)}',
                              onRemove: () {
                                setState(() => _sortBy = 'name');
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _filterOutlook = null;
                        _sortBy = 'name';
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Цэвэрлэх',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Results count
          if (occupations.isNotEmpty &&
              (_searchQuery.isNotEmpty || _filterOutlook != null))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.background,
              child: Row(
                children: [
                  Text(
                    '${occupations.length} мэргэжил олдлоо',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (_searchQuery.isNotEmpty) ...[
                    const Text(
                      ' • ',
                      style: TextStyle(color: AppColors.textTertiary),
                    ),
                    Expanded(
                      child: Text(
                        '"$_searchQuery"',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),

          // Occupations list
          Expanded(
            child:
                occupations.isEmpty
                    ? EmptyState(
                      title: 'Мэргэжил олдсонгүй',
                      subtitle:
                          _searchQuery.isNotEmpty
                              ? '"$_searchQuery" хайлтаар илэрц олдсонгүй. Өөр түлхүүр үг оруулна уу.'
                              : 'Шүүлтийг өөрчлөөд дахин оролдоно уу',
                      icon: Icons.work_off_outlined,
                    )
                    : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: occupations.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final occupation = occupations[index];
                        return OccupationListCard(
                          occupation: occupation,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (_) => OccupationDetailScreen(
                                      occupationId: occupation.id,
                                    ),
                              ),
                            );
                          },
                          onBookmark: () {
                            // TODO: Bookmark функц нэмэх
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${occupation.name} хадгаллаа'),
                              ),
                            );
                          },
                          onCompare: () {
                            // TODO: Харьцуулах функц нэмэх
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${occupation.name} харьцуулалтад нэмэгдлээ',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  // Filter bottom sheet
  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Text(
                      'Шүүлт & Эрэмбэлэх',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    if (_activeFilterCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$_activeFilterCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sort section
                const Text(
                  'Эрэмбэлэх',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildFilterChip(
                      label: 'Нэрээр',
                      selected: _sortBy == 'name',
                      onTap: () {
                        setState(() => _sortBy = 'name');
                      },
                    ),
                    _buildFilterChip(
                      label: '💰 Цалингаар',
                      selected: _sortBy == 'salary',
                      onTap: () {
                        setState(() => _sortBy = 'salary');
                      },
                    ),
                    _buildFilterChip(
                      label: '📊 Ирээдүйгээр',
                      selected: _sortBy == 'outlook',
                      onTap: () {
                        setState(() => _sortBy = 'outlook');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Filter section
                const Text(
                  'Ирээдүйн эрэлт',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildFilterChip(
                      label: 'Бүгд',
                      selected: _filterOutlook == null,
                      onTap: () {
                        setState(() => _filterOutlook = null);
                      },
                    ),
                    _buildFilterChip(
                      label: '📈 Өсч байгаа',
                      selected: _filterOutlook == DemandOutlook.growing,
                      onTap: () {
                        setState(() => _filterOutlook = DemandOutlook.growing);
                      },
                    ),
                    _buildFilterChip(
                      label: '⚖️ Тогтвортой',
                      selected: _filterOutlook == DemandOutlook.stable,
                      onTap: () {
                        setState(() => _filterOutlook = DemandOutlook.stable);
                      },
                    ),
                    _buildFilterChip(
                      label: '📉 Буурч байгаа',
                      selected: _filterOutlook == DemandOutlook.declining,
                      onTap: () {
                        setState(
                          () => _filterOutlook = DemandOutlook.declining,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _filterOutlook = null;
                            _sortBy = 'name';
                          });
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: AppColors.border),
                        ),
                        child: const Text('Цэвэрлэх'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Хадгалах'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
    );
  }

  // Active filter chip
  Widget _buildActiveFilterChip({
    required String label,
    required VoidCallback onRemove,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 14, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  // Helper functions
  String _getOutlookLabel(DemandOutlook outlook) {
    switch (outlook) {
      case DemandOutlook.growing:
        return '📈 Өсч байгаа';
      case DemandOutlook.stable:
        return '⚖️ Тогтвортой';
      case DemandOutlook.declining:
        return '📉 Буурч байгаа';
    }
  }

  String _getSortLabel(String sort) {
    switch (sort) {
      case 'name':
        return 'Нэрээр';
      case 'salary':
        return 'Цалингаар';
      case 'outlook':
        return 'Ирээдүйгээр';
      default:
        return sort;
    }
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.chipBlue,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          boxShadow:
              selected
                  ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
