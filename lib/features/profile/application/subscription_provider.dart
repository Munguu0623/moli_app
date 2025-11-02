// lib/features/profile/application/subscription_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'user_provider.dart';

/// Payment status
enum PaymentStatus {
  idle,
  processing,
  success,
  failed;

  String get label {
    switch (this) {
      case PaymentStatus.idle:
        return 'Хүлээгдэж буй';
      case PaymentStatus.processing:
        return 'Төлж байна...';
      case PaymentStatus.success:
        return 'Амжилттай';
      case PaymentStatus.failed:
        return 'Алдаа гарлаа';
    }
  }
}

/// Payment provider (QPay mock)
final paymentStatusProvider =
    StateNotifierProvider<PaymentStatusNotifier, PaymentStatus>((ref) {
      return PaymentStatusNotifier();
    });

class PaymentStatusNotifier extends StateNotifier<PaymentStatus> {
  PaymentStatusNotifier() : super(PaymentStatus.idle);

  /// Mock payment processing
  Future<bool> processPayment(int amount) async {
    state = PaymentStatus.processing;

    // Simulate payment delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock success (90% success rate)
    final success = DateTime.now().millisecond % 10 != 0;

    state = success ? PaymentStatus.success : PaymentStatus.failed;

    // Reset to idle after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        state = PaymentStatus.idle;
      }
    });

    return success;
  }

  void reset() {
    state = PaymentStatus.idle;
  }
}

/// Subscription management
final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService(ref);
});

class SubscriptionService {
  final Ref ref;

  SubscriptionService(this.ref);

  /// Premium болох
  Future<bool> upgradeToPremium() async {
    final paymentNotifier = ref.read(paymentStatusProvider.notifier);
    final userNotifier = ref.read(userProvider.notifier);

    // Mock price: 120,000 MNT for 1 year
    final success = await paymentNotifier.processPayment(120000);

    if (success) {
      userNotifier.upgradeToPremium();
    }

    return success;
  }

  /// Subscription шинэчлэх
  Future<bool> renewSubscription() async {
    final paymentNotifier = ref.read(paymentStatusProvider.notifier);
    final userNotifier = ref.read(userProvider.notifier);

    final success = await paymentNotifier.processPayment(120000);

    if (success) {
      final newExpiry = DateTime.now().add(const Duration(days: 365));
      userNotifier.updateSubscription(expiryDate: newExpiry);
    }

    return success;
  }

  /// Auto renewal тохируулах
  void setAutoRenewal(bool enabled) {
    ref.read(userProvider.notifier).setAutoRenewal(enabled);
  }

  /// Premium цуцлах
  void cancelPremium() {
    ref.read(userProvider.notifier).cancelPremium();
  }
}

/// Premium features list
final premiumFeaturesProvider = Provider<List<PremiumFeature>>((ref) {
  return const [
    PremiumFeature(
      icon: '💬',
      title: 'Хязгааргүй зөвлөгөө',
      description: 'Мэргэжлийн зөвлөх нартай хязгааргүй чатлах',
    ),
    PremiumFeature(
      icon: '📊',
      title: 'Дэлгэрэнгүй тайлан',
      description: 'Тестийн үр дүнгийн дэлгэрэнгүй задаргаа',
    ),
    PremiumFeature(
      icon: '🎯',
      title: 'Хувийн зөвлөгөө',
      description: 'Танд тусгайлан боловсруулсан мэргэжлийн зөвлөгөө',
    ),
    PremiumFeature(
      icon: '⭐',
      title: 'Онцгой контент',
      description: 'Premium хичээл, сургалтууд',
    ),
    PremiumFeature(
      icon: '📱',
      title: 'Мэдэгдэл',
      description: 'Элсэлтийн мэдээлэл, хугацааны сануулга',
    ),
    PremiumFeature(
      icon: '🔔',
      title: 'Тусгай санал',
      description: 'Premium гишүүдэд зориулсан хөнгөлөлт',
    ),
  ];
});

/// Premium feature model
class PremiumFeature {
  final String icon;
  final String title;
  final String description;

  const PremiumFeature({
    required this.icon,
    required this.title,
    required this.description,
  });
}
