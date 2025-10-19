// lib/features/advisors/domain/models/chat_message.dart

/// Чатын мессеж модель
class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });

  /// Цаг форматтай
  String get timeLabel {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

/// Зөвлөхийн үнэлгээ (Review)
class AdvisorReview {
  final String id;
  final String studentName;
  final String? studentAvatarUrl;
  final int rating; // 1-5
  final String comment;
  final DateTime date;

  const AdvisorReview({
    required this.id,
    required this.studentName,
    this.studentAvatarUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });

  /// Огноо форматтай
  String get dateLabel {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'Өнөөдөр';
    if (diff.inDays == 1) return 'Өчигдөр';
    if (diff.inDays < 7) return '${diff.inDays} өдрийн өмнө';
    if (diff.inDays < 30)
      return '${(diff.inDays / 7).floor()} долоо хоногийн өмнө';
    if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()} сарын өмнө';
    }
    return '${(diff.inDays / 365).floor()} жилийн өмнө';
  }
}
