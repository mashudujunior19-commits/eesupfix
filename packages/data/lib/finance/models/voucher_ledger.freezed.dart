// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher_ledger.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoucherLedger {
  @JsonKey(name: 'voucher_id')
  int get voucherId;
  @JsonKey(name: 'transaction_id')
  int get transactionId;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'opening_balance')
  double? get openingBalance;
  @JsonKey(name: 'payout')
  double? get payout;
  @JsonKey(name: 'profit_share')
  double? get profitShare;
  @JsonKey(name: 'closing_balance')
  double get closingBalance;

  /// Create a copy of VoucherLedger
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VoucherLedgerCopyWith<VoucherLedger> get copyWith =>
      _$VoucherLedgerCopyWithImpl<VoucherLedger>(
          this as VoucherLedger, _$identity);

  /// Serializes this VoucherLedger to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VoucherLedger &&
            (identical(other.voucherId, voucherId) ||
                other.voucherId == voucherId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance) &&
            (identical(other.payout, payout) || other.payout == payout) &&
            (identical(other.profitShare, profitShare) ||
                other.profitShare == profitShare) &&
            (identical(other.closingBalance, closingBalance) ||
                other.closingBalance == closingBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, voucherId, transactionId,
      createdAt, openingBalance, payout, profitShare, closingBalance);

  @override
  String toString() {
    return 'VoucherLedger(voucherId: $voucherId, transactionId: $transactionId, createdAt: $createdAt, openingBalance: $openingBalance, payout: $payout, profitShare: $profitShare, closingBalance: $closingBalance)';
  }
}

/// @nodoc
abstract mixin class $VoucherLedgerCopyWith<$Res> {
  factory $VoucherLedgerCopyWith(
          VoucherLedger value, $Res Function(VoucherLedger) _then) =
      _$VoucherLedgerCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'voucher_id') int voucherId,
      @JsonKey(name: 'transaction_id') int transactionId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'opening_balance') double? openingBalance,
      @JsonKey(name: 'payout') double? payout,
      @JsonKey(name: 'profit_share') double? profitShare,
      @JsonKey(name: 'closing_balance') double closingBalance});
}

/// @nodoc
class _$VoucherLedgerCopyWithImpl<$Res>
    implements $VoucherLedgerCopyWith<$Res> {
  _$VoucherLedgerCopyWithImpl(this._self, this._then);

  final VoucherLedger _self;
  final $Res Function(VoucherLedger) _then;

  /// Create a copy of VoucherLedger
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voucherId = null,
    Object? transactionId = null,
    Object? createdAt = null,
    Object? openingBalance = freezed,
    Object? payout = freezed,
    Object? profitShare = freezed,
    Object? closingBalance = null,
  }) {
    return _then(_self.copyWith(
      voucherId: null == voucherId
          ? _self.voucherId
          : voucherId // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: null == transactionId
          ? _self.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingBalance: freezed == openingBalance
          ? _self.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      payout: freezed == payout
          ? _self.payout
          : payout // ignore: cast_nullable_to_non_nullable
              as double?,
      profitShare: freezed == profitShare
          ? _self.profitShare
          : profitShare // ignore: cast_nullable_to_non_nullable
              as double?,
      closingBalance: null == closingBalance
          ? _self.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _VoucherLedger implements VoucherLedger {
  const _VoucherLedger(
      {@JsonKey(name: 'voucher_id') required this.voucherId,
      @JsonKey(name: 'transaction_id') required this.transactionId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'opening_balance') this.openingBalance,
      @JsonKey(name: 'payout') this.payout,
      @JsonKey(name: 'profit_share') this.profitShare,
      @JsonKey(name: 'closing_balance') required this.closingBalance});
  factory _VoucherLedger.fromJson(Map<String, dynamic> json) =>
      _$VoucherLedgerFromJson(json);

  @override
  @JsonKey(name: 'voucher_id')
  final int voucherId;
  @override
  @JsonKey(name: 'transaction_id')
  final int transactionId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'opening_balance')
  final double? openingBalance;
  @override
  @JsonKey(name: 'payout')
  final double? payout;
  @override
  @JsonKey(name: 'profit_share')
  final double? profitShare;
  @override
  @JsonKey(name: 'closing_balance')
  final double closingBalance;

  /// Create a copy of VoucherLedger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VoucherLedgerCopyWith<_VoucherLedger> get copyWith =>
      __$VoucherLedgerCopyWithImpl<_VoucherLedger>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VoucherLedgerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VoucherLedger &&
            (identical(other.voucherId, voucherId) ||
                other.voucherId == voucherId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance) &&
            (identical(other.payout, payout) || other.payout == payout) &&
            (identical(other.profitShare, profitShare) ||
                other.profitShare == profitShare) &&
            (identical(other.closingBalance, closingBalance) ||
                other.closingBalance == closingBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, voucherId, transactionId,
      createdAt, openingBalance, payout, profitShare, closingBalance);

  @override
  String toString() {
    return 'VoucherLedger(voucherId: $voucherId, transactionId: $transactionId, createdAt: $createdAt, openingBalance: $openingBalance, payout: $payout, profitShare: $profitShare, closingBalance: $closingBalance)';
  }
}

/// @nodoc
abstract mixin class _$VoucherLedgerCopyWith<$Res>
    implements $VoucherLedgerCopyWith<$Res> {
  factory _$VoucherLedgerCopyWith(
          _VoucherLedger value, $Res Function(_VoucherLedger) _then) =
      __$VoucherLedgerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'voucher_id') int voucherId,
      @JsonKey(name: 'transaction_id') int transactionId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'opening_balance') double? openingBalance,
      @JsonKey(name: 'payout') double? payout,
      @JsonKey(name: 'profit_share') double? profitShare,
      @JsonKey(name: 'closing_balance') double closingBalance});
}

/// @nodoc
class __$VoucherLedgerCopyWithImpl<$Res>
    implements _$VoucherLedgerCopyWith<$Res> {
  __$VoucherLedgerCopyWithImpl(this._self, this._then);

  final _VoucherLedger _self;
  final $Res Function(_VoucherLedger) _then;

  /// Create a copy of VoucherLedger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? voucherId = null,
    Object? transactionId = null,
    Object? createdAt = null,
    Object? openingBalance = freezed,
    Object? payout = freezed,
    Object? profitShare = freezed,
    Object? closingBalance = null,
  }) {
    return _then(_VoucherLedger(
      voucherId: null == voucherId
          ? _self.voucherId
          : voucherId // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: null == transactionId
          ? _self.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingBalance: freezed == openingBalance
          ? _self.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      payout: freezed == payout
          ? _self.payout
          : payout // ignore: cast_nullable_to_non_nullable
              as double?,
      profitShare: freezed == profitShare
          ? _self.profitShare
          : profitShare // ignore: cast_nullable_to_non_nullable
              as double?,
      closingBalance: null == closingBalance
          ? _self.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
