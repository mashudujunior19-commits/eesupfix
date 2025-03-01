// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hamper_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HamperProduct {
  @JsonKey(name: 'hamper_id')
  String get hamperId;
  @JsonKey(name: 'product_id')
  int get productId;
  int get quantity;
  @JsonKey(name: 'is_free')
  bool get isFree;

  /// Create a copy of HamperProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HamperProductCopyWith<HamperProduct> get copyWith =>
      _$HamperProductCopyWithImpl<HamperProduct>(
          this as HamperProduct, _$identity);

  /// Serializes this HamperProduct to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HamperProduct &&
            (identical(other.hamperId, hamperId) ||
                other.hamperId == hamperId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isFree, isFree) || other.isFree == isFree));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hamperId, productId, quantity, isFree);

  @override
  String toString() {
    return 'HamperProduct(hamperId: $hamperId, productId: $productId, quantity: $quantity, isFree: $isFree)';
  }
}

/// @nodoc
abstract mixin class $HamperProductCopyWith<$Res> {
  factory $HamperProductCopyWith(
          HamperProduct value, $Res Function(HamperProduct) _then) =
      _$HamperProductCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'hamper_id') String hamperId,
      @JsonKey(name: 'product_id') int productId,
      int quantity,
      @JsonKey(name: 'is_free') bool isFree});
}

/// @nodoc
class _$HamperProductCopyWithImpl<$Res>
    implements $HamperProductCopyWith<$Res> {
  _$HamperProductCopyWithImpl(this._self, this._then);

  final HamperProduct _self;
  final $Res Function(HamperProduct) _then;

  /// Create a copy of HamperProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hamperId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? isFree = null,
  }) {
    return _then(_self.copyWith(
      hamperId: null == hamperId
          ? _self.hamperId
          : hamperId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isFree: null == isFree
          ? _self.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _HamperProduct implements HamperProduct {
  _HamperProduct(
      {@JsonKey(name: 'hamper_id') required this.hamperId,
      @JsonKey(name: 'product_id') required this.productId,
      required this.quantity,
      @JsonKey(name: 'is_free') required this.isFree});
  factory _HamperProduct.fromJson(Map<String, dynamic> json) =>
      _$HamperProductFromJson(json);

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

  /// Create a copy of HamperProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HamperProductCopyWith<_HamperProduct> get copyWith =>
      __$HamperProductCopyWithImpl<_HamperProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HamperProductToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HamperProduct &&
            (identical(other.hamperId, hamperId) ||
                other.hamperId == hamperId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isFree, isFree) || other.isFree == isFree));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hamperId, productId, quantity, isFree);

  @override
  String toString() {
    return 'HamperProduct(hamperId: $hamperId, productId: $productId, quantity: $quantity, isFree: $isFree)';
  }
}

/// @nodoc
abstract mixin class _$HamperProductCopyWith<$Res>
    implements $HamperProductCopyWith<$Res> {
  factory _$HamperProductCopyWith(
          _HamperProduct value, $Res Function(_HamperProduct) _then) =
      __$HamperProductCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'hamper_id') String hamperId,
      @JsonKey(name: 'product_id') int productId,
      int quantity,
      @JsonKey(name: 'is_free') bool isFree});
}

/// @nodoc
class __$HamperProductCopyWithImpl<$Res>
    implements _$HamperProductCopyWith<$Res> {
  __$HamperProductCopyWithImpl(this._self, this._then);

  final _HamperProduct _self;
  final $Res Function(_HamperProduct) _then;

  /// Create a copy of HamperProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hamperId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? isFree = null,
  }) {
    return _then(_HamperProduct(
      hamperId: null == hamperId
          ? _self.hamperId
          : hamperId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isFree: null == isFree
          ? _self.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
