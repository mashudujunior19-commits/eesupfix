// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Referral _$ReferralFromJson(Map<String, dynamic> json) {
  return _Referral.fromJson(json);
}

/// @nodoc
mixin _$Referral {
  @JsonKey(name: 'referrer_user_id')
  String get referrerUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'refereed_user_id')
  String get refereedUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'refereed_full_name')
  String get refereedFullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_id')
  int get transactionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_completed')
  bool get isCompleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferralCopyWith<Referral> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralCopyWith<$Res> {
  factory $ReferralCopyWith(Referral value, $Res Function(Referral) then) =
      _$ReferralCopyWithImpl<$Res, Referral>;
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
class _$ReferralCopyWithImpl<$Res, $Val extends Referral>
    implements $ReferralCopyWith<$Res> {
  _$ReferralCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      referrerUserId: null == referrerUserId
          ? _value.referrerUserId
          : referrerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      refereedUserId: null == refereedUserId
          ? _value.refereedUserId
          : refereedUserId // ignore: cast_nullable_to_non_nullable
              as String,
      refereedFullName: null == refereedFullName
          ? _value.refereedFullName
          : refereedFullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferralImplCopyWith<$Res>
    implements $ReferralCopyWith<$Res> {
  factory _$$ReferralImplCopyWith(
          _$ReferralImpl value, $Res Function(_$ReferralImpl) then) =
      __$$ReferralImplCopyWithImpl<$Res>;
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
class __$$ReferralImplCopyWithImpl<$Res>
    extends _$ReferralCopyWithImpl<$Res, _$ReferralImpl>
    implements _$$ReferralImplCopyWith<$Res> {
  __$$ReferralImplCopyWithImpl(
      _$ReferralImpl _value, $Res Function(_$ReferralImpl) _then)
      : super(_value, _then);

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
    return _then(_$ReferralImpl(
      referrerUserId: null == referrerUserId
          ? _value.referrerUserId
          : referrerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      refereedUserId: null == refereedUserId
          ? _value.refereedUserId
          : refereedUserId // ignore: cast_nullable_to_non_nullable
              as String,
      refereedFullName: null == refereedFullName
          ? _value.refereedFullName
          : refereedFullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReferralImpl implements _Referral {
  const _$ReferralImpl(
      {@JsonKey(name: 'referrer_user_id') required this.referrerUserId,
      @JsonKey(name: 'refereed_user_id') required this.refereedUserId,
      @JsonKey(name: 'refereed_full_name') required this.refereedFullName,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'transaction_id') required this.transactionId,
      @JsonKey(name: 'is_completed') required this.isCompleted});

  factory _$ReferralImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferralImplFromJson(json);

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

  @override
  String toString() {
    return 'Referral(referrerUserId: $referrerUserId, refereedUserId: $refereedUserId, refereedFullName: $refereedFullName, createdAt: $createdAt, transactionId: $transactionId, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, referrerUserId, refereedUserId,
      refereedFullName, createdAt, transactionId, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralImplCopyWith<_$ReferralImpl> get copyWith =>
      __$$ReferralImplCopyWithImpl<_$ReferralImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferralImplToJson(
      this,
    );
  }
}

abstract class _Referral implements Referral {
  const factory _Referral(
      {@JsonKey(name: 'referrer_user_id') required final String referrerUserId,
      @JsonKey(name: 'refereed_user_id') required final String refereedUserId,
      @JsonKey(name: 'refereed_full_name')
      required final String refereedFullName,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'transaction_id') required final int transactionId,
      @JsonKey(name: 'is_completed')
      required final bool isCompleted}) = _$ReferralImpl;

  factory _Referral.fromJson(Map<String, dynamic> json) =
      _$ReferralImpl.fromJson;

  @override
  @JsonKey(name: 'referrer_user_id')
  String get referrerUserId;
  @override
  @JsonKey(name: 'refereed_user_id')
  String get refereedUserId;
  @override
  @JsonKey(name: 'refereed_full_name')
  String get refereedFullName;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'transaction_id')
  int get transactionId;
  @override
  @JsonKey(name: 'is_completed')
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$$ReferralImplCopyWith<_$ReferralImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
