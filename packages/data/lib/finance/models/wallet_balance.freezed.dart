// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletBalance _$WalletBalanceFromJson(Map<String, dynamic> json) {
  return _WalletBalance.fromJson(json);
}

/// @nodoc
mixin _$WalletBalance {
  int get walletId => throw _privateConstructorUsedError;
  String get walletType => throw _privateConstructorUsedError;
  double? get availableBalance => throw _privateConstructorUsedError;
  double? get totalBalance => throw _privateConstructorUsedError;

  /// Serializes this WalletBalance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletBalanceCopyWith<WalletBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletBalanceCopyWith<$Res> {
  factory $WalletBalanceCopyWith(
          WalletBalance value, $Res Function(WalletBalance) then) =
      _$WalletBalanceCopyWithImpl<$Res, WalletBalance>;
  @useResult
  $Res call(
      {int walletId,
      String walletType,
      double? availableBalance,
      double? totalBalance});
}

/// @nodoc
class _$WalletBalanceCopyWithImpl<$Res, $Val extends WalletBalance>
    implements $WalletBalanceCopyWith<$Res> {
  _$WalletBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      walletId: null == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int,
      walletType: null == walletType
          ? _value.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as String,
      availableBalance: freezed == availableBalance
          ? _value.availableBalance
          : availableBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      totalBalance: freezed == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletBalanceImplCopyWith<$Res>
    implements $WalletBalanceCopyWith<$Res> {
  factory _$$WalletBalanceImplCopyWith(
          _$WalletBalanceImpl value, $Res Function(_$WalletBalanceImpl) then) =
      __$$WalletBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int walletId,
      String walletType,
      double? availableBalance,
      double? totalBalance});
}

/// @nodoc
class __$$WalletBalanceImplCopyWithImpl<$Res>
    extends _$WalletBalanceCopyWithImpl<$Res, _$WalletBalanceImpl>
    implements _$$WalletBalanceImplCopyWith<$Res> {
  __$$WalletBalanceImplCopyWithImpl(
      _$WalletBalanceImpl _value, $Res Function(_$WalletBalanceImpl) _then)
      : super(_value, _then);

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
    return _then(_$WalletBalanceImpl(
      walletId: null == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int,
      walletType: null == walletType
          ? _value.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as String,
      availableBalance: freezed == availableBalance
          ? _value.availableBalance
          : availableBalance // ignore: cast_nullable_to_non_nullable
              as double?,
      totalBalance: freezed == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletBalanceImpl implements _WalletBalance {
  const _$WalletBalanceImpl(
      {required this.walletId,
      required this.walletType,
      required this.availableBalance,
      required this.totalBalance});

  factory _$WalletBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletBalanceImplFromJson(json);

  @override
  final int walletId;
  @override
  final String walletType;
  @override
  final double? availableBalance;
  @override
  final double? totalBalance;

  @override
  String toString() {
    return 'WalletBalance(walletId: $walletId, walletType: $walletType, availableBalance: $availableBalance, totalBalance: $totalBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletBalanceImpl &&
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

  /// Create a copy of WalletBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletBalanceImplCopyWith<_$WalletBalanceImpl> get copyWith =>
      __$$WalletBalanceImplCopyWithImpl<_$WalletBalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletBalanceImplToJson(
      this,
    );
  }
}

abstract class _WalletBalance implements WalletBalance {
  const factory _WalletBalance(
      {required final int walletId,
      required final String walletType,
      required final double? availableBalance,
      required final double? totalBalance}) = _$WalletBalanceImpl;

  factory _WalletBalance.fromJson(Map<String, dynamic> json) =
      _$WalletBalanceImpl.fromJson;

  @override
  int get walletId;
  @override
  String get walletType;
  @override
  double? get availableBalance;
  @override
  double? get totalBalance;

  /// Create a copy of WalletBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletBalanceImplCopyWith<_$WalletBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
