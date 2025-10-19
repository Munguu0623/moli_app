// lib/features/advisors/presentation/my_consultations_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/states.dart';
import '../../../core/widgets/molecules/custom_app_bar.dart';
import '../../../shared/design/design_system.dart';
import '../application/advisors_provider.dart';
import '../domain/models/advisor.dart';
import '../domain/models/consultation_booking.dart';
import 'consultation_chat_screen.dart';
import 'widgets/consultation_card.dart';

/// Миний зөвлөгөөнүүдийн хуудас
class MyConsultationsScreen extends ConsumerStatefulWidget {
  const MyConsultationsScreen({super.key});

  @override
  ConsumerState<MyConsultationsScreen> createState() =>
      _MyConsultationsScreenState();
}

class _MyConsultationsScreenState extends ConsumerState<MyConsultationsScreen>
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
    final upcomingBookings = ref.watch(upcomingBookingsProvider);
    final completedBookings = ref.watch(completedBookingsProvider);
    final cancelledBookings = ref.watch(cancelledBookingsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Миний зөвлөгөөнүүд',
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          tabs: [
            Tab(text: 'Удахгүй (${upcomingBookings.length})'),
            Tab(text: 'Дууссан (${completedBookings.length})'),
            Tab(text: 'Цуцлагдсан (${cancelledBookings.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList(upcomingBookings, isUpcoming: true),
          _buildBookingsList(completedBookings),
          _buildBookingsList(cancelledBookings),
        ],
      ),
    );
  }

  Widget _buildBookingsList(
    List<ConsultationBooking> bookings, {
    bool isUpcoming = false,
  }) {
    if (bookings.isEmpty) {
      return EmptyState(
        title: 'Зөвлөгөө байхгүй байна',
        subtitle:
            isUpcoming
                ? 'Та одоогоор зөвлөгөө товлоогүй байна'
                : 'Энэ төрлийн зөвлөгөө байхгүй байна',
        icon: Icons.event_busy_outlined,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final booking = bookings[index];

        return ConsultationCard(
          key: ValueKey(booking.id),
          booking: booking,
          onTap: () => _showBookingDetails(booking),
          onAction: booking.canJoin ? () => _joinConsultation(booking) : null,
        );
      },
    );
  }

  void _showBookingDetails(ConsultationBooking booking) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const Text(
                  'Зөвлөгөөний дэлгэрэнгүй',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),

                _buildDetailRow(Icons.person, 'Зөвлөх', booking.advisorName),
                const SizedBox(height: 12),
                _buildDetailRow(
                  Icons.calendar_today,
                  'Огноо',
                  booking.dateLabel,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(Icons.access_time, 'Цаг', booking.timeLabel),
                const SizedBox(height: 12),
                _buildDetailRow(
                  booking.type == ConsultationType.chat
                      ? Icons.chat_bubble_outline
                      : Icons.videocam_outlined,
                  'Төрөл',
                  booking.type.label,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  Icons.payments_outlined,
                  'Үнэ',
                  booking.price == 0 ? 'Үнэгүй' : '${booking.price}₮',
                ),
                if (booking.topic != null) ...[
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    Icons.topic_outlined,
                    'Сэдэв',
                    booking.topic!,
                  ),
                ],
                const SizedBox(height: 24),

                // Actions
                if (booking.status == BookingStatus.pending) ...[
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _cancelBooking(booking);
                      },
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('Цуцлах'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: AppColors.error,
                        side: const BorderSide(
                          color: AppColors.error,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.button),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  void _joinConsultation(ConsultationBooking booking) {
    // Approve the booking (mock)
    ref
        .read(myBookingsProvider.notifier)
        .updateStatus(booking.id, BookingStatus.approved);

    // Navigate to chat screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ConsultationChatScreen(booking: booking),
      ),
    );
  }

  void _cancelBooking(ConsultationBooking booking) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              'Зөвлөгөө цуцлах уу?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            content: const Text(
              'Та зөвлөгөөгөө цуцлахдаа итгэлтэй байна уу?',
              style: TextStyle(fontSize: 15),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Буцах',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              FilledButton(
                onPressed: () {
                  ref
                      .read(myBookingsProvider.notifier)
                      .cancelBooking(booking.id);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Зөвлөгөө цуцлагдлаа'),
                      backgroundColor: AppColors.warning,
                    ),
                  );
                },
                style: FilledButton.styleFrom(backgroundColor: AppColors.error),
                child: const Text(
                  'Цуцлах',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
    );
  }
}
