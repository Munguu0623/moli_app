import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_verification.freezed.dart'; // ← энэ мөрийг нэм

@freezed
class OtpVerification with _$OtpVerification {
  const factory OtpVerification({
    required String phone,
    required String otp,
    required DateTime sentAt,
    @Default(60) int expiresInSeconds,
  }) = _OtpVerification;

  @override
  // TODO: implement expiresInSeconds
  int get expiresInSeconds => throw UnimplementedError();

  @override
  // TODO: implement otp
  String get otp => throw UnimplementedError();

  @override
  // TODO: implement phone
  String get phone => throw UnimplementedError();

  @override
  // TODO: implement sentAt
  DateTime get sentAt => throw UnimplementedError();
}