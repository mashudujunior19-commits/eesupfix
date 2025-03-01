// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payout_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PayoutRequest {
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  String get bank;
  @JsonKey(name: 'acc_number')
  String get accNumber;
  @JsonKey(name: 'acc_name')
  String get accName;
  @JsonKey(name: 'branch_code')
  String get branchCode;
  @JsonKey(name: 'approved_at', includeToJson: false)
  DateTime? get approvedAt;
  @JsonKey(includeToJson: false)
  int get id;
  @JsonKey(name: 'acc_holder')
  String get accHolder;
  double get amount;
  @JsonKey(name: 'wallet_id')
  int get walletId;
  @JsonKey(name: 'transaction_id', includeToJson: false)
  int? get transactionId;

  /// Create a copy of PayoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PayoutRequestCopyWith<PayoutRequest> get copyWith =>
      _$PayoutRequestCopyWithImpl<PayoutRequest>(
          this as PayoutRequest, _$identity);

  /// Serializes this PayoutRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PayoutRequest &&
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

  @override
  String toString() {
    return 'PayoutRequest(createdAt: $createdAt, bank: $bank, accNumber: $accNumber, accName: $accName, branchCode: $branchCode, approvedAt: $approvedAt, id: $id, accHolder: $accHolder, amount: $amount, walletId: $walletId, transactionId: $transactionId)';
  }
}

/// @nodoc
abstract mixin class $PayoutRequestCopyWith<$Res> {
  factory $PayoutRequestCopyWith(
          PayoutRequest value, $Res Function(PayoutRequest) _then) =
      _$PayoutRequestCopyWithImpl;
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
class _$PayoutRequestCopyWithImpl<$Res>
    implements $PayoutRequestCopyWith<$Res> {
  _$PayoutRequestCopyWithImpl(this._self, this._then);

  final PayoutRequest _self;
  final $Res Function(PayoutRequest) _then;

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
    return _then(_self.copyWith(
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bank: null == bank
          ? _self.bank
          : bank // ignore: cast_nullable_to_non_nullable
              as String,
      accNumber: null == accNumber
          ? _self.accNumber
          : accNumber // ignore: cast_nullable_to_non_nullable
              as String,
      accName: null == accName
          ? _self.accName
          : accName // ignore: cast_nullable_to_non_nullable
              as String,
      branchCode: null == branchCode
          ? _self.branchCode
          : branchCode // ignore: cast_nullable_to_non_nullable
              as String,
      approvedAt: freezed == approvedAt
          ? _self.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      accHolder: null == accHolder
          ? _self.accHolder
          : accHolder // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      walletId: null == walletId
          ? _self.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: freezed == transactionId
          ? _self.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PayoutRequest implements PayoutRequest {
  const _PayoutRequest(
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
  factory _PayoutRequest.fromJson(Map<String, dynamic> json) =>
      _$PayoutRequestFromJson(json);

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

  /// Create a copy of PayoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PayoutRequestCopyWith<_PayoutRequest> get copyWith =>
      __$PayoutRequestCopyWithImpl<_PayoutRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PayoutRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayoutRequest &&
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

  @override
  String toString() {
    return 'PayoutRequest(createdAt: $createdAt, bank: $bank, accNumber: $accNumber, accName: $accName, branchCode: $branchCode, approvedAt: $approvedAt, id: $id, accHolder: $accHolder, amount: $amount, walletId: $walletId, transactionId: $transactionId)';
  }
}

/// @nodoc
abstract mixin class _$PayoutRequestCopyWith<$Res>
    implements $PayoutRequestCopyWith<$Res> {
  factory _$PayoutRequestCopyWith(
          _PayoutRequest value, $Res Function(_PayoutRequest) _then) =
      __$PayoutRequestCopyWithImpl;
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
class __$PayoutRequestCopyWithImpl<$Res>
    implements _$PayoutRequestCopyWith<$Res> {
  __$PayoutRequestCopyWithImpl(this._self, this._then);

  final _PayoutRequest _self;
  final $Res Function(_PayoutRequest) _then;

  /// Create a copy of PayoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_PayoutRequest(
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bank: null == bank
          ? _self.bank
          : bank // ignore: cast_nullable_to_non_nullable
              as String,
      accNumber: null == accNumber
          ? _self.accNumber
          : accNumber // ignore: cast_nullable_to_non_nullable
              as String,
      accName: null == accName
          ? _self.accName
          : accName // ignore: cast_nullable_to_non_nullable
              as String,
      branchCode: null == branchCode
          ? _self.branchCode
          : branchCode // ignore: cast_nullable_to_non_nullable
              as String,
      approvedAt: freezed == approvedAt
          ? _self.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      accHolder: null == accHolder
          ? _self.accHolder
          : accHolder // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      walletId: null == walletId
          ? _self.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: freezed == transactionId
          ? _self.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
