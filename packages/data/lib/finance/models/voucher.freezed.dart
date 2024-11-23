// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return _Voucher.fromJson(json);
}

/// @nodoc
mixin _$Voucher {
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'parameter_id')
  String get parameterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance')
  double get balance => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  double get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @VoucherCycleConverter()
  @JsonKey(name: 'cycle')
  VoucherCycle get cycle => throw _privateConstructorUsedError;
  int get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  DateTime get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirmed_at')
  DateTime? get confirmedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherCopyWith<Voucher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherCopyWith<$Res> {
  factory $VoucherCopyWith(Voucher value, $Res Function(Voucher) then) =
      _$VoucherCopyWithImpl<$Res, Voucher>;
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
class _$VoucherCopyWithImpl<$Res, $Val extends Voucher>
    implements $VoucherCopyWith<$Res> {
  _$VoucherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      parameterId: null == parameterId
          ? _value.parameterId
          : parameterId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      cycle: null == cycle
          ? _value.cycle
          : cycle // ignore: cast_nullable_to_non_nullable
              as VoucherCycle,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherImplCopyWith<$Res> implements $VoucherCopyWith<$Res> {
  factory _$$VoucherImplCopyWith(
          _$VoucherImpl value, $Res Function(_$VoucherImpl) then) =
      __$$VoucherImplCopyWithImpl<$Res>;
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
class __$$VoucherImplCopyWithImpl<$Res>
    extends _$VoucherCopyWithImpl<$Res, _$VoucherImpl>
    implements _$$VoucherImplCopyWith<$Res> {
  __$$VoucherImplCopyWithImpl(
      _$VoucherImpl _value, $Res Function(_$VoucherImpl) _then)
      : super(_value, _then);

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
    return _then(_$VoucherImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      parameterId: null == parameterId
          ? _value.parameterId
          : parameterId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      cycle: null == cycle
          ? _value.cycle
          : cycle // ignore: cast_nullable_to_non_nullable
              as VoucherCycle,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherImpl implements _Voucher {
  const _$VoucherImpl(
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

  factory _$VoucherImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherImplFromJson(json);

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

  @override
  String toString() {
    return 'Voucher(userId: $userId, parameterId: $parameterId, createdAt: $createdAt, balance: $balance, value: $value, id: $id, cycle: $cycle, period: $period, endDate: $endDate, confirmedAt: $confirmedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, parameterId, createdAt,
      balance, value, id, cycle, period, endDate, confirmedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherImplCopyWith<_$VoucherImpl> get copyWith =>
      __$$VoucherImplCopyWithImpl<_$VoucherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherImplToJson(
      this,
    );
  }
}

abstract class _Voucher implements Voucher {
  const factory _Voucher(
          {@JsonKey(name: 'user_id') final String? userId,
          @JsonKey(name: 'parameter_id') required final String parameterId,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'balance') required final double balance,
          @JsonKey(name: 'value') required final double value,
          @JsonKey(name: 'id') final int? id,
          @VoucherCycleConverter()
          @JsonKey(name: 'cycle')
          required final VoucherCycle cycle,
          required final int period,
          @JsonKey(name: 'end_date') required final DateTime endDate,
          @JsonKey(name: 'confirmed_at') final DateTime? confirmedAt}) =
      _$VoucherImpl;

  factory _Voucher.fromJson(Map<String, dynamic> json) = _$VoucherImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'parameter_id')
  String get parameterId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'balance')
  double get balance;
  @override
  @JsonKey(name: 'value')
  double get value;
  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @VoucherCycleConverter()
  @JsonKey(name: 'cycle')
  VoucherCycle get cycle;
  @override
  int get period;
  @override
  @JsonKey(name: 'end_date')
  DateTime get endDate;
  @override
  @JsonKey(name: 'confirmed_at')
  DateTime? get confirmedAt;
  @override
  @JsonKey(ignore: true)
  _$$VoucherImplCopyWith<_$VoucherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
