// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hamper_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HamperProduct _$HamperProductFromJson(Map<String, dynamic> json) {
  return _HamperProduct.fromJson(json);
}

/// @nodoc
mixin _$HamperProduct {
  @JsonKey(name: 'hamper_id')
  String get hamperId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_free')
  bool get isFree => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HamperProductCopyWith<HamperProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HamperProductCopyWith<$Res> {
  factory $HamperProductCopyWith(
          HamperProduct value, $Res Function(HamperProduct) then) =
      _$HamperProductCopyWithImpl<$Res, HamperProduct>;
  @useResult
  $Res call(
      {@JsonKey(name: 'hamper_id') String hamperId,
      @JsonKey(name: 'product_id') int productId,
      int quantity,
      @JsonKey(name: 'is_free') bool isFree});
}

/// @nodoc
class _$HamperProductCopyWithImpl<$Res, $Val extends HamperProduct>
    implements $HamperProductCopyWith<$Res> {
  _$HamperProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hamperId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? isFree = null,
  }) {
    return _then(_value.copyWith(
      hamperId: null == hamperId
          ? _value.hamperId
          : hamperId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HamperProductImplCopyWith<$Res>
    implements $HamperProductCopyWith<$Res> {
  factory _$$HamperProductImplCopyWith(
          _$HamperProductImpl value, $Res Function(_$HamperProductImpl) then) =
      __$$HamperProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'hamper_id') String hamperId,
      @JsonKey(name: 'product_id') int productId,
      int quantity,
      @JsonKey(name: 'is_free') bool isFree});
}

/// @nodoc
class __$$HamperProductImplCopyWithImpl<$Res>
    extends _$HamperProductCopyWithImpl<$Res, _$HamperProductImpl>
    implements _$$HamperProductImplCopyWith<$Res> {
  __$$HamperProductImplCopyWithImpl(
      _$HamperProductImpl _value, $Res Function(_$HamperProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hamperId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? isFree = null,
  }) {
    return _then(_$HamperProductImpl(
      hamperId: null == hamperId
          ? _value.hamperId
          : hamperId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HamperProductImpl implements _HamperProduct {
  _$HamperProductImpl(
      {@JsonKey(name: 'hamper_id') required this.hamperId,
      @JsonKey(name: 'product_id') required this.productId,
      required this.quantity,
      @JsonKey(name: 'is_free') required this.isFree});

  factory _$HamperProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$HamperProductImplFromJson(json);

  @override
  @JsonKey(name: 'hamper_id')
  final String hamperId;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'is_free')
  final bool isFree;

  @override
  String toString() {
    return 'HamperProduct(hamperId: $hamperId, productId: $productId, quantity: $quantity, isFree: $isFree)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HamperProductImpl &&
            (identical(other.hamperId, hamperId) ||
                other.hamperId == hamperId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isFree, isFree) || other.isFree == isFree));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hamperId, productId, quantity, isFree);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HamperProductImplCopyWith<_$HamperProductImpl> get copyWith =>
      __$$HamperProductImplCopyWithImpl<_$HamperProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HamperProductImplToJson(
      this,
    );
  }
}

abstract class _HamperProduct implements HamperProduct {
  factory _HamperProduct(
          {@JsonKey(name: 'hamper_id') required final String hamperId,
          @JsonKey(name: 'product_id') required final int productId,
          required final int quantity,
          @JsonKey(name: 'is_free') required final bool isFree}) =
      _$HamperProductImpl;

  factory _HamperProduct.fromJson(Map<String, dynamic> json) =
      _$HamperProductImpl.fromJson;

  @override
  @JsonKey(name: 'hamper_id')
  String get hamperId;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'is_free')
  bool get isFree;
  @override
  @JsonKey(ignore: true)
  _$$HamperProductImplCopyWith<_$HamperProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
