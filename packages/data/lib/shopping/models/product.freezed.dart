// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {
  int get id;
  @JsonKey(name: 'category_id')
  int? get categoryId;
  String get name;
  @JsonKey(name: 'description')
  String? get description;
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  String? get size;
  String? get brand;
  String? get type;
  String? get uom;
  @JsonKey(name: 'unit_pack_size')
  String? get unitPackSize;
  String? get flavour;
  @JsonKey(name: 'sale_price')
  double get salePrice;
  @JsonKey(name: 'cost_price')
  double? get costPrice;
  double? get vaa;
  double? get vat;
  @JsonKey(name: 'order_max')
  int? get orderMax;
  @JsonKey(name: 'child_id')
  int? get childId;
  @JsonKey(name: 'child_break_qty')
  int? get childBreakQty;
  @JsonKey(name: 'bar_code')
  String? get barCode;
  @JsonKey(name: 'kit_kat_ref')
  String? get kitKatRef;
  @JsonKey(name: 'vat_claimable')
  bool? get vatClaimable;
  @JsonKey(name: 'vat_able')
  bool? get vatAble;
  @ProductClassConverter()
  @JsonKey(name: 'class')
  ProductClass get productClass;
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @JsonKey(name: 'category_image_url')
  String? get categoryImageUrl;
  @JsonKey(name: 'hamper_id')
  String? get hamperId;
  bool get sellable;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductCopyWith<Product> get copyWith =>
      _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Product &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.uom, uom) || other.uom == uom) &&
            (identical(other.unitPackSize, unitPackSize) ||
                other.unitPackSize == unitPackSize) &&
            (identical(other.flavour, flavour) || other.flavour == flavour) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.vaa, vaa) || other.vaa == vaa) &&
            (identical(other.vat, vat) || other.vat == vat) &&
            (identical(other.orderMax, orderMax) ||
                other.orderMax == orderMax) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.childBreakQty, childBreakQty) ||
                other.childBreakQty == childBreakQty) &&
            (identical(other.barCode, barCode) || other.barCode == barCode) &&
            (identical(other.kitKatRef, kitKatRef) ||
                other.kitKatRef == kitKatRef) &&
            (identical(other.vatClaimable, vatClaimable) ||
                other.vatClaimable == vatClaimable) &&
            (identical(other.vatAble, vatAble) || other.vatAble == vatAble) &&
            (identical(other.productClass, productClass) ||
                other.productClass == productClass) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryImageUrl, categoryImageUrl) ||
                other.categoryImageUrl == categoryImageUrl) &&
            (identical(other.hamperId, hamperId) ||
                other.hamperId == hamperId) &&
            (identical(other.sellable, sellable) ||
                other.sellable == sellable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        categoryId,
        name,
        description,
        imageUrl,
        size,
        brand,
        type,
        uom,
        unitPackSize,
        flavour,
        salePrice,
        costPrice,
        vaa,
        vat,
        orderMax,
        childId,
        childBreakQty,
        barCode,
        kitKatRef,
        vatClaimable,
        vatAble,
        productClass,
        categoryName,
        categoryImageUrl,
        hamperId,
        sellable
      ]);

  @override
  String toString() {
    return 'Product(id: $id, categoryId: $categoryId, name: $name, description: $description, imageUrl: $imageUrl, size: $size, brand: $brand, type: $type, uom: $uom, unitPackSize: $unitPackSize, flavour: $flavour, salePrice: $salePrice, costPrice: $costPrice, vaa: $vaa, vat: $vat, orderMax: $orderMax, childId: $childId, childBreakQty: $childBreakQty, barCode: $barCode, kitKatRef: $kitKatRef, vatClaimable: $vatClaimable, vatAble: $vatAble, productClass: $productClass, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, hamperId: $hamperId, sellable: $sellable)';
  }
}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) =
      _$ProductCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'category_id') int? categoryId,
      String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? size,
      String? brand,
      String? type,
      String? uom,
      @JsonKey(name: 'unit_pack_size') String? unitPackSize,
      String? flavour,
      @JsonKey(name: 'sale_price') double salePrice,
      @JsonKey(name: 'cost_price') double? costPrice,
      double? vaa,
      double? vat,
      @JsonKey(name: 'order_max') int? orderMax,
      @JsonKey(name: 'child_id') int? childId,
      @JsonKey(name: 'child_break_qty') int? childBreakQty,
      @JsonKey(name: 'bar_code') String? barCode,
      @JsonKey(name: 'kit_kat_ref') String? kitKatRef,
      @JsonKey(name: 'vat_claimable') bool? vatClaimable,
      @JsonKey(name: 'vat_able') bool? vatAble,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      ProductClass productClass,
      @JsonKey(name: 'category_name') String? categoryName,
      @JsonKey(name: 'category_image_url') String? categoryImageUrl,
      @JsonKey(name: 'hamper_id') String? hamperId,
      bool sellable});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? size = freezed,
    Object? brand = freezed,
    Object? type = freezed,
    Object? uom = freezed,
    Object? unitPackSize = freezed,
    Object? flavour = freezed,
    Object? salePrice = null,
    Object? costPrice = freezed,
    Object? vaa = freezed,
    Object? vat = freezed,
    Object? orderMax = freezed,
    Object? childId = freezed,
    Object? childBreakQty = freezed,
    Object? barCode = freezed,
    Object? kitKatRef = freezed,
    Object? vatClaimable = freezed,
    Object? vatAble = freezed,
    Object? productClass = null,
    Object? categoryName = freezed,
    Object? categoryImageUrl = freezed,
    Object? hamperId = freezed,
    Object? sellable = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: freezed == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      uom: freezed == uom
          ? _self.uom
          : uom // ignore: cast_nullable_to_non_nullable
              as String?,
      unitPackSize: freezed == unitPackSize
          ? _self.unitPackSize
          : unitPackSize // ignore: cast_nullable_to_non_nullable
              as String?,
      flavour: freezed == flavour
          ? _self.flavour
          : flavour // ignore: cast_nullable_to_non_nullable
              as String?,
      salePrice: null == salePrice
          ? _self.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _self.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      vaa: freezed == vaa
          ? _self.vaa
          : vaa // ignore: cast_nullable_to_non_nullable
              as double?,
      vat: freezed == vat
          ? _self.vat
          : vat // ignore: cast_nullable_to_non_nullable
              as double?,
      orderMax: freezed == orderMax
          ? _self.orderMax
          : orderMax // ignore: cast_nullable_to_non_nullable
              as int?,
      childId: freezed == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int?,
      childBreakQty: freezed == childBreakQty
          ? _self.childBreakQty
          : childBreakQty // ignore: cast_nullable_to_non_nullable
              as int?,
      barCode: freezed == barCode
          ? _self.barCode
          : barCode // ignore: cast_nullable_to_non_nullable
              as String?,
      kitKatRef: freezed == kitKatRef
          ? _self.kitKatRef
          : kitKatRef // ignore: cast_nullable_to_non_nullable
              as String?,
      vatClaimable: freezed == vatClaimable
          ? _self.vatClaimable
          : vatClaimable // ignore: cast_nullable_to_non_nullable
              as bool?,
      vatAble: freezed == vatAble
          ? _self.vatAble
          : vatAble // ignore: cast_nullable_to_non_nullable
              as bool?,
      productClass: null == productClass
          ? _self.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass,
      categoryName: freezed == categoryName
          ? _self.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryImageUrl: freezed == categoryImageUrl
          ? _self.categoryImageUrl
          : categoryImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      hamperId: freezed == hamperId
          ? _self.hamperId
          : hamperId // ignore: cast_nullable_to_non_nullable
              as String?,
      sellable: null == sellable
          ? _self.sellable
          : sellable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Product implements Product {
  _Product(
      {required this.id,
      @JsonKey(name: 'category_id') this.categoryId,
      required this.name,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'image_url') this.imageUrl,
      this.size,
      this.brand,
      this.type,
      this.uom,
      @JsonKey(name: 'unit_pack_size') this.unitPackSize,
      this.flavour,
      @JsonKey(name: 'sale_price') required this.salePrice,
      @JsonKey(name: 'cost_price') this.costPrice,
      this.vaa,
      this.vat,
      @JsonKey(name: 'order_max') this.orderMax,
      @JsonKey(name: 'child_id') this.childId,
      @JsonKey(name: 'child_break_qty') this.childBreakQty,
      @JsonKey(name: 'bar_code') this.barCode,
      @JsonKey(name: 'kit_kat_ref') this.kitKatRef,
      @JsonKey(name: 'vat_claimable') this.vatClaimable,
      @JsonKey(name: 'vat_able') this.vatAble,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      required this.productClass,
      @JsonKey(name: 'category_name') this.categoryName,
      @JsonKey(name: 'category_image_url') this.categoryImageUrl,
      @JsonKey(name: 'hamper_id') this.hamperId,
      required this.sellable});
  factory _Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  final String name;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  final String? size;
  @override
  final String? brand;
  @override
  final String? type;
  @override
  final String? uom;
  @override
  @JsonKey(name: 'unit_pack_size')
  final String? unitPackSize;
  @override
  final String? flavour;
  @override
  @JsonKey(name: 'sale_price')
  final double salePrice;
  @override
  @JsonKey(name: 'cost_price')
  final double? costPrice;
  @override
  final double? vaa;
  @override
  final double? vat;
  @override
  @JsonKey(name: 'order_max')
  final int? orderMax;
  @override
  @JsonKey(name: 'child_id')
  final int? childId;
  @override
  @JsonKey(name: 'child_break_qty')
  final int? childBreakQty;
  @override
  @JsonKey(name: 'bar_code')
  final String? barCode;
  @override
  @JsonKey(name: 'kit_kat_ref')
  final String? kitKatRef;
  @override
  @JsonKey(name: 'vat_claimable')
  final bool? vatClaimable;
  @override
  @JsonKey(name: 'vat_able')
  final bool? vatAble;
  @override
  @ProductClassConverter()
  @JsonKey(name: 'class')
  final ProductClass productClass;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'category_image_url')
  final String? categoryImageUrl;
  @override
  @JsonKey(name: 'hamper_id')
  final String? hamperId;
  @override
  final bool sellable;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductCopyWith<_Product> get copyWith =>
      __$ProductCopyWithImpl<_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Product &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.uom, uom) || other.uom == uom) &&
            (identical(other.unitPackSize, unitPackSize) ||
                other.unitPackSize == unitPackSize) &&
            (identical(other.flavour, flavour) || other.flavour == flavour) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.vaa, vaa) || other.vaa == vaa) &&
            (identical(other.vat, vat) || other.vat == vat) &&
            (identical(other.orderMax, orderMax) ||
                other.orderMax == orderMax) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.childBreakQty, childBreakQty) ||
                other.childBreakQty == childBreakQty) &&
            (identical(other.barCode, barCode) || other.barCode == barCode) &&
            (identical(other.kitKatRef, kitKatRef) ||
                other.kitKatRef == kitKatRef) &&
            (identical(other.vatClaimable, vatClaimable) ||
                other.vatClaimable == vatClaimable) &&
            (identical(other.vatAble, vatAble) || other.vatAble == vatAble) &&
            (identical(other.productClass, productClass) ||
                other.productClass == productClass) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryImageUrl, categoryImageUrl) ||
                other.categoryImageUrl == categoryImageUrl) &&
            (identical(other.hamperId, hamperId) ||
                other.hamperId == hamperId) &&
            (identical(other.sellable, sellable) ||
                other.sellable == sellable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        categoryId,
        name,
        description,
        imageUrl,
        size,
        brand,
        type,
        uom,
        unitPackSize,
        flavour,
        salePrice,
        costPrice,
        vaa,
        vat,
        orderMax,
        childId,
        childBreakQty,
        barCode,
        kitKatRef,
        vatClaimable,
        vatAble,
        productClass,
        categoryName,
        categoryImageUrl,
        hamperId,
        sellable
      ]);

  @override
  String toString() {
    return 'Product(id: $id, categoryId: $categoryId, name: $name, description: $description, imageUrl: $imageUrl, size: $size, brand: $brand, type: $type, uom: $uom, unitPackSize: $unitPackSize, flavour: $flavour, salePrice: $salePrice, costPrice: $costPrice, vaa: $vaa, vat: $vat, orderMax: $orderMax, childId: $childId, childBreakQty: $childBreakQty, barCode: $barCode, kitKatRef: $kitKatRef, vatClaimable: $vatClaimable, vatAble: $vatAble, productClass: $productClass, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, hamperId: $hamperId, sellable: $sellable)';
  }
}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) =
      __$ProductCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'category_id') int? categoryId,
      String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? size,
      String? brand,
      String? type,
      String? uom,
      @JsonKey(name: 'unit_pack_size') String? unitPackSize,
      String? flavour,
      @JsonKey(name: 'sale_price') double salePrice,
      @JsonKey(name: 'cost_price') double? costPrice,
      double? vaa,
      double? vat,
      @JsonKey(name: 'order_max') int? orderMax,
      @JsonKey(name: 'child_id') int? childId,
      @JsonKey(name: 'child_break_qty') int? childBreakQty,
      @JsonKey(name: 'bar_code') String? barCode,
      @JsonKey(name: 'kit_kat_ref') String? kitKatRef,
      @JsonKey(name: 'vat_claimable') bool? vatClaimable,
      @JsonKey(name: 'vat_able') bool? vatAble,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      ProductClass productClass,
      @JsonKey(name: 'category_name') String? categoryName,
      @JsonKey(name: 'category_image_url') String? categoryImageUrl,
      @JsonKey(name: 'hamper_id') String? hamperId,
      bool sellable});
}

/// @nodoc
class __$ProductCopyWithImpl<$Res> implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? categoryId = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? size = freezed,
    Object? brand = freezed,
    Object? type = freezed,
    Object? uom = freezed,
    Object? unitPackSize = freezed,
    Object? flavour = freezed,
    Object? salePrice = null,
    Object? costPrice = freezed,
    Object? vaa = freezed,
    Object? vat = freezed,
    Object? orderMax = freezed,
    Object? childId = freezed,
    Object? childBreakQty = freezed,
    Object? barCode = freezed,
    Object? kitKatRef = freezed,
    Object? vatClaimable = freezed,
    Object? vatAble = freezed,
    Object? productClass = null,
    Object? categoryName = freezed,
    Object? categoryImageUrl = freezed,
    Object? hamperId = freezed,
    Object? sellable = null,
  }) {
    return _then(_Product(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: freezed == categoryId
          ? _self.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      uom: freezed == uom
          ? _self.uom
          : uom // ignore: cast_nullable_to_non_nullable
              as String?,
      unitPackSize: freezed == unitPackSize
          ? _self.unitPackSize
          : unitPackSize // ignore: cast_nullable_to_non_nullable
              as String?,
      flavour: freezed == flavour
          ? _self.flavour
          : flavour // ignore: cast_nullable_to_non_nullable
              as String?,
      salePrice: null == salePrice
          ? _self.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _self.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      vaa: freezed == vaa
          ? _self.vaa
          : vaa // ignore: cast_nullable_to_non_nullable
              as double?,
      vat: freezed == vat
          ? _self.vat
          : vat // ignore: cast_nullable_to_non_nullable
              as double?,
      orderMax: freezed == orderMax
          ? _self.orderMax
          : orderMax // ignore: cast_nullable_to_non_nullable
              as int?,
      childId: freezed == childId
          ? _self.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int?,
      childBreakQty: freezed == childBreakQty
          ? _self.childBreakQty
          : childBreakQty // ignore: cast_nullable_to_non_nullable
              as int?,
      barCode: freezed == barCode
          ? _self.barCode
          : barCode // ignore: cast_nullable_to_non_nullable
              as String?,
      kitKatRef: freezed == kitKatRef
          ? _self.kitKatRef
          : kitKatRef // ignore: cast_nullable_to_non_nullable
              as String?,
      vatClaimable: freezed == vatClaimable
          ? _self.vatClaimable
          : vatClaimable // ignore: cast_nullable_to_non_nullable
              as bool?,
      vatAble: freezed == vatAble
          ? _self.vatAble
          : vatAble // ignore: cast_nullable_to_non_nullable
              as bool?,
      productClass: null == productClass
          ? _self.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass,
      categoryName: freezed == categoryName
          ? _self.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryImageUrl: freezed == categoryImageUrl
          ? _self.categoryImageUrl
          : categoryImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      hamperId: freezed == hamperId
          ? _self.hamperId
          : hamperId // ignore: cast_nullable_to_non_nullable
              as String?,
      sellable: null == sellable
          ? _self.sellable
          : sellable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
