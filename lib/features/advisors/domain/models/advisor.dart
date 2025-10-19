// lib/features/advisors/domain/models/advisor.dart

/// Зөвлөхийн мэргэжлийн чиглэл
enum AdvisorExpertise {
  career,
  university,
  scholarship,
  major,
  other;

  String get label {
    switch (this) {
      case AdvisorExpertise.career:
        return 'Карьер';
      case AdvisorExpertise.university:
        return 'Их сургууль';
      case AdvisorExpertise.scholarship:
        return 'Тэтгэлэг';
      case AdvisorExpertise.major:
        return 'Мэргэжил';
      case AdvisorExpertise.other:
        return 'Бусад';
    }
  }

  String get tag {
    switch (this) {
      case AdvisorExpertise.career:
        return '#CareerPlanning';
      case AdvisorExpertise.university:
        return '#UniversityAdvice';
      case AdvisorExpertise.scholarship:
        return '#Scholarship';
      case AdvisorExpertise.major:
        return '#MajorSelection';
      case AdvisorExpertise.other:
        return '#General';
    }
  }
}

/// Зөвлөгөөний төрөл
enum ConsultationType {
  chat,
  video;

  String get label {
    switch (this) {
      case ConsultationType.chat:
        return 'Чат';
      case ConsultationType.video:
        return 'Видео';
    }
  }

  String get icon {
    switch (this) {
      case ConsultationType.chat:
        return '💬';
      case ConsultationType.video:
        return '🎥';
    }
  }
}

/// Зөвлөх entity модель
class Advisor {
  final String id;
  final String name;
  final String title; // "МУИС - IT багш"
  final String imageUrl;
  final List<AdvisorExpertise> expertise;
  final double rating; // 0.0 - 5.0
  final int reviewCount;
  final String bio;
  final int experienceYears;
  final List<String> languages; // ["Монгол", "English"]
  final bool verified;
  final Map<ConsultationType, int> pricing; // {chat: 5000, video: 10000}
  final List<DateTime> availableSlots; // next 14 days
  final bool isAvailableToday;

  const Advisor({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
    required this.expertise,
    required this.rating,
    required this.reviewCount,
    required this.bio,
    required this.experienceYears,
    required this.languages,
    required this.verified,
    required this.pricing,
    required this.availableSlots,
    required this.isAvailableToday,
  });

  /// Үнийн мэдээлэл форматтай
  String getPriceLabel(ConsultationType type) {
    final price = pricing[type];
    if (price == null || price == 0) return 'Үнэгүй';
    return '${_formatPrice(price)}₮';
  }

  /// Хоёр төрлийн үнийг харуулах
  String get fullPriceLabel {
    final chatPrice = pricing[ConsultationType.chat] ?? 0;
    final videoPrice = pricing[ConsultationType.video] ?? 0;

    if (chatPrice == 0 && videoPrice == 0) return 'Үнэгүй зөвлөгөө';
    if (chatPrice == 0) return 'Video – ${_formatPrice(videoPrice)}₮';
    if (videoPrice == 0) return 'Chat – ${_formatPrice(chatPrice)}₮';

    return 'Chat – ${_formatPrice(chatPrice)}₮ / Video – ${_formatPrice(videoPrice)}₮';
  }

  /// Туршлагын мэдээлэл
  String get experienceLabel => '$experienceYears жил туршлагатай';

  /// Хэлний жагсаалт
  String get languagesList => languages.join(' / ');

  String _formatPrice(int price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(price % 1000 == 0 ? 0 : 1)}k';
    }
    return price.toString();
  }
}
