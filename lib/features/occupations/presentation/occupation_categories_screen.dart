// lib/features/occupations/presentation/occupation_categories_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/search_field.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../shared/design/design_system.dart';
import '../application/occupation_categories_provider.dart';
import '../application/occupations_provider.dart';
import '../application/selected_category_provider.dart';
import 'occupation_detail_screen.dart';
import 'occupations_list_screen.dart';
import 'widgets/occupation_category_card.dart';

/// Мэргэжлийн чиглэлүүдийн жагсаалт (Tab entry point)
class OccupationCategoriesScreen extends ConsumerStatefulWidget {
  const OccupationCategoriesScreen({super.key});

  @override
  ConsumerState<OccupationCategoriesScreen> createState() =>
      _OccupationCategoriesScreenState();
}

class _OccupationCategoriesScreenState
    extends ConsumerState<OccupationCategoriesScreen> {
  String _searchQuery = '';
  bool _showSearchResults = false;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(occupationCategoriesProvider);
    final searchResults =
        _searchQuery.isNotEmpty
            ? ref.watch(occupationSearchProvider(_searchQuery))
            : [];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Мэргэжлүүд'),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBarWithFilter(
              hint: 'Мэргэжил хайх (ж.нь: Програмист, Эмч...)',
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                  _showSearchResults = query.isNotEmpty;
                });
              },
              onOpenFilter: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Шүүлт удахгүй нэмэгдэнэ')),
                );
              },
            ),
          ),

          // Content
          Expanded(
            child:
                _showSearchResults
                    ? _buildSearchResults(searchResults)
                    : _buildCategoryGrid(categories),
          ),
        ],
      ),
    );
  }

  // Чиглэлүүдийн grid
  Widget _buildCategoryGrid(List categories) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // Header text
        const Text(
          'Та ямар салбарт ажиллахыг хүсч байна?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Өөрийгөө сонирхдог чиглэлээ сонгож, мэргэжлүүдийг судлаарай',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 24),

        // Grid view
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return OccupationCategoryCard(
              category: category,
              onTap: () {
                // Сонгогдсон чиглэлийн ID хадгалах
                ref.read(selectedCategoryIdProvider.notifier).state =
                    category.id;

                // Мэргэжлүүдийн жагсаалт руу шилжих
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (_) => OccupationsListScreen(categoryId: category.id),
                  ),
                );
              },
            );
          },
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  // Хайлтын үр дүн
  Widget _buildSearchResults(List searchResults) {
    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textTertiary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Илэрц олдсонгүй',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Өөр түлхүүр үгээр хайж үзээрэй',
              style: TextStyle(fontSize: 14, color: AppColors.textTertiary),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: searchResults.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final occupation = searchResults[index];
        final category = ref.watch(
          occupationCategoryProvider(occupation.categoryId),
        );

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Шууд дэлгэрэнгүй хуудас руу шилжих
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (_) =>
                          OccupationDetailScreen(occupationId: occupation.id),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: AppGradients.brand,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.work_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          occupation.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (category != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: category.color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: category.color,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              occupation.code,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
