// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Wallet implements DiagnosticableTreeMixin {
  int get id;
  @JsonKey(name: 'user_id')
  String get userId;
  double get balance;
  @JsonKey(name: 'type_id')
  String get typeId;
  String get description;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'type_created_at')
  DateTime get typeCreatedAt;
  @JsonKey(name: 'withdrawals')
  bool get withdrawals;
  @JsonKey(name: 'deposits')
  bool get deposits;
  @JsonKey(name: 'transfers')
  bool get transfers;
  @JsonKey(name: 'shopping')
  bool get shopping;
  @JsonKey(name: 'is_active')
  bool get isActive;
  @JsonKey(name: 'require_rsa_id')
  bool get requireRsaId;
  @JsonKey(name: 'sort_num')
  int get sortNumber;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletCopyWith<Wallet> get copyWith =>
      _$WalletCopyWithImpl<Wallet>(this as Wallet, _$identity);

  /// Serializes this Wallet to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
            other is Wallet &&
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Wallet(id: $id, userId: $userId, balance: $balance, typeId: $typeId, description: $description, createdAt: $createdAt, typeCreatedAt: $typeCreatedAt, withdrawals: $withdrawals, deposits: $deposits, transfers: $transfers, shopping: $shopping, isActive: $isActive, requireRsaId: $requireRsaId, sortNumber: $sortNumber)';
  }
}

/// @nodoc
abstract mixin class $WalletCopyWith<$Res> {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) _then) =
      _$WalletCopyWithImpl;
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
class _$WalletCopyWithImpl<$Res> implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._self, this._then);

  final Wallet _self;
  final $Res Function(Wallet) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      typeId: null == typeId
          ? _self.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      typeCreatedAt: null == typeCreatedAt
          ? _self.typeCreatedAt
          : typeCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      withdrawals: null == withdrawals
          ? _self.withdrawals
          : withdrawals // ignore: cast_nullable_to_non_nullable
              as bool,
      deposits: null == deposits
          ? _self.deposits
          : deposits // ignore: cast_nullable_to_non_nullable
              as bool,
      transfers: null == transfers
          ? _self.transfers
          : transfers // ignore: cast_nullable_to_non_nullable
              as bool,
      shopping: null == shopping
          ? _self.shopping
          : shopping // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      requireRsaId: null == requireRsaId
          ? _self.requireRsaId
          : requireRsaId // ignore: cast_nullable_to_non_nullable
              as bool,
      sortNumber: null == sortNumber
          ? _self.sortNumber
          : sortNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Wallet with DiagnosticableTreeMixin implements Wallet {
  _Wallet(
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
  factory _Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

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

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WalletCopyWith<_Wallet> get copyWith =>
      __$WalletCopyWithImpl<_Wallet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WalletToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
            other is _Wallet &&
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Wallet(id: $id, userId: $userId, balance: $balance, typeId: $typeId, description: $description, createdAt: $createdAt, typeCreatedAt: $typeCreatedAt, withdrawals: $withdrawals, deposits: $deposits, transfers: $transfers, shopping: $shopping, isActive: $isActive, requireRsaId: $requireRsaId, sortNumber: $sortNumber)';
  }
}

/// @nodoc
abstract mixin class _$WalletCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$WalletCopyWith(_Wallet value, $Res Function(_Wallet) _then) =
      __$WalletCopyWithImpl;
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
class __$WalletCopyWithImpl<$Res> implements _$WalletCopyWith<$Res> {
  __$WalletCopyWithImpl(this._self, this._then);

  final _Wallet _self;
  final $Res Function(_Wallet) _then;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Wallet(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      typeId: null == typeId
          ? _self.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      typeCreatedAt: null == typeCreatedAt
          ? _self.typeCreatedAt
          : typeCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      withdrawals: null == withdrawals
          ? _self.withdrawals
          : withdrawals // ignore: cast_nullable_to_non_nullable
              as bool,
      deposits: null == deposits
          ? _self.deposits
          : deposits // ignore: cast_nullable_to_non_nullable
              as bool,
      transfers: null == transfers
          ? _self.transfers
          : transfers // ignore: cast_nullable_to_non_nullable
              as bool,
      shopping: null == shopping
          ? _self.shopping
          : shopping // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      requireRsaId: null == requireRsaId
          ? _self.requireRsaId
          : requireRsaId // ignore: cast_nullable_to_non_nullable
              as bool,
      sortNumber: null == sortNumber
          ? _self.sortNumber
          : sortNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
