// lib/app/di/subscription_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Premium эрхийн төлөв удирдах provider
/// Одоогоор mock false (premium биш), дараа нь API-тай холбоно
final premiumSubscriptionProvider = StateProvider<bool>((ref) {
  return false; // Default: premium биш
});

/// Premium статусыг шалгах utility provider
final isPremiumProvider = Provider<bool>((ref) {
  return ref.watch(premiumSubscriptionProvider);
});
