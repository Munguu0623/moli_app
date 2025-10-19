// lib/features/profile/presentation/screens/consultation_history_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../shared/design/design_system.dart';
import '../../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../../core/widgets/atoms/states.dart';
import '../../../advisors/domain/models/consultation_booking.dart';
import '../../application/consultation_history_provider.dart';

/// Зөвлөгөөний түүхийн хуудас
class ConsultationHistoryScreen extends ConsumerWidget {
  const ConsultationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcoming = ref.watch(upcomingConsultationsProvider);
    final past = ref.watch(pastConsultationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Зөвлөгөө түүх',
        showBackButton: true,
        showNotification: false,
        showProfile: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upcoming consultations
            if (upcoming.isNotEmpty) ...[
              _buildSectionTitle('Ирэх уулзалтууд', upcoming.length),
              const Gap(12),
              ...upcoming.map(
                (booking) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildUpcomingBookingCard(context, ref, booking),
                ),
              ),
              const Gap(24),
            ],

            // Past consultations
            if (past.isNotEmpty) ...[
              _buildSectionTitle('Өнгөрсөн зөвлөгөө', past.length),
              const Gap(12),
              ...past.map(
                (booking) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildPastBookingCard(context, ref, booking),
                ),
              ),
            ],

            // Empty state
            if (upcoming.isEmpty && past.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: EmptyState(
                  icon: Icons.event_busy_outlined,
                  title: 'Зөвлөгөө байхгүй',
                  subtitle: 'Танд товлосон уулзалт байхгүй байна',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingBookingCard(
    BuildContext context,
    WidgetRef ref,
    ConsultationBooking booking,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child:
                    booking.advisorImageUrl.isNotEmpty
                        ? ClipOval(
                          child: Image.network(
                            booking.advisorImageUrl,
                            fit: BoxFit.cover,
                          ),
                        )
                        : const Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 24,
                        ),
              ),
              const SizedBox(width: 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.advisorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      booking.topic ?? 'Ерөнхий зөвлөгөө',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      booking.status.emoji,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking.status.label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Gap(12),
          const Divider(height: 1),
          const Gap(12),

          // Date & Time
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: AppColors.info),
              const SizedBox(width: 6),
              Text(
                booking.dateLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, size: 16, color: AppColors.info),
              const SizedBox(width: 6),
              Text(
                booking.timeLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const Gap(12),

          // Type & Price
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.chipBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  booking.type.label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${booking.price}₮',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          const Gap(12),

          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  booking.canJoin
                      ? () {
                        showAppSnack(context, 'Чат эхлүүлж байна...');
                      }
                      : null,
              icon: const Icon(Icons.chat_bubble_outline, size: 18),
              label: Text(
                booking.canJoin ? 'Чат эхлүүлэх' : 'Товлосон цагт эхлэнэ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastBookingCard(
    BuildContext context,
    WidgetRef ref,
    ConsultationBooking booking,
  ) {
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
          // Header
          Row(
            children: [
              // Avatar (smaller)
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.textTertiary.withOpacity(0.1),
                child:
                    booking.advisorImageUrl.isNotEmpty
                        ? ClipOval(
                          child: Image.network(
                            booking.advisorImageUrl,
                            fit: BoxFit.cover,
                          ),
                        )
                        : const Icon(
                          Icons.person,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
              ),
              const SizedBox(width: 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.advisorName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      '${booking.dateLabel} • ${booking.timeLabel}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Completed badge
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 20,
              ),
            ],
          ),

          const Gap(12),

          // Topic
          if (booking.topic != null)
            Text(
              booking.topic!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),

          const Gap(12),

          // Action
          TextButton.icon(
            onPressed: () {
              showAppSnack(context, 'Дахин зөвлөгөө товлох');
            },
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Дахин зөвлөгөө авах'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
