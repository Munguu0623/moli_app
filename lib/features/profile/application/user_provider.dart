// lib/features/profile/application/user_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../domain/models/user.dart';

/// Mock хэрэглэгч provider
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
    : super(
        const User(
          id: 'user_001',
          name: 'Номин-Эрдэнэ',
          email: 'nomin@example.com',
          profileImageUrl: null, // Mock data - зураггүй
          subscriptionTier: SubscriptionTier.premium,
          subscriptionExpiryDate: null, // Will be set below
          autoRenewal: true,
        ),
      ) {
    // Premium subscription - 2025.12.01 хүртэл
    state = state.copyWith(subscriptionExpiryDate: DateTime(2025, 12, 1));
  }

  /// Profile засах
  void updateProfile({String? name, String? email, String? profileImageUrl}) {
    state = state.copyWith(
      name: name,
      email: email,
      profileImageUrl: profileImageUrl,
    );
  }

  /// Subscription шинэчлэх
  void updateSubscription({
    SubscriptionTier? tier,
    DateTime? expiryDate,
    bool? autoRenewal,
  }) {
    state = state.copyWith(
      subscriptionTier: tier,
      subscriptionExpiryDate: expiryDate,
      autoRenewal: autoRenewal,
    );
  }

  /// Premium болох
  void upgradeToPremium() {
    final expiryDate = DateTime.now().add(const Duration(days: 365));
    state = state.copyWith(
      subscriptionTier: SubscriptionTier.premium,
      subscriptionExpiryDate: expiryDate,
      autoRenewal: true,
    );
  }

  /// Premium цуцлах
  void cancelPremium() {
    state = state.copyWith(
      subscriptionTier: SubscriptionTier.free,
      subscriptionExpiryDate: null,
      autoRenewal: false,
    );
  }

  /// Auto renewal тохируулах
  void setAutoRenewal(bool enabled) {
    state = state.copyWith(autoRenewal: enabled);
  }
}

/// Хэрэглэгчийн нэр
final userNameProvider = Provider<String>((ref) {
  return ref.watch(userProvider).name;
});

/// Хэрэглэгчийн имэйл
final userEmailProvider = Provider<String>((ref) {
  return ref.watch(userProvider).email;
});

/// Premium эсэх
final userIsPremiumProvider = Provider<bool>((ref) {
  return ref.watch(userProvider).isPremium;
});
