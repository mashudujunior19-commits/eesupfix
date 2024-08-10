// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher_ledger.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoucherLedger _$VoucherLedgerFromJson(Map<String, dynamic> json) {
  return _VoucherLedger.fromJson(json);
}

/// @nodoc
mixin _$VoucherLedger {
  @JsonKey(name: 'voucher_id')
  int get voucherId => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_id')
  int get transactionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_balance')
  double? get openingBalance => throw _privateConstructorUsedError;
  @JsonKey(name: 'payout')
  double? get payout => throw _privateConstructorUsedError;
  @JsonKey(name: 'profit_share')
  double? get profitShare => throw _privateConstructorUsedError;
  @JsonKey(name: 'closing_balance')
  double get closingBalance => throw _privateConstructorUsedError;

  /// Serializes this VoucherLedger to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoucherLedger
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoucherLedgerCopyWith<VoucherLedger> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherLedgerCopyWith<$Res> {
  factory $VoucherLedgerCopyWith(
          VoucherLedger value, $Res Function(VoucherLedger) then) =
      _$VoucherLedgerCopyWithImpl<$Res, VoucherLedger>;
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
class _$VoucherLedgerCopyWithImpl<$Res, $Val extends VoucherLedger>
    implements $VoucherLedgerCopyWith<$Res> {
  _$VoucherLedgerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      voucherId: null == voucherId
          ? _value.voucherId
          : voucherId // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingBalance: freezed == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      payout: freezed == payout
          ? _value.payout
          : payout // ignore: cast_nullable_to_non_nullable
              as double?,
      profitShare: freezed == profitShare
          ? _value.profitShare
          : profitShare // ignore: cast_nullable_to_non_nullable
              as double?,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherLedgerImplCopyWith<$Res>
    implements $VoucherLedgerCopyWith<$Res> {
  factory _$$VoucherLedgerImplCopyWith(
          _$VoucherLedgerImpl value, $Res Function(_$VoucherLedgerImpl) then) =
      __$$VoucherLedgerImplCopyWithImpl<$Res>;
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
class __$$VoucherLedgerImplCopyWithImpl<$Res>
    extends _$VoucherLedgerCopyWithImpl<$Res, _$VoucherLedgerImpl>
    implements _$$VoucherLedgerImplCopyWith<$Res> {
  __$$VoucherLedgerImplCopyWithImpl(
      _$VoucherLedgerImpl _value, $Res Function(_$VoucherLedgerImpl) _then)
      : super(_value, _then);

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
    return _then(_$VoucherLedgerImpl(
      voucherId: null == voucherId
          ? _value.voucherId
          : voucherId // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingBalance: freezed == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      payout: freezed == payout
          ? _value.payout
          : payout // ignore: cast_nullable_to_non_nullable
              as double?,
      profitShare: freezed == profitShare
          ? _value.profitShare
          : profitShare // ignore: cast_nullable_to_non_nullable
              as double?,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherLedgerImpl implements _VoucherLedger {
  const _$VoucherLedgerImpl(
      {@JsonKey(name: 'voucher_id') required this.voucherId,
      @JsonKey(name: 'transaction_id') required this.transactionId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'opening_balance') this.openingBalance,
      @JsonKey(name: 'payout') this.payout,
      @JsonKey(name: 'profit_share') this.profitShare,
      @JsonKey(name: 'closing_balance') required this.closingBalance});

  factory _$VoucherLedgerImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherLedgerImplFromJson(json);

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

  @override
  String toString() {
    return 'VoucherLedger(voucherId: $voucherId, transactionId: $transactionId, createdAt: $createdAt, openingBalance: $openingBalance, payout: $payout, profitShare: $profitShare, closingBalance: $closingBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherLedgerImpl &&
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

  /// Create a copy of VoucherLedger
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherLedgerImplCopyWith<_$VoucherLedgerImpl> get copyWith =>
      __$$VoucherLedgerImplCopyWithImpl<_$VoucherLedgerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherLedgerImplToJson(
      this,
    );
  }
}

abstract class _VoucherLedger implements VoucherLedger {
  const factory _VoucherLedger(
      {@JsonKey(name: 'voucher_id') required final int voucherId,
      @JsonKey(name: 'transaction_id') required final int transactionId,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'opening_balance') final double? openingBalance,
      @JsonKey(name: 'payout') final double? payout,
      @JsonKey(name: 'profit_share') final double? profitShare,
      @JsonKey(name: 'closing_balance')
      required final double closingBalance}) = _$VoucherLedgerImpl;

  factory _VoucherLedger.fromJson(Map<String, dynamic> json) =
      _$VoucherLedgerImpl.fromJson;

  @override
  @JsonKey(name: 'voucher_id')
  int get voucherId;
  @override
  @JsonKey(name: 'transaction_id')
  int get transactionId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'opening_balance')
  double? get openingBalance;
  @override
  @JsonKey(name: 'payout')
  double? get payout;
  @override
  @JsonKey(name: 'profit_share')
  double? get profitShare;
  @override
  @JsonKey(name: 'closing_balance')
  double get closingBalance;

  /// Create a copy of VoucherLedger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherLedgerImplCopyWith<_$VoucherLedgerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
