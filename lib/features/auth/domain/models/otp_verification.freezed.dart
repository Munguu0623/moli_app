// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_verification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtpVerification {
  String get phone;
  String get otp;
  DateTime get sentAt;
  int get expiresInSeconds;

  /// Create a copy of OtpVerification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OtpVerificationCopyWith<OtpVerification> get copyWith =>
      _$OtpVerificationCopyWithImpl<OtpVerification>(
          this as OtpVerification, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtpVerification &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.expiresInSeconds, expiresInSeconds) ||
                other.expiresInSeconds == expiresInSeconds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phone, otp, sentAt, expiresInSeconds);

  @override
  String toString() {
    return 'OtpVerification(phone: $phone, otp: $otp, sentAt: $sentAt, expiresInSeconds: $expiresInSeconds)';
  }
}

/// @nodoc
abstract mixin class $OtpVerificationCopyWith<$Res> {
  factory $OtpVerificationCopyWith(
          OtpVerification value, $Res Function(OtpVerification) _then) =
      _$OtpVerificationCopyWithImpl;
  @useResult
  $Res call({String phone, String otp, DateTime sentAt, int expiresInSeconds});
}

/// @nodoc
class _$OtpVerificationCopyWithImpl<$Res>
    implements $OtpVerificationCopyWith<$Res> {
  _$OtpVerificationCopyWithImpl(this._self, this._then);

  final OtpVerification _self;
  final $Res Function(OtpVerification) _then;

  /// Create a copy of OtpVerification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? otp = null,
    Object? sentAt = null,
    Object? expiresInSeconds = null,
  }) {
    return _then(_self.copyWith(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _self.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: null == sentAt
          ? _self.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresInSeconds: null == expiresInSeconds
          ? _self.expiresInSeconds
          : expiresInSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [OtpVerification].
extension OtpVerificationPatterns on OtpVerification {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_OtpVerification value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OtpVerification() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_OtpVerification value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OtpVerification():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_OtpVerification value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OtpVerification() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String phone, String otp, DateTime sentAt, int expiresInSeconds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OtpVerification() when $default != null:
        return $default(
            _that.phone, _that.otp, _that.sentAt, _that.expiresInSeconds);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String phone, String otp, DateTime sentAt, int expiresInSeconds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OtpVerification():
        return $default(
            _that.phone, _that.otp, _that.sentAt, _that.expiresInSeconds);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String phone, String otp, DateTime sentAt, int expiresInSeconds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OtpVerification() when $default != null:
        return $default(
            _that.phone, _that.otp, _that.sentAt, _that.expiresInSeconds);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OtpVerification implements OtpVerification {
  const _OtpVerification(
      {required this.phone,
      required this.otp,
      required this.sentAt,
      this.expiresInSeconds = 60});

  @override
  final String phone;
  @override
  final String otp;
  @override
  final DateTime sentAt;
  @override
  @JsonKey()
  final int expiresInSeconds;

  /// Create a copy of OtpVerification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OtpVerificationCopyWith<_OtpVerification> get copyWith =>
      __$OtpVerificationCopyWithImpl<_OtpVerification>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtpVerification &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.expiresInSeconds, expiresInSeconds) ||
                other.expiresInSeconds == expiresInSeconds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phone, otp, sentAt, expiresInSeconds);

  @override
  String toString() {
    return 'OtpVerification(phone: $phone, otp: $otp, sentAt: $sentAt, expiresInSeconds: $expiresInSeconds)';
  }
}

/// @nodoc
abstract mixin class _$OtpVerificationCopyWith<$Res>
    implements $OtpVerificationCopyWith<$Res> {
  factory _$OtpVerificationCopyWith(
          _OtpVerification value, $Res Function(_OtpVerification) _then) =
      __$OtpVerificationCopyWithImpl;
  @override
  @useResult
  $Res call({String phone, String otp, DateTime sentAt, int expiresInSeconds});
}

/// @nodoc
class __$OtpVerificationCopyWithImpl<$Res>
    implements _$OtpVerificationCopyWith<$Res> {
  __$OtpVerificationCopyWithImpl(this._self, this._then);

  final _OtpVerification _self;
  final $Res Function(_OtpVerification) _then;

  /// Create a copy of OtpVerification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = null,
    Object? otp = null,
    Object? sentAt = null,
    Object? expiresInSeconds = null,
  }) {
    return _then(_OtpVerification(
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _self.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: null == sentAt
          ? _self.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresInSeconds: null == expiresInSeconds
          ? _self.expiresInSeconds
          : expiresInSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
