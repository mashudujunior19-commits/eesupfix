// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Voucher {
  @JsonKey(name: 'user_id')
  String? get userId;
  @JsonKey(name: 'parameter_id')
  String get parameterId;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'balance')
  double get balance;
  @JsonKey(name: 'value')
  double get value;
  @JsonKey(name: 'id')
  int? get id;
  @VoucherCycleConverter()
  @JsonKey(name: 'cycle')
  VoucherCycle get cycle;
  int get period;
  @JsonKey(name: 'end_date')
  DateTime get endDate;
  @JsonKey(name: 'confirmed_at')
  DateTime? get confirmedAt;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VoucherCopyWith<Voucher> get copyWith =>
      _$VoucherCopyWithImpl<Voucher>(this as Voucher, _$identity);

  /// Serializes this Voucher to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Voucher &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.parameterId, parameterId) ||
                other.parameterId == parameterId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cycle, cycle) || other.cycle == cycle) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, parameterId, createdAt,
      balance, value, id, cycle, period, endDate, confirmedAt);

  @override
  String toString() {
    return 'Voucher(userId: $userId, parameterId: $parameterId, createdAt: $createdAt, balance: $balance, value: $value, id: $id, cycle: $cycle, period: $period, endDate: $endDate, confirmedAt: $confirmedAt)';
  }
}

/// @nodoc
abstract mixin class $VoucherCopyWith<$Res> {
  factory $VoucherCopyWith(Voucher value, $Res Function(Voucher) _then) =
      _$VoucherCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'parameter_id') String parameterId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'balance') double balance,
      @JsonKey(name: 'value') double value,
      @JsonKey(name: 'id') int? id,
      @VoucherCycleConverter() @JsonKey(name: 'cycle') VoucherCycle cycle,
      int period,
      @JsonKey(name: 'end_date') DateTime endDate,
      @JsonKey(name: 'confirmed_at') DateTime? confirmedAt});
}

/// @nodoc
class _$VoucherCopyWithImpl<$Res> implements $VoucherCopyWith<$Res> {
  _$VoucherCopyWithImpl(this._self, this._then);

  final Voucher _self;
  final $Res Function(Voucher) _then;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? parameterId = null,
    Object? createdAt = null,
    Object? balance = null,
    Object? value = null,
    Object? id = freezed,
    Object? cycle = null,
    Object? period = null,
    Object? endDate = null,
    Object? confirmedAt = freezed,
  }) {
    return _then(_self.copyWith(
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      parameterId: null == parameterId
          ? _self.parameterId
          : parameterId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      cycle: null == cycle
          ? _self.cycle
          : cycle // ignore: cast_nullable_to_non_nullable
              as VoucherCycle,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confirmedAt: freezed == confirmedAt
          ? _self.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Voucher implements Voucher {
  const _Voucher(
      {@JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'parameter_id') required this.parameterId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'balance') required this.balance,
      @JsonKey(name: 'value') required this.value,
      @JsonKey(name: 'id') this.id,
      @VoucherCycleConverter() @JsonKey(name: 'cycle') required this.cycle,
      required this.period,
      @JsonKey(name: 'end_date') required this.endDate,
      @JsonKey(name: 'confirmed_at') this.confirmedAt});
  factory _Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'parameter_id')
  final String parameterId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'balance')
  final double balance;
  @override
  @JsonKey(name: 'value')
  final double value;
  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @VoucherCycleConverter()
  @JsonKey(name: 'cycle')
  final VoucherCycle cycle;
  @override
  final int period;
  @override
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @override
  @JsonKey(name: 'confirmed_at')
  final DateTime? confirmedAt;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VoucherCopyWith<_Voucher> get copyWith =>
      __$VoucherCopyWithImpl<_Voucher>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VoucherToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Voucher &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.parameterId, parameterId) ||
                other.parameterId == parameterId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cycle, cycle) || other.cycle == cycle) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, parameterId, createdAt,
      balance, value, id, cycle, period, endDate, confirmedAt);

  @override
  String toString() {
    return 'Voucher(userId: $userId, parameterId: $parameterId, createdAt: $createdAt, balance: $balance, value: $value, id: $id, cycle: $cycle, period: $period, endDate: $endDate, confirmedAt: $confirmedAt)';
  }
}

/// @nodoc
abstract mixin class _$VoucherCopyWith<$Res> implements $VoucherCopyWith<$Res> {
  factory _$VoucherCopyWith(_Voucher value, $Res Function(_Voucher) _then) =
      __$VoucherCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'parameter_id') String parameterId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'balance') double balance,
      @JsonKey(name: 'value') double value,
      @JsonKey(name: 'id') int? id,
      @VoucherCycleConverter() @JsonKey(name: 'cycle') VoucherCycle cycle,
      int period,
      @JsonKey(name: 'end_date') DateTime endDate,
      @JsonKey(name: 'confirmed_at') DateTime? confirmedAt});
}

/// @nodoc
class __$VoucherCopyWithImpl<$Res> implements _$VoucherCopyWith<$Res> {
  __$VoucherCopyWithImpl(this._self, this._then);

  final _Voucher _self;
  final $Res Function(_Voucher) _then;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = freezed,
    Object? parameterId = null,
    Object? createdAt = null,
    Object? balance = null,
    Object? value = null,
    Object? id = freezed,
    Object? cycle = null,
    Object? period = null,
    Object? endDate = null,
    Object? confirmedAt = freezed,
  }) {
    return _then(_Voucher(
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      parameterId: null == parameterId
          ? _self.parameterId
          : parameterId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      cycle: null == cycle
          ? _self.cycle
          : cycle // ignore: cast_nullable_to_non_nullable
              as VoucherCycle,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confirmedAt: freezed == confirmedAt
          ? _self.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
