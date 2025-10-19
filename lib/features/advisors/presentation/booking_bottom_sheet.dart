// lib/features/advisors/presentation/booking_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/atoms/cached_image.dart';
import '../../../core/widgets/molecules/calendar_slot_picker.dart';
import '../../../shared/design/design_system.dart';
import '../application/advisors_provider.dart';
import '../domain/models/advisor.dart';
import 'widgets/booking_type_selector.dart';

/// Зөвлөгөө товлох bottom sheet
class BookingBottomSheet extends ConsumerStatefulWidget {
  final Advisor advisor;
  final ConsultationType initialType;

  const BookingBottomSheet({
    super.key,
    required this.advisor,
    required this.initialType,
  });

  @override
  ConsumerState<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends ConsumerState<BookingBottomSheet> {
  late ConsultationType _selectedType;
  final TextEditingController _topicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
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

              // Title
              const Text(
                'Зөвлөгөө товлох',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),

              // Advisor mini card
              _buildAdvisorCard(),
              const SizedBox(height: 24),

              // Type selector
              BookingTypeSelector(
                selected: _selectedType,
                onChanged: (type) {
                  setState(() {
                    _selectedType = type;
                  });
                },
                chatPrice: widget.advisor.pricing[ConsultationType.chat] ?? 0,
                videoPrice: widget.advisor.pricing[ConsultationType.video] ?? 0,
              ),
              const SizedBox(height: 24),

              // Topic input
              const Text(
                'Сэдэв (заавал биш)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _topicController,
                decoration: InputDecoration(
                  hintText: 'Ямар зөвлөгөө авахыг хүсч байна?',
                  hintStyle: const TextStyle(color: AppColors.textTertiary),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                maxLines: 2,
                maxLength: 200,
              ),
              const SizedBox(height: 20),

              // Calendar picker
              const Text(
                'Цаг сонгох',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              CalendarSlotPicker(
                initial: DateTime.now(),
                slots: _getTimeSlots(),
                submitButtonText:
                    bookingState.isLoading
                        ? 'Илгээж байна...'
                        : 'Хүсэлт илгээх',
                onSelect: (date, slot) {
                  _handleBooking(date, slot);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdvisorCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.brand,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          CachedImage(
            imageUrl: widget.advisor.imageUrl,
            width: 56,
            height: 56,
            shape: BoxShape.circle,
            errorWidget: const Icon(
              Icons.person,
              size: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.advisor.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.advisor.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TimeOfDay> _getTimeSlots() {
    return [
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 11, minute: 0),
      const TimeOfDay(hour: 13, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
      const TimeOfDay(hour: 16, minute: 0),
      const TimeOfDay(hour: 17, minute: 0),
      const TimeOfDay(hour: 18, minute: 0),
    ];
  }

  Future<void> _handleBooking(DateTime date, TimeOfDay slot) async {
    final scheduledTime = DateTime(
      date.year,
      date.month,
      date.day,
      slot.hour,
      slot.minute,
    );

    final price = widget.advisor.pricing[_selectedType] ?? 0;

    await ref
        .read(bookingProvider.notifier)
        .createBooking(
          advisorId: widget.advisor.id,
          advisorName: widget.advisor.name,
          advisorImageUrl: widget.advisor.imageUrl,
          scheduledTime: scheduledTime,
          type: _selectedType,
          price: price,
          topic:
              _topicController.text.trim().isEmpty
                  ? null
                  : _topicController.text.trim(),
        );

    if (!mounted) return;

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎉 Таны хүсэлт амжилттай илгээгдлээ!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Close sheet
    Navigator.of(context).pop();

    // Reset booking state
    ref.read(bookingProvider.notifier).reset();
  }
}
