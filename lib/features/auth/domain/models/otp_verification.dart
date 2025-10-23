// lib/features/auth/domain/models/otp_verification.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_verification.freezed.dart';

@freezed
class OtpVerification with _$OtpVerification {
  const factory OtpVerification({
    required String phone,
    required String otp,
    required DateTime sentAt,
    @Default(60) int expiresInSeconds,
  }) = _OtpVerification;
}
