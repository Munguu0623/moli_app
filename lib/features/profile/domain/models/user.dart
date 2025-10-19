// lib/features/profile/domain/models/user.dart

/// Subscription tier
enum SubscriptionTier {
  free,
  premium;

  String get label {
    switch (this) {
      case SubscriptionTier.free:
        return 'Free';
      case SubscriptionTier.premium:
        return 'Premium';
    }
  }

  String get emoji {
    switch (this) {
      case SubscriptionTier.free:
        return '🆓';
      case SubscriptionTier.premium:
        return '💎';
    }
  }
}

/// Хэрэглэгчийн модель
class User {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final SubscriptionTier subscriptionTier;
  final DateTime? subscriptionExpiryDate;
  final bool autoRenewal;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.subscriptionTier,
    this.subscriptionExpiryDate,
    this.autoRenewal = false,
  });

  /// Premium эсэх
  bool get isPremium => subscriptionTier == SubscriptionTier.premium;

  /// Subscription дууссан эсэх
  bool get isSubscriptionExpired {
    if (subscriptionExpiryDate == null) return false;
    return DateTime.now().isAfter(subscriptionExpiryDate!);
  }

  /// Subscription badge text
  String get subscriptionBadge {
    if (isPremium && !isSubscriptionExpired) {
      return '${subscriptionTier.label} ${subscriptionTier.emoji}';
    }
    return subscriptionTier.label;
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    SubscriptionTier? subscriptionTier,
    DateTime? subscriptionExpiryDate,
    bool? autoRenewal,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      subscriptionTier: subscriptionTier ?? this.subscriptionTier,
      subscriptionExpiryDate:
          subscriptionExpiryDate ?? this.subscriptionExpiryDate,
      autoRenewal: autoRenewal ?? this.autoRenewal,
    );
  }
}
