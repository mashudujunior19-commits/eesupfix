// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoucherParameter _$VoucherParameterFromJson(Map<String, dynamic> json) {
  return _VoucherParameter.fromJson(json);
}

/// @nodoc
mixin _$VoucherParameter {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'period')
  int get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'interest')
  double get interest => throw _privateConstructorUsedError;
  @JsonKey(name: 'minimum_value')
  double get minimumValue => throw _privateConstructorUsedError;

  /// Serializes this VoucherParameter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoucherParameter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoucherParameterCopyWith<VoucherParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherParameterCopyWith<$Res> {
  factory $VoucherParameterCopyWith(
          VoucherParameter value, $Res Function(VoucherParameter) then) =
      _$VoucherParameterCopyWithImpl<$Res, VoucherParameter>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'period') int period,
      @JsonKey(name: 'interest') double interest,
      @JsonKey(name: 'minimum_value') double minimumValue});
}

/// @nodoc
class _$VoucherParameterCopyWithImpl<$Res, $Val extends VoucherParameter>
    implements $VoucherParameterCopyWith<$Res> {
  _$VoucherParameterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoucherParameter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? period = null,
    Object? interest = null,
    Object? minimumValue = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      interest: null == interest
          ? _value.interest
          : interest // ignore: cast_nullable_to_non_nullable
              as double,
      minimumValue: null == minimumValue
          ? _value.minimumValue
          : minimumValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherParameterImplCopyWith<$Res>
    implements $VoucherParameterCopyWith<$Res> {
  factory _$$VoucherParameterImplCopyWith(_$VoucherParameterImpl value,
          $Res Function(_$VoucherParameterImpl) then) =
      __$$VoucherParameterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'period') int period,
      @JsonKey(name: 'interest') double interest,
      @JsonKey(name: 'minimum_value') double minimumValue});
}

/// @nodoc
class __$$VoucherParameterImplCopyWithImpl<$Res>
    extends _$VoucherParameterCopyWithImpl<$Res, _$VoucherParameterImpl>
    implements _$$VoucherParameterImplCopyWith<$Res> {
  __$$VoucherParameterImplCopyWithImpl(_$VoucherParameterImpl _value,
      $Res Function(_$VoucherParameterImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoucherParameter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? period = null,
    Object? interest = null,
    Object? minimumValue = null,
  }) {
    return _then(_$VoucherParameterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      interest: null == interest
          ? _value.interest
          : interest // ignore: cast_nullable_to_non_nullable
              as double,
      minimumValue: null == minimumValue
          ? _value.minimumValue
          : minimumValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherParameterImpl implements _VoucherParameter {
  const _$VoucherParameterImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'period') required this.period,
      @JsonKey(name: 'interest') required this.interest,
      @JsonKey(name: 'minimum_value') required this.minimumValue});

  factory _$VoucherParameterImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherParameterImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'period')
  final int period;
  @override
  @JsonKey(name: 'interest')
  final double interest;
  @override
  @JsonKey(name: 'minimum_value')
  final double minimumValue;

  @override
  String toString() {
    return 'VoucherParameter(id: $id, createdAt: $createdAt, period: $period, interest: $interest, minimumValue: $minimumValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherParameterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.interest, interest) ||
                other.interest == interest) &&
            (identical(other.minimumValue, minimumValue) ||
                other.minimumValue == minimumValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, createdAt, period, interest, minimumValue);

  /// Create a copy of VoucherParameter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherParameterImplCopyWith<_$VoucherParameterImpl> get copyWith =>
      __$$VoucherParameterImplCopyWithImpl<_$VoucherParameterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherParameterImplToJson(
      this,
    );
  }
}

abstract class _VoucherParameter implements VoucherParameter {
  const factory _VoucherParameter(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'period') required final int period,
          @JsonKey(name: 'interest') required final double interest,
          @JsonKey(name: 'minimum_value') required final double minimumValue}) =
      _$VoucherParameterImpl;

  factory _VoucherParameter.fromJson(Map<String, dynamic> json) =
      _$VoucherParameterImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'period')
  int get period;
  @override
  @JsonKey(name: 'interest')
  double get interest;
  @override
  @JsonKey(name: 'minimum_value')
  double get minimumValue;

  /// Create a copy of VoucherParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherParameterImplCopyWith<_$VoucherParameterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
