// lib/features/advisors/presentation/advisor_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/app_card.dart';
import '../../../core/widgets/atoms/cached_image.dart';
import '../../../core/widgets/atoms/rating_stars.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/molecules/sticky_cta.dart';
import '../../../shared/design/design_system.dart';
import '../application/advisors_provider.dart';
import '../domain/models/advisor.dart';
import 'booking_bottom_sheet.dart';
import 'widgets/review_card.dart';

/// Зөвлөхийн дэлгэрэнгүй хуудас
class AdvisorDetailScreen extends ConsumerWidget {
  final String advisorId;

  const AdvisorDetailScreen({super.key, required this.advisorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advisorAsync = ref.watch(advisorDetailProvider(advisorId));
    final reviews = ref.watch(advisorReviewsProvider(advisorId));

    return advisorAsync.when(
      data: (advisor) {
        if (advisor == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Зөвлөх')),
            body: const EmptyState(
              title: 'Зөвлөх олдсонгүй',
              subtitle: 'Уучлаарай, энэ зөвлөх олдсонгүй',
              icon: Icons.person_off_outlined,
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Hero header
                  _buildHeroHeader(context, advisor),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bio section
                          _buildBioSection(advisor),
                          const SizedBox(height: 20),

                          // Experience
                          _buildExperienceSection(advisor),
                          const SizedBox(height: 20),

                          // Expertise tags
                          _buildExpertiseSection(advisor),
                          const SizedBox(height: 20),

                          // Languages
                          _buildLanguagesSection(advisor),
                          const SizedBox(height: 20),

                          // Pricing card
                          _buildPricingCard(advisor),
                          const SizedBox(height: 20),

                          // Available slots preview
                          _buildAvailabilitySection(advisor),
                          const SizedBox(height: 20),

                          // Reviews section
                          if (reviews.isNotEmpty) ...[
                            _buildReviewsSection(reviews),
                            const SizedBox(height: 80),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Sticky bottom bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: StickyCTA(
                  child: Row(
                    children: [
                      if (advisor.pricing[ConsultationType.chat] != null) ...[
                        Expanded(
                          child: _buildBookButton(
                            context,
                            ref,
                            advisor,
                            ConsultationType.chat,
                            '💬 Chat товлох',
                            isPrimary: false,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      if (advisor.pricing[ConsultationType.video] != null)
                        Expanded(
                          child: _buildBookButton(
                            context,
                            ref,
                            advisor,
                            ConsultationType.video,
                            '🎥 Video товлох',
                            isPrimary: true,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (error, stack) => Scaffold(
            appBar: AppBar(title: const Text('Алдаа')),
            body: EmptyState(
              title: 'Алдаа гарлаа',
              subtitle: error.toString(),
              icon: Icons.error_outline,
            ),
          ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, Advisor advisor) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(gradient: AppGradients.brand),
            ),
            // Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Hero(
                      tag: 'advisor_${advisor.id}',
                      child: CachedImage(
                        imageUrl: advisor.imageUrl,
                        width: 100,
                        height: 100,
                        shape: BoxShape.circle,
                        errorWidget: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          advisor.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        if (advisor.verified) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      advisor.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingStars(
                          rating: advisor.rating,
                          size: 18,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${advisor.rating} (${advisor.reviewCount} үнэлгээ)',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBioSection(Advisor advisor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Танилцуулга',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          advisor.bio,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.textPrimary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceSection(Advisor advisor) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppGradients.brand,
              borderRadius: BorderRadius.circular(12),
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
                  advisor.experienceLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Мэргэжлийн туршлага',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.open_in_new, size: 20, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildExpertiseSection(Advisor advisor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Мэргэжлийн чиглэл',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              advisor.expertise.map((exp) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.brand,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    boxShadow: AppShadows.card,
                  ),
                  child: Text(
                    exp.tag,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildLanguagesSection(Advisor advisor) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.language, color: AppColors.primary, size: 24),
          const SizedBox(width: 12),
          const Text(
            'Хэл:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            advisor.languagesList,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(Advisor advisor) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.payments_outlined, color: AppColors.primary, size: 24),
              SizedBox(width: 8),
              Text(
                'Үнийн мэдээлэл',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (advisor.pricing[ConsultationType.chat] != null)
            _buildPriceRow(
              '💬 Chat зөвлөгөө',
              advisor.pricing[ConsultationType.chat]!,
              '20 минут',
            ),
          if (advisor.pricing[ConsultationType.chat] != null &&
              advisor.pricing[ConsultationType.video] != null)
            const Divider(height: 24),
          if (advisor.pricing[ConsultationType.video] != null)
            _buildPriceRow(
              '🎥 Video зөвлөгөө',
              advisor.pricing[ConsultationType.video]!,
              '30 минут',
            ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, int price, String duration) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              duration,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Text(
          price == 0 ? 'Үнэгүй' : '$price₮',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilitySection(Advisor advisor) {
    final slots = advisor.availableSlots.take(7).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Боломжтой цагууд',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        if (slots.isEmpty)
          const Text(
            'Одоогоор боломжтой цаг байхгүй байна',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          )
        else
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: slots.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final slot = slots[i];
                return Container(
                  width: 80,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppGradients.brand,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppShadows.card,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${slot.month}/${slot.day}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${slot.hour.toString().padLeft(2, '0')}:${slot.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildReviewsSection(List reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Үнэлгээ сэтгэгдэл',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...reviews.map(
          (review) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ReviewCard(review: review),
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton(
    BuildContext context,
    WidgetRef ref,
    Advisor advisor,
    ConsultationType type,
    String label, {
    required bool isPrimary,
  }) {
    if (isPrimary) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showBookingSheet(context, ref, advisor, type),
          borderRadius: BorderRadius.circular(AppRadius.button),
          child: Ink(
            decoration: BoxDecoration(
              gradient: AppGradients.brand,
              borderRadius: BorderRadius.circular(AppRadius.button),
              boxShadow: AppShadows.button,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return OutlinedButton(
      onPressed: () => _showBookingSheet(context, ref, advisor, type),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: AppColors.primary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }

  void _showBookingSheet(
    BuildContext context,
    WidgetRef ref,
    Advisor advisor,
    ConsultationType type,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => BookingBottomSheet(advisor: advisor, initialType: type),
    );
  }
}
