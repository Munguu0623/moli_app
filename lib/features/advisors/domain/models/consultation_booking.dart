// lib/features/advisors/domain/models/consultation_booking.dart

import 'advisor.dart';

/// Зөвлөгөөний статус
enum BookingStatus {
  pending,
  approved,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case BookingStatus.pending:
        return 'Хүлээгдэж буй';
      case BookingStatus.approved:
        return 'Баталгаажсан';
      case BookingStatus.completed:
        return 'Дууссан';
      case BookingStatus.cancelled:
        return 'Цуцлагдсан';
    }
  }

  String get emoji {
    switch (this) {
      case BookingStatus.pending:
        return '⏳';
      case BookingStatus.approved:
        return '✅';
      case BookingStatus.completed:
        return '🎉';
      case BookingStatus.cancelled:
        return '❌';
    }
  }
}

/// Зөвлөгөө товлох модель
class ConsultationBooking {
  final String id;
  final String studentId;
  final String advisorId;
  final String advisorName;
  final String advisorImageUrl;
  final DateTime scheduledTime;
  final ConsultationType type;
  final BookingStatus status;
  final String? topic;
  final int price;
  final DateTime createdAt;

  const ConsultationBooking({
    required this.id,
    required this.studentId,
    required this.advisorId,
    required this.advisorName,
    required this.advisorImageUrl,
    required this.scheduledTime,
    required this.type,
    required this.status,
    this.topic,
    required this.price,
    required this.createdAt,
  });

  /// Цаг форматтай харуулах
  String get timeLabel {
    final hour = scheduledTime.hour.toString().padLeft(2, '0');
    final minute = scheduledTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Огноо форматтай харуулах
  String get dateLabel {
    final months = [
      'Нэг',
      'Хоёр',
      'Гурав',
      'Дөрөв',
      'Тав',
      'Зургаа',
      'Долоо',
      'Найм',
      'Ес',
      'Арав',
      'Арван нэг',
      'Арван хоёр',
    ];
    return '${months[scheduledTime.month - 1]}-р сарын ${scheduledTime.day}';
  }

  /// Зөвлөгөө эхлэх боломжтой эсэх (approved + цаг нь одоо)
  bool get canJoin {
    if (status != BookingStatus.approved) return false;
    final now = DateTime.now();
    final diff = scheduledTime.difference(now);
    // 10 минутын өмнөөс эхлүүлж болно
    return diff.inMinutes <= 10 && diff.inMinutes >= -30;
  }

  ConsultationBooking copyWith({
    String? id,
    String? studentId,
    String? advisorId,
    String? advisorName,
    String? advisorImageUrl,
    DateTime? scheduledTime,
    ConsultationType? type,
    BookingStatus? status,
    String? topic,
    int? price,
    DateTime? createdAt,
  }) {
    return ConsultationBooking(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      advisorId: advisorId ?? this.advisorId,
      advisorName: advisorName ?? this.advisorName,
      advisorImageUrl: advisorImageUrl ?? this.advisorImageUrl,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      type: type ?? this.type,
      status: status ?? this.status,
      topic: topic ?? this.topic,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
