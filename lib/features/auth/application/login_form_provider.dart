// lib/features/auth/application/login_form_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/login_method.dart';

// Login method selector (Phone vs Password)
final loginMethodProvider = StateProvider<LoginMethod>(
  (ref) => LoginMethod.phone,
);

// OTP resend timer
class OtpTimerNotifier extends StateNotifier<int> {
  OtpTimerNotifier() : super(60);

  void startTimer() {
    state = 60;
    _countdown();
  }

  void _countdown() async {
    while (state > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        state = state - 1;
      }
    }
  }

  void reset() {
    state = 60;
  }
}

final otpTimerProvider = StateNotifierProvider<OtpTimerNotifier, int>((ref) {
  return OtpTimerNotifier();
});

// Form validation states
final phoneValidationProvider = StateProvider<String?>((ref) => null);
final passwordValidationProvider = StateProvider<String?>((ref) => null);
final otpValidationProvider = StateProvider<String?>((ref) => null);
