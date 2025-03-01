// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoucherParameter {
  @JsonKey(name: 'id')
  String get id;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @JsonKey(name: 'period')
  int get period;
  @JsonKey(name: 'interest')
  double get interest;
  @JsonKey(name: 'minimum_value')
  double get minimumValue;

  /// Create a copy of VoucherParameter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VoucherParameterCopyWith<VoucherParameter> get copyWith =>
      _$VoucherParameterCopyWithImpl<VoucherParameter>(
          this as VoucherParameter, _$identity);

  /// Serializes this VoucherParameter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VoucherParameter &&
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

  @override
  String toString() {
    return 'VoucherParameter(id: $id, createdAt: $createdAt, period: $period, interest: $interest, minimumValue: $minimumValue)';
  }
}

/// @nodoc
abstract mixin class $VoucherParameterCopyWith<$Res> {
  factory $VoucherParameterCopyWith(
          VoucherParameter value, $Res Function(VoucherParameter) _then) =
      _$VoucherParameterCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'period') int period,
      @JsonKey(name: 'interest') double interest,
      @JsonKey(name: 'minimum_value') double minimumValue});
}

/// @nodoc
class _$VoucherParameterCopyWithImpl<$Res>
    implements $VoucherParameterCopyWith<$Res> {
  _$VoucherParameterCopyWithImpl(this._self, this._then);

  final VoucherParameter _self;
  final $Res Function(VoucherParameter) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      interest: null == interest
          ? _self.interest
          : interest // ignore: cast_nullable_to_non_nullable
              as double,
      minimumValue: null == minimumValue
          ? _self.minimumValue
          : minimumValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _VoucherParameter implements VoucherParameter {
  const _VoucherParameter(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'period') required this.period,
      @JsonKey(name: 'interest') required this.interest,
      @JsonKey(name: 'minimum_value') required this.minimumValue});
  factory _VoucherParameter.fromJson(Map<String, dynamic> json) =>
      _$VoucherParameterFromJson(json);

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

  /// Create a copy of VoucherParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VoucherParameterCopyWith<_VoucherParameter> get copyWith =>
      __$VoucherParameterCopyWithImpl<_VoucherParameter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VoucherParameterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VoucherParameter &&
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

  @override
  String toString() {
    return 'VoucherParameter(id: $id, createdAt: $createdAt, period: $period, interest: $interest, minimumValue: $minimumValue)';
  }
}

/// @nodoc
abstract mixin class _$VoucherParameterCopyWith<$Res>
    implements $VoucherParameterCopyWith<$Res> {
  factory _$VoucherParameterCopyWith(
          _VoucherParameter value, $Res Function(_VoucherParameter) _then) =
      __$VoucherParameterCopyWithImpl;
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
class __$VoucherParameterCopyWithImpl<$Res>
    implements _$VoucherParameterCopyWith<$Res> {
  __$VoucherParameterCopyWithImpl(this._self, this._then);

  final _VoucherParameter _self;
  final $Res Function(_VoucherParameter) _then;

  /// Create a copy of VoucherParameter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? period = null,
    Object? interest = null,
    Object? minimumValue = null,
  }) {
    return _then(_VoucherParameter(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      interest: null == interest
          ? _self.interest
          : interest // ignore: cast_nullable_to_non_nullable
              as double,
      minimumValue: null == minimumValue
          ? _self.minimumValue
          : minimumValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
