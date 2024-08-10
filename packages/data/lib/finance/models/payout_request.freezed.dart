// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payout_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayoutRequest _$PayoutRequestFromJson(Map<String, dynamic> json) {
  return _PayoutRequest.fromJson(json);
}

/// @nodoc
mixin _$PayoutRequest {
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get bank => throw _privateConstructorUsedError;
  @JsonKey(name: 'acc_number')
  String get accNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'acc_name')
  String get accName => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_code')
  String get branchCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_at', includeToJson: false)
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'acc_holder')
  String get accHolder => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'wallet_id')
  int get walletId => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_id', includeToJson: false)
  int? get transactionId => throw _privateConstructorUsedError;

  /// Serializes this PayoutRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayoutRequestCopyWith<PayoutRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayoutRequestCopyWith<$Res> {
  factory $PayoutRequestCopyWith(
          PayoutRequest value, $Res Function(PayoutRequest) then) =
      _$PayoutRequestCopyWithImpl<$Res, PayoutRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      String bank,
      @JsonKey(name: 'acc_number') String accNumber,
      @JsonKey(name: 'acc_name') String accName,
      @JsonKey(name: 'branch_code') String branchCode,
      @JsonKey(name: 'approved_at', includeToJson: false) DateTime? approvedAt,
      @JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'acc_holder') String accHolder,
      double amount,
      @JsonKey(name: 'wallet_id') int walletId,
      @JsonKey(name: 'transaction_id', includeToJson: false)
      int? transactionId});
}

/// @nodoc
class _$PayoutRequestCopyWithImpl<$Res, $Val extends PayoutRequest>
    implements $PayoutRequestCopyWith<$Res> {
  _$PayoutRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? bank = null,
    Object? accNumber = null,
    Object? accName = null,
    Object? branchCode = null,
    Object? approvedAt = freezed,
    Object? id = null,
    Object? accHolder = null,
    Object? amount = null,
    Object? walletId = null,
    Object? transactionId = freezed,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bank: null == bank
          ? _value.bank
          : bank // ignore: cast_nullable_to_non_nullable
              as String,
      accNumber: null == accNumber
          ? _value.accNumber
          : accNumber // ignore: cast_nullable_to_non_nullable
              as String,
      accName: null == accName
          ? _value.accName
          : accName // ignore: cast_nullable_to_non_nullable
              as String,
      branchCode: null == branchCode
          ? _value.branchCode
          : branchCode // ignore: cast_nullable_to_non_nullable
              as String,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      accHolder: null == accHolder
          ? _value.accHolder
          : accHolder // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      walletId: null == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayoutRequestImplCopyWith<$Res>
    implements $PayoutRequestCopyWith<$Res> {
  factory _$$PayoutRequestImplCopyWith(
          _$PayoutRequestImpl value, $Res Function(_$PayoutRequestImpl) then) =
      __$$PayoutRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      String bank,
      @JsonKey(name: 'acc_number') String accNumber,
      @JsonKey(name: 'acc_name') String accName,
      @JsonKey(name: 'branch_code') String branchCode,
      @JsonKey(name: 'approved_at', includeToJson: false) DateTime? approvedAt,
      @JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'acc_holder') String accHolder,
      double amount,
      @JsonKey(name: 'wallet_id') int walletId,
      @JsonKey(name: 'transaction_id', includeToJson: false)
      int? transactionId});
}

/// @nodoc
class __$$PayoutRequestImplCopyWithImpl<$Res>
    extends _$PayoutRequestCopyWithImpl<$Res, _$PayoutRequestImpl>
    implements _$$PayoutRequestImplCopyWith<$Res> {
  __$$PayoutRequestImplCopyWithImpl(
      _$PayoutRequestImpl _value, $Res Function(_$PayoutRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? bank = null,
    Object? accNumber = null,
    Object? accName = null,
    Object? branchCode = null,
    Object? approvedAt = freezed,
    Object? id = null,
    Object? accHolder = null,
    Object? amount = null,
    Object? walletId = null,
    Object? transactionId = freezed,
  }) {
    return _then(_$PayoutRequestImpl(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bank: null == bank
          ? _value.bank
          : bank // ignore: cast_nullable_to_non_nullable
              as String,
      accNumber: null == accNumber
          ? _value.accNumber
          : accNumber // ignore: cast_nullable_to_non_nullable
              as String,
      accName: null == accName
          ? _value.accName
          : accName // ignore: cast_nullable_to_non_nullable
              as String,
      branchCode: null == branchCode
          ? _value.branchCode
          : branchCode // ignore: cast_nullable_to_non_nullable
              as String,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      accHolder: null == accHolder
          ? _value.accHolder
          : accHolder // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      walletId: null == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayoutRequestImpl implements _PayoutRequest {
  const _$PayoutRequestImpl(
      {@JsonKey(name: 'created_at', includeToJson: false)
      required this.createdAt,
      required this.bank,
      @JsonKey(name: 'acc_number') required this.accNumber,
      @JsonKey(name: 'acc_name') required this.accName,
      @JsonKey(name: 'branch_code') required this.branchCode,
      @JsonKey(name: 'approved_at', includeToJson: false) this.approvedAt,
      @JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'acc_holder') required this.accHolder,
      required this.amount,
      @JsonKey(name: 'wallet_id') required this.walletId,
      @JsonKey(name: 'transaction_id', includeToJson: false)
      this.transactionId});

  factory _$PayoutRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayoutRequestImplFromJson(json);

  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime createdAt;
  @override
  final String bank;
  @override
  @JsonKey(name: 'acc_number')
  final String accNumber;
  @override
  @JsonKey(name: 'acc_name')
  final String accName;
  @override
  @JsonKey(name: 'branch_code')
  final String branchCode;
  @override
  @JsonKey(name: 'approved_at', includeToJson: false)
  final DateTime? approvedAt;
  @override
  @JsonKey(includeToJson: false)
  final int id;
  @override
  @JsonKey(name: 'acc_holder')
  final String accHolder;
  @override
  final double amount;
  @override
  @JsonKey(name: 'wallet_id')
  final int walletId;
  @override
  @JsonKey(name: 'transaction_id', includeToJson: false)
  final int? transactionId;

  @override
  String toString() {
    return 'PayoutRequest(createdAt: $createdAt, bank: $bank, accNumber: $accNumber, accName: $accName, branchCode: $branchCode, approvedAt: $approvedAt, id: $id, accHolder: $accHolder, amount: $amount, walletId: $walletId, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayoutRequestImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.bank, bank) || other.bank == bank) &&
            (identical(other.accNumber, accNumber) ||
                other.accNumber == accNumber) &&
            (identical(other.accName, accName) || other.accName == accName) &&
            (identical(other.branchCode, branchCode) ||
                other.branchCode == branchCode) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accHolder, accHolder) ||
                other.accHolder == accHolder) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      createdAt,
      bank,
      accNumber,
      accName,
      branchCode,
      approvedAt,
      id,
      accHolder,
      amount,
      walletId,
      transactionId);

  /// Create a copy of PayoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayoutRequestImplCopyWith<_$PayoutRequestImpl> get copyWith =>
      __$$PayoutRequestImplCopyWithImpl<_$PayoutRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayoutRequestImplToJson(
      this,
    );
  }
}

abstract class _PayoutRequest implements PayoutRequest {
  const factory _PayoutRequest(
      {@JsonKey(name: 'created_at', includeToJson: false)
      required final DateTime createdAt,
      required final String bank,
      @JsonKey(name: 'acc_number') required final String accNumber,
      @JsonKey(name: 'acc_name') required final String accName,
      @JsonKey(name: 'branch_code') required final String branchCode,
      @JsonKey(name: 'approved_at', includeToJson: false)
      final DateTime? approvedAt,
      @JsonKey(includeToJson: false) required final int id,
      @JsonKey(name: 'acc_holder') required final String accHolder,
      required final double amount,
      @JsonKey(name: 'wallet_id') required final int walletId,
      @JsonKey(name: 'transaction_id', includeToJson: false)
      final int? transactionId}) = _$PayoutRequestImpl;

  factory _PayoutRequest.fromJson(Map<String, dynamic> json) =
      _$PayoutRequestImpl.fromJson;

  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  @override
  String get bank;
  @override
  @JsonKey(name: 'acc_number')
  String get accNumber;
  @override
  @JsonKey(name: 'acc_name')
  String get accName;
  @override
  @JsonKey(name: 'branch_code')
  String get branchCode;
  @override
  @JsonKey(name: 'approved_at', includeToJson: false)
  DateTime? get approvedAt;
  @override
  @JsonKey(includeToJson: false)
  int get id;
  @override
  @JsonKey(name: 'acc_holder')
  String get accHolder;
  @override
  double get amount;
  @override
  @JsonKey(name: 'wallet_id')
  int get walletId;
  @override
  @JsonKey(name: 'transaction_id', includeToJson: false)
  int? get transactionId;

  /// Create a copy of PayoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayoutRequestImplCopyWith<_$PayoutRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
