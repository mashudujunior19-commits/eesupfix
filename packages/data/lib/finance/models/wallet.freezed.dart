// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return _Wallet.fromJson(json);
}

/// @nodoc
mixin _$Wallet {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_id')
  String get typeId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_created_at')
  DateTime get typeCreatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'withdrawals')
  bool get withdrawals => throw _privateConstructorUsedError;
  @JsonKey(name: 'deposits')
  bool get deposits => throw _privateConstructorUsedError;
  @JsonKey(name: 'transfers')
  bool get transfers => throw _privateConstructorUsedError;
  @JsonKey(name: 'shopping')
  bool get shopping => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'require_rsa_id')
  bool get requireRsaId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_num')
  int get sortNumber => throw _privateConstructorUsedError;

  /// Serializes this Wallet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletCopyWith<Wallet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCopyWith<$Res> {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) then) =
      _$WalletCopyWithImpl<$Res, Wallet>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') String userId,
      double balance,
      @JsonKey(name: 'type_id') String typeId,
      String description,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'type_created_at') DateTime typeCreatedAt,
      @JsonKey(name: 'withdrawals') bool withdrawals,
      @JsonKey(name: 'deposits') bool deposits,
      @JsonKey(name: 'transfers') bool transfers,
      @JsonKey(name: 'shopping') bool shopping,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'require_rsa_id') bool requireRsaId,
      @JsonKey(name: 'sort_num') int sortNumber});
}

/// @nodoc
class _$WalletCopyWithImpl<$Res, $Val extends Wallet>
    implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? balance = null,
    Object? typeId = null,
    Object? description = null,
    Object? createdAt = null,
    Object? typeCreatedAt = null,
    Object? withdrawals = null,
    Object? deposits = null,
    Object? transfers = null,
    Object? shopping = null,
    Object? isActive = null,
    Object? requireRsaId = null,
    Object? sortNumber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      typeCreatedAt: null == typeCreatedAt
          ? _value.typeCreatedAt
          : typeCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      withdrawals: null == withdrawals
          ? _value.withdrawals
          : withdrawals // ignore: cast_nullable_to_non_nullable
              as bool,
      deposits: null == deposits
          ? _value.deposits
          : deposits // ignore: cast_nullable_to_non_nullable
              as bool,
      transfers: null == transfers
          ? _value.transfers
          : transfers // ignore: cast_nullable_to_non_nullable
              as bool,
      shopping: null == shopping
          ? _value.shopping
          : shopping // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      requireRsaId: null == requireRsaId
          ? _value.requireRsaId
          : requireRsaId // ignore: cast_nullable_to_non_nullable
              as bool,
      sortNumber: null == sortNumber
          ? _value.sortNumber
          : sortNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletImplCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$$WalletImplCopyWith(
          _$WalletImpl value, $Res Function(_$WalletImpl) then) =
      __$$WalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') String userId,
      double balance,
      @JsonKey(name: 'type_id') String typeId,
      String description,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'type_created_at') DateTime typeCreatedAt,
      @JsonKey(name: 'withdrawals') bool withdrawals,
      @JsonKey(name: 'deposits') bool deposits,
      @JsonKey(name: 'transfers') bool transfers,
      @JsonKey(name: 'shopping') bool shopping,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'require_rsa_id') bool requireRsaId,
      @JsonKey(name: 'sort_num') int sortNumber});
}

/// @nodoc
class __$$WalletImplCopyWithImpl<$Res>
    extends _$WalletCopyWithImpl<$Res, _$WalletImpl>
    implements _$$WalletImplCopyWith<$Res> {
  __$$WalletImplCopyWithImpl(
      _$WalletImpl _value, $Res Function(_$WalletImpl) _then)
      : super(_value, _then);

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? balance = null,
    Object? typeId = null,
    Object? description = null,
    Object? createdAt = null,
    Object? typeCreatedAt = null,
    Object? withdrawals = null,
    Object? deposits = null,
    Object? transfers = null,
    Object? shopping = null,
    Object? isActive = null,
    Object? requireRsaId = null,
    Object? sortNumber = null,
  }) {
    return _then(_$WalletImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      typeCreatedAt: null == typeCreatedAt
          ? _value.typeCreatedAt
          : typeCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      withdrawals: null == withdrawals
          ? _value.withdrawals
          : withdrawals // ignore: cast_nullable_to_non_nullable
              as bool,
      deposits: null == deposits
          ? _value.deposits
          : deposits // ignore: cast_nullable_to_non_nullable
              as bool,
      transfers: null == transfers
          ? _value.transfers
          : transfers // ignore: cast_nullable_to_non_nullable
              as bool,
      shopping: null == shopping
          ? _value.shopping
          : shopping // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      requireRsaId: null == requireRsaId
          ? _value.requireRsaId
          : requireRsaId // ignore: cast_nullable_to_non_nullable
              as bool,
      sortNumber: null == sortNumber
          ? _value.sortNumber
          : sortNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletImpl with DiagnosticableTreeMixin implements _Wallet {
  _$WalletImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.balance,
      @JsonKey(name: 'type_id') required this.typeId,
      required this.description,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'type_created_at') required this.typeCreatedAt,
      @JsonKey(name: 'withdrawals') required this.withdrawals,
      @JsonKey(name: 'deposits') required this.deposits,
      @JsonKey(name: 'transfers') required this.transfers,
      @JsonKey(name: 'shopping') required this.shopping,
      @JsonKey(name: 'is_active') required this.isActive,
      @JsonKey(name: 'require_rsa_id') required this.requireRsaId,
      @JsonKey(name: 'sort_num') required this.sortNumber});

  factory _$WalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final double balance;
  @override
  @JsonKey(name: 'type_id')
  final String typeId;
  @override
  final String description;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'type_created_at')
  final DateTime typeCreatedAt;
  @override
  @JsonKey(name: 'withdrawals')
  final bool withdrawals;
  @override
  @JsonKey(name: 'deposits')
  final bool deposits;
  @override
  @JsonKey(name: 'transfers')
  final bool transfers;
  @override
  @JsonKey(name: 'shopping')
  final bool shopping;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'require_rsa_id')
  final bool requireRsaId;
  @override
  @JsonKey(name: 'sort_num')
  final int sortNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Wallet(id: $id, userId: $userId, balance: $balance, typeId: $typeId, description: $description, createdAt: $createdAt, typeCreatedAt: $typeCreatedAt, withdrawals: $withdrawals, deposits: $deposits, transfers: $transfers, shopping: $shopping, isActive: $isActive, requireRsaId: $requireRsaId, sortNumber: $sortNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Wallet'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('balance', balance))
      ..add(DiagnosticsProperty('typeId', typeId))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('typeCreatedAt', typeCreatedAt))
      ..add(DiagnosticsProperty('withdrawals', withdrawals))
      ..add(DiagnosticsProperty('deposits', deposits))
      ..add(DiagnosticsProperty('transfers', transfers))
      ..add(DiagnosticsProperty('shopping', shopping))
      ..add(DiagnosticsProperty('isActive', isActive))
      ..add(DiagnosticsProperty('requireRsaId', requireRsaId))
      ..add(DiagnosticsProperty('sortNumber', sortNumber));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.typeCreatedAt, typeCreatedAt) ||
                other.typeCreatedAt == typeCreatedAt) &&
            (identical(other.withdrawals, withdrawals) ||
                other.withdrawals == withdrawals) &&
            (identical(other.deposits, deposits) ||
                other.deposits == deposits) &&
            (identical(other.transfers, transfers) ||
                other.transfers == transfers) &&
            (identical(other.shopping, shopping) ||
                other.shopping == shopping) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.requireRsaId, requireRsaId) ||
                other.requireRsaId == requireRsaId) &&
            (identical(other.sortNumber, sortNumber) ||
                other.sortNumber == sortNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      balance,
      typeId,
      description,
      createdAt,
      typeCreatedAt,
      withdrawals,
      deposits,
      transfers,
      shopping,
      isActive,
      requireRsaId,
      sortNumber);

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      __$$WalletImplCopyWithImpl<_$WalletImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletImplToJson(
      this,
    );
  }
}

abstract class _Wallet implements Wallet {
  factory _Wallet(
      {required final int id,
      @JsonKey(name: 'user_id') required final String userId,
      required final double balance,
      @JsonKey(name: 'type_id') required final String typeId,
      required final String description,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'type_created_at') required final DateTime typeCreatedAt,
      @JsonKey(name: 'withdrawals') required final bool withdrawals,
      @JsonKey(name: 'deposits') required final bool deposits,
      @JsonKey(name: 'transfers') required final bool transfers,
      @JsonKey(name: 'shopping') required final bool shopping,
      @JsonKey(name: 'is_active') required final bool isActive,
      @JsonKey(name: 'require_rsa_id') required final bool requireRsaId,
      @JsonKey(name: 'sort_num') required final int sortNumber}) = _$WalletImpl;

  factory _Wallet.fromJson(Map<String, dynamic> json) = _$WalletImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  double get balance;
  @override
  @JsonKey(name: 'type_id')
  String get typeId;
  @override
  String get description;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'type_created_at')
  DateTime get typeCreatedAt;
  @override
  @JsonKey(name: 'withdrawals')
  bool get withdrawals;
  @override
  @JsonKey(name: 'deposits')
  bool get deposits;
  @override
  @JsonKey(name: 'transfers')
  bool get transfers;
  @override
  @JsonKey(name: 'shopping')
  bool get shopping;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'require_rsa_id')
  bool get requireRsaId;
  @override
  @JsonKey(name: 'sort_num')
  int get sortNumber;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
