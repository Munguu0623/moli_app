// lib/features/profile/application/consultation_history_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/advisors/domain/models/advisor.dart';
import '../../../features/advisors/domain/models/consultation_booking.dart';

/// Mock consultation history data
final consultationHistoryProvider = Provider<List<ConsultationBooking>>((ref) {
  final now = DateTime.now();

  return [
    // Ирэх уулзалтууд
    ConsultationBooking(
      id: 'booking_001',
      studentId: 'user_001',
      advisorId: 'advisor_001',
      advisorName: 'Б.Болормаа',
      advisorImageUrl: '',
      scheduledTime: now.add(const Duration(days: 2, hours: 14)),
      type: ConsultationType.video,
      status: BookingStatus.approved,
      topic: 'Их сургуулийн сонголт',
      price: 50000,
      createdAt: now.subtract(const Duration(days: 3)),
    ),
    ConsultationBooking(
      id: 'booking_002',
      studentId: 'user_001',
      advisorId: 'advisor_003',
      advisorName: 'Д.Ганбаатар',
      advisorImageUrl: '',
      scheduledTime: now.add(const Duration(days: 7, hours: 10)),
      type: ConsultationType.chat,
      status: BookingStatus.approved,
      topic: 'Мэргэжлийн чиглэл',
      price: 30000,
      createdAt: now.subtract(const Duration(days: 1)),
    ),

    // Өнгөрсөн зөвлөгөөнүүд
    ConsultationBooking(
      id: 'booking_003',
      studentId: 'user_001',
      advisorId: 'advisor_002',
      advisorName: 'С.Оюунгэрэл',
      advisorImageUrl: '',
      scheduledTime: now.subtract(const Duration(days: 10)),
      type: ConsultationType.video,
      status: BookingStatus.completed,
      topic: 'Тестийн дүн тайлбар',
      price: 50000,
      createdAt: now.subtract(const Duration(days: 15)),
    ),
    ConsultationBooking(
      id: 'booking_004',
      studentId: 'user_001',
      advisorId: 'advisor_001',
      advisorName: 'Б.Болормаа',
      advisorImageUrl: '',
      scheduledTime: now.subtract(const Duration(days: 30)),
      type: ConsultationType.chat,
      status: BookingStatus.completed,
      topic: 'Ерөнхий зөвлөгөө',
      price: 30000,
      createdAt: now.subtract(const Duration(days: 35)),
    ),
  ];
});

/// Ирэх уулзалтууд
final upcomingConsultationsProvider = Provider<List<ConsultationBooking>>((
  ref,
) {
  final allBookings = ref.watch(consultationHistoryProvider);
  final now = DateTime.now();
  return allBookings
      .where(
        (b) =>
            b.status == BookingStatus.approved && b.scheduledTime.isAfter(now),
      )
      .toList()
    ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
});

/// Өнгөрсөн зөвлөгөөнүүд
final pastConsultationsProvider = Provider<List<ConsultationBooking>>((ref) {
  final allBookings = ref.watch(consultationHistoryProvider);
  final now = DateTime.now();
  return allBookings
      .where(
        (b) =>
            b.status == BookingStatus.completed ||
            b.scheduledTime.isBefore(now),
      )
      .toList()
    ..sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));
});

/// Нийт зөвлөгөөний тоо
final totalConsultationsCountProvider = Provider<int>((ref) {
  return ref.watch(consultationHistoryProvider).length;
});
