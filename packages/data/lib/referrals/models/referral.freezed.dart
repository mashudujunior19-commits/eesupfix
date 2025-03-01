// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Referral {
  @JsonKey(name: 'referrer_user_id')
  String get referrerUserId;
  @JsonKey(name: 'refereed_user_id')
  String get refereedUserId;
  @JsonKey(name: 'refereed_full_name')
  String get refereedFullName;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'transaction_id')
  int get transactionId;
  @JsonKey(name: 'is_completed')
  bool get isCompleted;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReferralCopyWith<Referral> get copyWith =>
      _$ReferralCopyWithImpl<Referral>(this as Referral, _$identity);

  /// Serializes this Referral to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Referral &&
            (identical(other.referrerUserId, referrerUserId) ||
                other.referrerUserId == referrerUserId) &&
            (identical(other.refereedUserId, refereedUserId) ||
                other.refereedUserId == refereedUserId) &&
            (identical(other.refereedFullName, refereedFullName) ||
                other.refereedFullName == refereedFullName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, referrerUserId, refereedUserId,
      refereedFullName, createdAt, transactionId, isCompleted);

  @override
  String toString() {
    return 'Referral(referrerUserId: $referrerUserId, refereedUserId: $refereedUserId, refereedFullName: $refereedFullName, createdAt: $createdAt, transactionId: $transactionId, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class $ReferralCopyWith<$Res> {
  factory $ReferralCopyWith(Referral value, $Res Function(Referral) _then) =
      _$ReferralCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'referrer_user_id') String referrerUserId,
      @JsonKey(name: 'refereed_user_id') String refereedUserId,
      @JsonKey(name: 'refereed_full_name') String refereedFullName,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'transaction_id') int transactionId,
      @JsonKey(name: 'is_completed') bool isCompleted});
}

/// @nodoc
class _$ReferralCopyWithImpl<$Res> implements $ReferralCopyWith<$Res> {
  _$ReferralCopyWithImpl(this._self, this._then);

  final Referral _self;
  final $Res Function(Referral) _then;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referrerUserId = null,
    Object? refereedUserId = null,
    Object? refereedFullName = null,
    Object? createdAt = null,
    Object? transactionId = null,
    Object? isCompleted = null,
  }) {
    return _then(_self.copyWith(
      referrerUserId: null == referrerUserId
          ? _self.referrerUserId
          : referrerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      refereedUserId: null == refereedUserId
          ? _self.refereedUserId
          : refereedUserId // ignore: cast_nullable_to_non_nullable
              as String,
      refereedFullName: null == refereedFullName
          ? _self.refereedFullName
          : refereedFullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: null == transactionId
          ? _self.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Referral implements Referral {
  const _Referral(
      {@JsonKey(name: 'referrer_user_id') required this.referrerUserId,
      @JsonKey(name: 'refereed_user_id') required this.refereedUserId,
      @JsonKey(name: 'refereed_full_name') required this.refereedFullName,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'transaction_id') required this.transactionId,
      @JsonKey(name: 'is_completed') required this.isCompleted});
  factory _Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);

  @override
  @JsonKey(name: 'referrer_user_id')
  final String referrerUserId;
  @override
  @JsonKey(name: 'refereed_user_id')
  final String refereedUserId;
  @override
  @JsonKey(name: 'refereed_full_name')
  final String refereedFullName;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'transaction_id')
  final int transactionId;
  @override
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReferralCopyWith<_Referral> get copyWith =>
      __$ReferralCopyWithImpl<_Referral>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReferralToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Referral &&
            (identical(other.referrerUserId, referrerUserId) ||
                other.referrerUserId == referrerUserId) &&
            (identical(other.refereedUserId, refereedUserId) ||
                other.refereedUserId == refereedUserId) &&
            (identical(other.refereedFullName, refereedFullName) ||
                other.refereedFullName == refereedFullName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, referrerUserId, refereedUserId,
      refereedFullName, createdAt, transactionId, isCompleted);

  @override
  String toString() {
    return 'Referral(referrerUserId: $referrerUserId, refereedUserId: $refereedUserId, refereedFullName: $refereedFullName, createdAt: $createdAt, transactionId: $transactionId, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class _$ReferralCopyWith<$Res>
    implements $ReferralCopyWith<$Res> {
  factory _$ReferralCopyWith(_Referral value, $Res Function(_Referral) _then) =
      __$ReferralCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'referrer_user_id') String referrerUserId,
      @JsonKey(name: 'refereed_user_id') String refereedUserId,
      @JsonKey(name: 'refereed_full_name') String refereedFullName,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'transaction_id') int transactionId,
      @JsonKey(name: 'is_completed') bool isCompleted});
}

/// @nodoc
class __$ReferralCopyWithImpl<$Res> implements _$ReferralCopyWith<$Res> {
  __$ReferralCopyWithImpl(this._self, this._then);

  final _Referral _self;
  final $Res Function(_Referral) _then;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? referrerUserId = null,
    Object? refereedUserId = null,
    Object? refereedFullName = null,
    Object? createdAt = null,
    Object? transactionId = null,
    Object? isCompleted = null,
  }) {
    return _then(_Referral(
      referrerUserId: null == referrerUserId
          ? _self.referrerUserId
          : referrerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      refereedUserId: null == refereedUserId
          ? _self.refereedUserId
          : refereedUserId // ignore: cast_nullable_to_non_nullable
              as String,
      refereedFullName: null == refereedFullName
          ? _self.refereedFullName
          : refereedFullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: null == transactionId
          ? _self.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
