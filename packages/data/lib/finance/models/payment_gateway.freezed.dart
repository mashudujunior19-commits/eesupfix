// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_gateway.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentGateway _$PaymentGatewayFromJson(Map<String, dynamic> json) {
  return _PaymentGateway.fromJson(json);
}

/// @nodoc
mixin _$PaymentGateway {
  @PaymentMethodConverter()
  PaymentMethod get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;

  /// Serializes this PaymentGateway to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentGatewayCopyWith<PaymentGateway> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentGatewayCopyWith<$Res> {
  factory $PaymentGatewayCopyWith(
          PaymentGateway value, $Res Function(PaymentGateway) then) =
      _$PaymentGatewayCopyWithImpl<$Res, PaymentGateway>;
  @useResult
  $Res call(
      {@PaymentMethodConverter() PaymentMethod id,
      @JsonKey(name: 'is_active') bool isActive,
      double fee});
}

/// @nodoc
class _$PaymentGatewayCopyWithImpl<$Res, $Val extends PaymentGateway>
    implements $PaymentGatewayCopyWith<$Res> {
  _$PaymentGatewayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isActive = null,
    Object? fee = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentGatewayImplCopyWith<$Res>
    implements $PaymentGatewayCopyWith<$Res> {
  factory _$$PaymentGatewayImplCopyWith(_$PaymentGatewayImpl value,
          $Res Function(_$PaymentGatewayImpl) then) =
      __$$PaymentGatewayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@PaymentMethodConverter() PaymentMethod id,
      @JsonKey(name: 'is_active') bool isActive,
      double fee});
}

/// @nodoc
class __$$PaymentGatewayImplCopyWithImpl<$Res>
    extends _$PaymentGatewayCopyWithImpl<$Res, _$PaymentGatewayImpl>
    implements _$$PaymentGatewayImplCopyWith<$Res> {
  __$$PaymentGatewayImplCopyWithImpl(
      _$PaymentGatewayImpl _value, $Res Function(_$PaymentGatewayImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isActive = null,
    Object? fee = null,
  }) {
    return _then(_$PaymentGatewayImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentGatewayImpl implements _PaymentGateway {
  const _$PaymentGatewayImpl(
      {@PaymentMethodConverter() required this.id,
      @JsonKey(name: 'is_active') required this.isActive,
      required this.fee});

  factory _$PaymentGatewayImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentGatewayImplFromJson(json);

  @override
  @PaymentMethodConverter()
  final PaymentMethod id;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  final double fee;

  @override
  String toString() {
    return 'PaymentGateway(id: $id, isActive: $isActive, fee: $fee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentGatewayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isActive, fee);

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentGatewayImplCopyWith<_$PaymentGatewayImpl> get copyWith =>
      __$$PaymentGatewayImplCopyWithImpl<_$PaymentGatewayImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentGatewayImplToJson(
      this,
    );
  }
}

abstract class _PaymentGateway implements PaymentGateway {
  const factory _PaymentGateway(
      {@PaymentMethodConverter() required final PaymentMethod id,
      @JsonKey(name: 'is_active') required final bool isActive,
      required final double fee}) = _$PaymentGatewayImpl;

  factory _PaymentGateway.fromJson(Map<String, dynamic> json) =
      _$PaymentGatewayImpl.fromJson;

  @override
  @PaymentMethodConverter()
  PaymentMethod get id;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  double get fee;

  /// Create a copy of PaymentGateway
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentGatewayImplCopyWith<_$PaymentGatewayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
