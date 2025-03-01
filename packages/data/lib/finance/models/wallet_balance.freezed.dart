// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletBalance {
  int get walletId;
  String get walletType;
  double? get availableBalance;
  double? get totalBalance;

  /// Create a copy of WalletBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletBalanceCopyWith<WalletBalance> get copyWith =>
      _$WalletBalanceCopyWithImpl<WalletBalance>(
          this as WalletBalance, _$identity);

  /// Serializes this WalletBalance to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletBalance &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.walletType, walletType) ||
                other.walletType == walletType) &&
            (identical(other.availableBalance, availableBalance) ||
                other.availableBalance == availableBalance) &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, walletId, walletType, availableBalance, totalBalance);

  @override
  String toString() {
    return 'WalletBalance(walletId: $walletId, walletType: $walletType, availableBalance: $availableBalance, totalBalance: $totalBalance)';
  }
}

/// @nodoc
abstract mixin class $WalletBalanceCopyWith<$Res> {
  factory $WalletBalanceCopyWith(
          WalletBalance value, $Res Function(WalletBalance) _then) =
      _$WalletBalanceCopyWithImpl;
  @useResult
  $Res call(
      {int walletId,
      String walletType,
      double? availableBalance,
      double? totalBalance});
}

/// @nodoc
class _$WalletBalanceCopyWithImpl<$Res>
    implements $WalletBalanceCopyWith<$Res> {
  _$WalletBalanceCopyWithImpl(this._self, this._then);

  final WalletBalance _self;
  final $Res Function(WalletBalance) _then;

  /// Create a copy of WalletBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletId = null,
    Object? walletType = null,
    Object? availableBalance = freezed,
    Object? totalBalance = freezed,
  }) {
    return _then(_self.copyWith(
      walletId: null == walletId
          ? _self.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int,
      walletType: null == walletType
          ? _self.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as String,
      availableBalance: freezed == availableBalance
          ? _self.availableBalance
          : availableBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      totalBalance: freezed == totalBalance
          ? _self.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WalletBalance implements WalletBalance {
  const _WalletBalance(
      {required this.walletId,
      required this.walletType,
      required this.availableBalance,
      required this.totalBalance});
  factory _WalletBalance.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceFromJson(json);

  @override
  final int walletId;
  @override
  final String walletType;
  @override
  final double? availableBalance;
  @override
  final double? totalBalance;

  /// Create a copy of WalletBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WalletBalanceCopyWith<_WalletBalance> get copyWith =>
      __$WalletBalanceCopyWithImpl<_WalletBalance>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WalletBalanceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WalletBalance &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.walletType, walletType) ||
                other.walletType == walletType) &&
            (identical(other.availableBalance, availableBalance) ||
                other.availableBalance == availableBalance) &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, walletId, walletType, availableBalance, totalBalance);

  @override
  String toString() {
    return 'WalletBalance(walletId: $walletId, walletType: $walletType, availableBalance: $availableBalance, totalBalance: $totalBalance)';
  }
}

/// @nodoc
abstract mixin class _$WalletBalanceCopyWith<$Res>
    implements $WalletBalanceCopyWith<$Res> {
  factory _$WalletBalanceCopyWith(
          _WalletBalance value, $Res Function(_WalletBalance) _then) =
      __$WalletBalanceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int walletId,
      String walletType,
      double? availableBalance,
      double? totalBalance});
}

/// @nodoc
class __$WalletBalanceCopyWithImpl<$Res>
    implements _$WalletBalanceCopyWith<$Res> {
  __$WalletBalanceCopyWithImpl(this._self, this._then);

  final _WalletBalance _self;
  final $Res Function(_WalletBalance) _then;

  /// Create a copy of WalletBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? walletId = null,
    Object? walletType = null,
    Object? availableBalance = freezed,
    Object? totalBalance = freezed,
  }) {
    return _then(_WalletBalance(
      walletId: null == walletId
          ? _self.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int,
      walletType: null == walletType
          ? _self.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as String,
      availableBalance: freezed == availableBalance
          ? _self.availableBalance
          : availableBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      totalBalance: freezed == totalBalance
          ? _self.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
