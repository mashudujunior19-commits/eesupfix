// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_gateway.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentGateway {
  @PaymentMethodConverter()
  PaymentMethod get id;
  @JsonKey(name: 'is_active')
  bool get isActive;
  double get fee;

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaymentGatewayCopyWith<PaymentGateway> get copyWith =>
      _$PaymentGatewayCopyWithImpl<PaymentGateway>(
          this as PaymentGateway, _$identity);

  /// Serializes this PaymentGateway to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaymentGateway &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isActive, fee);

  @override
  String toString() {
    return 'PaymentGateway(id: $id, isActive: $isActive, fee: $fee)';
  }
}

/// @nodoc
abstract mixin class $PaymentGatewayCopyWith<$Res> {
  factory $PaymentGatewayCopyWith(
          PaymentGateway value, $Res Function(PaymentGateway) _then) =
      _$PaymentGatewayCopyWithImpl;
  @useResult
  $Res call(
      {@PaymentMethodConverter() PaymentMethod id,
      @JsonKey(name: 'is_active') bool isActive,
      double fee});
}

/// @nodoc
class _$PaymentGatewayCopyWithImpl<$Res>
    implements $PaymentGatewayCopyWith<$Res> {
  _$PaymentGatewayCopyWithImpl(this._self, this._then);

  final PaymentGateway _self;
  final $Res Function(PaymentGateway) _then;

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isActive = null,
    Object? fee = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PaymentGateway implements PaymentGateway {
  const _PaymentGateway(
      {@PaymentMethodConverter() required this.id,
      @JsonKey(name: 'is_active') required this.isActive,
      required this.fee});
  factory _PaymentGateway.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayFromJson(json);

  @override
  @PaymentMethodConverter()
  final PaymentMethod id;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  final double fee;

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaymentGatewayCopyWith<_PaymentGateway> get copyWith =>
      __$PaymentGatewayCopyWithImpl<_PaymentGateway>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaymentGatewayToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaymentGateway &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isActive, fee);

  @override
  String toString() {
    return 'PaymentGateway(id: $id, isActive: $isActive, fee: $fee)';
  }
}

/// @nodoc
abstract mixin class _$PaymentGatewayCopyWith<$Res>
    implements $PaymentGatewayCopyWith<$Res> {
  factory _$PaymentGatewayCopyWith(
          _PaymentGateway value, $Res Function(_PaymentGateway) _then) =
      __$PaymentGatewayCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@PaymentMethodConverter() PaymentMethod id,
      @JsonKey(name: 'is_active') bool isActive,
      double fee});
}

/// @nodoc
class __$PaymentGatewayCopyWithImpl<$Res>
    implements _$PaymentGatewayCopyWith<$Res> {
  __$PaymentGatewayCopyWithImpl(this._self, this._then);

  final _PaymentGateway _self;
  final $Res Function(_PaymentGateway) _then;

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? isActive = null,
    Object? fee = null,
  }) {
    return _then(_PaymentGateway(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
