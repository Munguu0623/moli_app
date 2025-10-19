// lib/features/profile/presentation/screens/saved_items_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../shared/design/design_system.dart';
import '../../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../../core/widgets/atoms/states.dart';
import '../../application/saved_items_provider.dart';
import '../../../universities/application/bookmark_provider.dart';
import '../../../universities/domain/models/university.dart';
import '../../../occupations/domain/entities/occupation.dart';

/// Хадгалсан зүйлсийн хуудас
class SavedItemsScreen extends ConsumerStatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  ConsumerState<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends ConsumerState<SavedItemsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Хадгалсан зүйлс',
        showBackButton: true,
        showNotification: false,
        showProfile: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Сургуулиуд'),
            Tab(text: 'Мэргэжлүүд'),
            Tab(text: 'Нийтлэлүүд'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUniversitiesTab(),
          _buildOccupationsTab(),
          _buildArticlesTab(),
        ],
      ),
    );
  }

  Widget _buildUniversitiesTab() {
    final universities = ref.watch(savedUniversitiesProvider);

    if (universities.isEmpty) {
      return const EmptyState(
        icon: Icons.school_outlined,
        title: 'Хадгалсан сургууль байхгүй',
        subtitle: 'Сургуулийн жагсаалтаас сонгож хадгалаарай',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: universities.length,
      separatorBuilder: (context, index) => const Gap(12),
      itemBuilder: (context, index) {
        final university = universities[index];
        return _buildUniversityCard(university);
      },
    );
  }

  Widget _buildOccupationsTab() {
    final occupations = ref.watch(savedOccupationsProvider);

    if (occupations.isEmpty) {
      return const EmptyState(
        icon: Icons.work_outline,
        title: 'Хадгалсан мэргэжил байхгүй',
        subtitle: 'Мэргэжлийн жагсаалтаас сонгож хадгалаарай',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: occupations.length,
      separatorBuilder: (context, index) => const Gap(12),
      itemBuilder: (context, index) {
        final occupation = occupations[index];
        return _buildOccupationCard(occupation);
      },
    );
  }

  Widget _buildArticlesTab() {
    final articles = ref.watch(savedArticlesProvider);

    if (articles.isEmpty) {
      return const EmptyState(
        icon: Icons.article_outlined,
        title: 'Хадгалсан нийтлэл байхгүй',
        subtitle: 'Нийтлэлийн жагсаалтаас сонгож хадгалаарай',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      separatorBuilder: (context, index) => const Gap(12),
      itemBuilder: (context, index) {
        final article = articles[index];
        return _buildArticleCard(article);
      },
    );
  }

  Widget _buildUniversityCard(University university) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      university.logoUrl.isNotEmpty
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              university.logoUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                          : const Icon(
                            Icons.school,
                            color: AppColors.primary,
                            size: 28,
                          ),
                ),
                const SizedBox(width: 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        university.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            university.location,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const Gap(4),
                      Text(
                        '${university.tuitionRange[0]}₮ - ${university.tuitionRange[1]}₮',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Actions
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // TODO: Navigate to detail
                    showAppSnack(context, 'Сургуулийн дэлгэрэнгүй');
                  },
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Харах'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    ref
                        .read(bookmarkedUniversitiesProvider.notifier)
                        .remove(university.id);
                    showAppSnack(context, 'Устгагдлаа');
                  },
                  icon: const Icon(Icons.delete_outline, size: 16),
                  label: const Text('Устгах'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.error),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOccupationCard(Occupation occupation) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    occupation.imageUrl != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            occupation.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                        : const Icon(
                          Icons.work_outline,
                          color: AppColors.primary,
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
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      occupation.summary,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(12),

          // Salary & Outlook
          Row(
            children: [
              const Icon(
                Icons.monetization_on_outlined,
                size: 16,
                color: AppColors.success,
              ),
              const SizedBox(width: 4),
              Text(
                occupation.salaryRange.formattedRange,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.trending_up, size: 16, color: AppColors.info),
              const SizedBox(width: 4),
              Text(
                occupation.outlookLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const Gap(12),
          const Divider(height: 1),
          const Gap(8),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  // TODO: Navigate to detail
                  showAppSnack(context, 'Мэргэжлийн дэлгэрэнгүй');
                },
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('Харах'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
              TextButton.icon(
                onPressed: () {
                  ref
                      .read(bookmarkedOccupationsProvider.notifier)
                      .remove(occupation.id);
                  showAppSnack(context, 'Устгагдлаа');
                },
                icon: const Icon(Icons.delete_outline, size: 16),
                label: const Text('Устгах'),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.article,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      article['excerpt'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(12),
          const Divider(height: 1),
          const Gap(8),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  showAppSnack(context, 'Нийтлэл унших');
                },
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('Унших'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
              TextButton.icon(
                onPressed: () {
                  ref
                      .read(bookmarkedArticlesProvider.notifier)
                      .remove(article['id'] as String);
                  showAppSnack(context, 'Устгагдлаа');
                },
                icon: const Icon(Icons.delete_outline, size: 16),
                label: const Text('Устгах'),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
