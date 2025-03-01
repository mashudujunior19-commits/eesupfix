// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mapped_product_hamper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HamperProductDetail {
  String get hamperId;
  int get productId;
  int get quantity;
  bool get isFree;
  String get name;
  String get brand;
  String get type;
  String get imageUrl;
  double get salePrice;
  double get costPrice;
  Product get product;

  /// Create a copy of HamperProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HamperProductDetailCopyWith<HamperProductDetail> get copyWith =>
      _$HamperProductDetailCopyWithImpl<HamperProductDetail>(
          this as HamperProductDetail, _$identity);

  /// Serializes this HamperProductDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HamperProductDetail &&
            (identical(other.hamperId, hamperId) ||
                other.hamperId == hamperId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hamperId, productId, quantity,
      isFree, name, brand, type, imageUrl, salePrice, costPrice, product);

  @override
  String toString() {
    return 'HamperProductDetail(hamperId: $hamperId, productId: $productId, quantity: $quantity, isFree: $isFree, name: $name, brand: $brand, type: $type, imageUrl: $imageUrl, salePrice: $salePrice, costPrice: $costPrice, product: $product)';
  }
}

/// @nodoc
abstract mixin class $HamperProductDetailCopyWith<$Res> {
  factory $HamperProductDetailCopyWith(
          HamperProductDetail value, $Res Function(HamperProductDetail) _then) =
      _$HamperProductDetailCopyWithImpl;
  @useResult
  $Res call(
      {String hamperId,
      int productId,
      int quantity,
      bool isFree,
      String name,
      String brand,
      String type,
      String imageUrl,
      double salePrice,
      double costPrice,
      Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$HamperProductDetailCopyWithImpl<$Res>
    implements $HamperProductDetailCopyWith<$Res> {
  _$HamperProductDetailCopyWithImpl(this._self, this._then);

  final HamperProductDetail _self;
  final $Res Function(HamperProductDetail) _then;

  /// Create a copy of HamperProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hamperId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? isFree = null,
    Object? name = null,
    Object? brand = null,
    Object? type = null,
    Object? imageUrl = null,
    Object? salePrice = null,
    Object? costPrice = null,
    Object? product = null,
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
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      salePrice: null == salePrice
          ? _self.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: null == costPrice
          ? _self.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double,
      product: null == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }

  /// Create a copy of HamperProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_self.product, (value) {
      return _then(_self.copyWith(product: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _HamperProductDetail implements HamperProductDetail {
  _HamperProductDetail(
      {required this.hamperId,
      required this.productId,
      required this.quantity,
      required this.isFree,
      required this.name,
      required this.brand,
      required this.type,
      required this.imageUrl,
      required this.salePrice,
      required this.costPrice,
      required this.product});
  factory _HamperProductDetail.fromJson(Map<String, dynamic> json) =>
      _$HamperProductDetailFromJson(json);

  @override
  final String hamperId;
  @override
  final int productId;
  @override
  final int quantity;
  @override
  final bool isFree;
  @override
  final String name;
  @override
  final String brand;
  @override
  final String type;
  @override
  final String imageUrl;
  @override
  final double salePrice;
  @override
  final double costPrice;
  @override
  final Product product;

  /// Create a copy of HamperProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HamperProductDetailCopyWith<_HamperProductDetail> get copyWith =>
      __$HamperProductDetailCopyWithImpl<_HamperProductDetail>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HamperProductDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HamperProductDetail &&
            (identical(other.hamperId, hamperId) ||
                other.hamperId == hamperId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hamperId, productId, quantity,
      isFree, name, brand, type, imageUrl, salePrice, costPrice, product);

  @override
  String toString() {
    return 'HamperProductDetail(hamperId: $hamperId, productId: $productId, quantity: $quantity, isFree: $isFree, name: $name, brand: $brand, type: $type, imageUrl: $imageUrl, salePrice: $salePrice, costPrice: $costPrice, product: $product)';
  }
}

/// @nodoc
abstract mixin class _$HamperProductDetailCopyWith<$Res>
    implements $HamperProductDetailCopyWith<$Res> {
  factory _$HamperProductDetailCopyWith(_HamperProductDetail value,
          $Res Function(_HamperProductDetail) _then) =
      __$HamperProductDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String hamperId,
      int productId,
      int quantity,
      bool isFree,
      String name,
      String brand,
      String type,
      String imageUrl,
      double salePrice,
      double costPrice,
      Product product});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$HamperProductDetailCopyWithImpl<$Res>
    implements _$HamperProductDetailCopyWith<$Res> {
  __$HamperProductDetailCopyWithImpl(this._self, this._then);

  final _HamperProductDetail _self;
  final $Res Function(_HamperProductDetail) _then;

  /// Create a copy of HamperProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hamperId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? isFree = null,
    Object? name = null,
    Object? brand = null,
    Object? type = null,
    Object? imageUrl = null,
    Object? salePrice = null,
    Object? costPrice = null,
    Object? product = null,
  }) {
    return _then(_HamperProductDetail(
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
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      salePrice: null == salePrice
          ? _self.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: null == costPrice
          ? _self.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double,
      product: null == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }

  /// Create a copy of HamperProductDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_self.product, (value) {
      return _then(_self.copyWith(product: value));
    });
  }
}

// dart format on
