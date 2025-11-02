// lib/features/auth/application/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import '../domain/models/auth_state.dart';
import '../domain/models/login_method.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.initial());

  // Утсаар нэвтрэх - OTP илгээх
  Future<void> loginWithPhone(String phone) async {
    state = const AuthState.loading();

    try {
      // TODO: Backend API дуудаж OTP илгээх
      await Future.delayed(const Duration(seconds: 2)); // Mock delay

      // Success: OTP илгээсэн төлөв рүү шилжих
      state = AuthState.otpSent(phone: '+976$phone');
    } catch (e) {
      state = AuthState.error(message: 'OTP илгээхэд алдаа гарлаа: $e');
    }
  }

  // OTP баталгаажуулах
  Future<void> verifyOtp(String phone, String otp) async {
    state = const AuthState.loading();

    try {
      // TODO: Backend API дуудаж OTP шалгах
      await Future.delayed(const Duration(seconds: 1)); // Mock delay

      // Mock: 1234 бол амжилттай
      if (otp == '1234') {
        state = const AuthState.authenticated(userId: 'mock_user_123');
      } else {
        state = const AuthState.error(
          message: 'Баталгаажуулах код буруу байна',
        );
      }
    } catch (e) {
      state = AuthState.error(message: 'Баталгаажуулахад алдаа гарлаа: $e');
    }
  }

  // Нууц үгээр нэвтрэх
  Future<void> loginWithPassword(String phone, String password) async {
    state = const AuthState.loading();

    try {
      // TODO: Backend API дуудаж нэвтрэх
      await Future.delayed(const Duration(seconds: 2)); // Mock delay

      // Mock success
      state = const AuthState.authenticated(userId: 'mock_user_456');
    } catch (e) {
      state = AuthState.error(message: 'Нэвтрэхэд алдаа гарлаа: $e');
    }
  }

  // Social login
  Future<void> loginWithSocial(LoginMethod method) async {
    state = const AuthState.loading();

    try {
      // TODO: Firebase Auth / Social login SDK-г ашиглах
      await Future.delayed(const Duration(seconds: 2)); // Mock delay

      state = const AuthState.authenticated(userId: 'mock_social_789');
    } catch (e) {
      state = AuthState.error(message: 'Нэвтрэхэд алдаа гарлаа: $e');
    }
  }

  // Гарах
  void logout() {
    state = const AuthState.unauthenticated();
  }

  // Error-ийг цэвэрлэх
  void clearError() {
    state = const AuthState.initial();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
