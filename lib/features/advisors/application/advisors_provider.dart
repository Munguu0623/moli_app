// lib/features/advisors/application/advisors_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/mock_advisors.dart';
import '../domain/models/advisor.dart';
import '../domain/models/advisor_filter.dart';
import '../domain/models/chat_message.dart';
import '../domain/models/consultation_booking.dart';

/// Зөвлөхүүдийн жагсаалт (AsyncNotifier)
final advisorsProvider = AsyncNotifierProvider<AdvisorsNotifier, List<Advisor>>(
  AdvisorsNotifier.new,
);

class AdvisorsNotifier extends AsyncNotifier<List<Advisor>> {
  @override
  Future<List<Advisor>> build() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return mockAdvisors;
  }

  /// Хайлт + шүүлтүүр логик
  Future<void> applyFilter(AdvisorFilter filter) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(milliseconds: 300));

      var filtered = mockAdvisors;

      // Keyword хайлт (нэр, албан тушаал, мэргэжил)
      if (filter.keyword.isNotEmpty) {
        final keyword = filter.keyword.toLowerCase();
        filtered =
            filtered.where((a) {
              return a.name.toLowerCase().contains(keyword) ||
                  a.title.toLowerCase().contains(keyword) ||
                  a.bio.toLowerCase().contains(keyword);
            }).toList();
      }

      // Мэргэжлийн чиглэл шүүх
      if (filter.expertise.isNotEmpty) {
        filtered =
            filtered.where((a) {
              return a.expertise.any((e) => filter.expertise.contains(e));
            }).toList();
      }

      // Үнийн шүүлтүүр
      final minPrice = filter.priceRange.start.toInt();
      final maxPrice = filter.priceRange.end.toInt();
      filtered =
          filtered.where((a) {
            final chatPrice = a.pricing[ConsultationType.chat] ?? 0;
            final videoPrice = a.pricing[ConsultationType.video] ?? 0;
            final minAdvisorPrice =
                chatPrice < videoPrice ? chatPrice : videoPrice;
            return minAdvisorPrice >= minPrice && minAdvisorPrice <= maxPrice;
          }).toList();

      // Хэлний шүүлтүүр
      if (filter.languages.isNotEmpty) {
        filtered =
            filtered.where((a) {
              return a.languages.any((lang) => filter.languages.contains(lang));
            }).toList();
      }

      // Өнөөдөр боломжтой эсэх
      if (filter.availableToday) {
        filtered = filtered.where((a) => a.isAvailableToday).toList();
      }

      return filtered;
    });
  }

  /// Дахин ачаалах
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      return mockAdvisors;
    });
  }
}

/// Тодорхой зөвлөхийн дэлгэрэнгүй мэдээлэл авах
final advisorDetailProvider = FutureProvider.family<Advisor?, String>((
  ref,
  advisorId,
) async {
  await Future.delayed(const Duration(milliseconds: 200));
  return mockAdvisors.where((a) => a.id == advisorId).firstOrNull;
});

/// Зөвлөхийн үнэлгээнүүд
final advisorReviewsProvider = Provider.family<List<AdvisorReview>, String>((
  ref,
  advisorId,
) {
  return mockReviews[advisorId] ?? [];
});

/// Чатын мессежүүд
final chatMessagesProvider = Provider.family<List<ChatMessage>, String>((
  ref,
  advisorId,
) {
  return getMockMessages(advisorId);
});

/// Одоогийн шүүлтүүр
final currentAdvisorFilterProvider = StateProvider<AdvisorFilter>((ref) {
  return const AdvisorFilter();
});

/// Миний зөвлөгөөнүүд (mock)
final myBookingsProvider =
    StateNotifierProvider<MyBookingsNotifier, List<ConsultationBooking>>((ref) {
      return MyBookingsNotifier();
    });

class MyBookingsNotifier extends StateNotifier<List<ConsultationBooking>> {
  MyBookingsNotifier() : super([]);

  /// Зөвлөгөө нэмэх
  void addBooking(ConsultationBooking booking) {
    state = [...state, booking];
  }

  /// Статус өөрчлөх
  void updateStatus(String bookingId, BookingStatus newStatus) {
    state = [
      for (final booking in state)
        if (booking.id == bookingId)
          booking.copyWith(status: newStatus)
        else
          booking,
    ];
  }

  /// Цуцлах
  void cancelBooking(String bookingId) {
    updateStatus(bookingId, BookingStatus.cancelled);
  }
}

/// Зөвлөгөө товлох (create booking)
final bookingProvider =
    StateNotifierProvider<BookingNotifier, AsyncValue<ConsultationBooking?>>(
      (ref) => BookingNotifier(ref),
    );

class BookingNotifier extends StateNotifier<AsyncValue<ConsultationBooking?>> {
  BookingNotifier(this.ref) : super(const AsyncValue.data(null));
  final Ref ref;

  Future<void> createBooking({
    required String advisorId,
    required String advisorName,
    required String advisorImageUrl,
    required DateTime scheduledTime,
    required ConsultationType type,
    required int price,
    String? topic,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(milliseconds: 800));

      final booking = ConsultationBooking(
        id: 'booking_${DateTime.now().millisecondsSinceEpoch}',
        studentId: 'student_001',
        advisorId: advisorId,
        advisorName: advisorName,
        advisorImageUrl: advisorImageUrl,
        scheduledTime: scheduledTime,
        type: type,
        status: BookingStatus.pending,
        topic: topic,
        price: price,
        createdAt: DateTime.now(),
      );

      // Add to my bookings
      ref.read(myBookingsProvider.notifier).addBooking(booking);

      return booking;
    });
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Хүлээгдэж буй зөвлөгөөнүүд
final upcomingBookingsProvider = Provider<List<ConsultationBooking>>((ref) {
  final allBookings = ref.watch(myBookingsProvider);
  return allBookings
      .where(
        (b) =>
            b.status == BookingStatus.pending ||
            b.status == BookingStatus.approved,
      )
      .toList()
    ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
});

/// Дууссан зөвлөгөөнүүд
final completedBookingsProvider = Provider<List<ConsultationBooking>>((ref) {
  final allBookings = ref.watch(myBookingsProvider);
  return allBookings.where((b) => b.status == BookingStatus.completed).toList()
    ..sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));
});

/// Цуцлагдсан зөвлөгөөнүүд
final cancelledBookingsProvider = Provider<List<ConsultationBooking>>((ref) {
  final allBookings = ref.watch(myBookingsProvider);
  return allBookings.where((b) => b.status == BookingStatus.cancelled).toList()
    ..sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));
});
