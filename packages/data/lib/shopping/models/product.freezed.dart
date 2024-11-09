// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get uom => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_pack_size')
  String? get unitPackSize => throw _privateConstructorUsedError;
  String? get flavour => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_price')
  double get salePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'cost_price')
  double? get costPrice => throw _privateConstructorUsedError;
  double? get vaa => throw _privateConstructorUsedError;
  double? get vat => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_max')
  int? get orderMax => throw _privateConstructorUsedError;
  @JsonKey(name: 'child_id')
  int? get childId => throw _privateConstructorUsedError;
  @JsonKey(name: 'child_break_qty')
  int? get childBreakQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'bar_code')
  String? get barCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'kit_kat_ref')
  String? get kitKatRef => throw _privateConstructorUsedError;
  @JsonKey(name: 'vat_claimable')
  bool? get vatClaimable => throw _privateConstructorUsedError;
  @JsonKey(name: 'vat_able')
  bool? get vatAble => throw _privateConstructorUsedError;
  @ProductClassConverter()
  @JsonKey(name: 'class')
  ProductClass get productClass => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_image_url')
  String? get categoryImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'hamper_id')
  String? get hamperId => throw _privateConstructorUsedError;
  bool get sellable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
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
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      uom: freezed == uom
          ? _value.uom
          : uom // ignore: cast_nullable_to_non_nullable
              as String?,
      unitPackSize: freezed == unitPackSize
          ? _value.unitPackSize
          : unitPackSize // ignore: cast_nullable_to_non_nullable
              as String?,
      flavour: freezed == flavour
          ? _value.flavour
          : flavour // ignore: cast_nullable_to_non_nullable
              as String?,
      salePrice: null == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      vaa: freezed == vaa
          ? _value.vaa
          : vaa // ignore: cast_nullable_to_non_nullable
              as double?,
      vat: freezed == vat
          ? _value.vat
          : vat // ignore: cast_nullable_to_non_nullable
              as double?,
      orderMax: freezed == orderMax
          ? _value.orderMax
          : orderMax // ignore: cast_nullable_to_non_nullable
              as int?,
      childId: freezed == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int?,
      childBreakQty: freezed == childBreakQty
          ? _value.childBreakQty
          : childBreakQty // ignore: cast_nullable_to_non_nullable
              as int?,
      barCode: freezed == barCode
          ? _value.barCode
          : barCode // ignore: cast_nullable_to_non_nullable
              as String?,
      kitKatRef: freezed == kitKatRef
          ? _value.kitKatRef
          : kitKatRef // ignore: cast_nullable_to_non_nullable
              as String?,
      vatClaimable: freezed == vatClaimable
          ? _value.vatClaimable
          : vatClaimable // ignore: cast_nullable_to_non_nullable
              as bool?,
      vatAble: freezed == vatAble
          ? _value.vatAble
          : vatAble // ignore: cast_nullable_to_non_nullable
              as bool?,
      productClass: null == productClass
          ? _value.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryImageUrl: freezed == categoryImageUrl
          ? _value.categoryImageUrl
          : categoryImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      hamperId: freezed == hamperId
          ? _value.hamperId
          : hamperId // ignore: cast_nullable_to_non_nullable
              as String?,
      sellable: null == sellable
          ? _value.sellable
          : sellable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
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
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

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
    return _then(_$ProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      uom: freezed == uom
          ? _value.uom
          : uom // ignore: cast_nullable_to_non_nullable
              as String?,
      unitPackSize: freezed == unitPackSize
          ? _value.unitPackSize
          : unitPackSize // ignore: cast_nullable_to_non_nullable
              as String?,
      flavour: freezed == flavour
          ? _value.flavour
          : flavour // ignore: cast_nullable_to_non_nullable
              as String?,
      salePrice: null == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      vaa: freezed == vaa
          ? _value.vaa
          : vaa // ignore: cast_nullable_to_non_nullable
              as double?,
      vat: freezed == vat
          ? _value.vat
          : vat // ignore: cast_nullable_to_non_nullable
              as double?,
      orderMax: freezed == orderMax
          ? _value.orderMax
          : orderMax // ignore: cast_nullable_to_non_nullable
              as int?,
      childId: freezed == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int?,
      childBreakQty: freezed == childBreakQty
          ? _value.childBreakQty
          : childBreakQty // ignore: cast_nullable_to_non_nullable
              as int?,
      barCode: freezed == barCode
          ? _value.barCode
          : barCode // ignore: cast_nullable_to_non_nullable
              as String?,
      kitKatRef: freezed == kitKatRef
          ? _value.kitKatRef
          : kitKatRef // ignore: cast_nullable_to_non_nullable
              as String?,
      vatClaimable: freezed == vatClaimable
          ? _value.vatClaimable
          : vatClaimable // ignore: cast_nullable_to_non_nullable
              as bool?,
      vatAble: freezed == vatAble
          ? _value.vatAble
          : vatAble // ignore: cast_nullable_to_non_nullable
              as bool?,
      productClass: null == productClass
          ? _value.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryImageUrl: freezed == categoryImageUrl
          ? _value.categoryImageUrl
          : categoryImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      hamperId: freezed == hamperId
          ? _value.hamperId
          : hamperId // ignore: cast_nullable_to_non_nullable
              as String?,
      sellable: null == sellable
          ? _value.sellable
          : sellable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  _$ProductImpl(
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

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

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

  @override
  String toString() {
    return 'Product(id: $id, categoryId: $categoryId, name: $name, description: $description, imageUrl: $imageUrl, size: $size, brand: $brand, type: $type, uom: $uom, unitPackSize: $unitPackSize, flavour: $flavour, salePrice: $salePrice, costPrice: $costPrice, vaa: $vaa, vat: $vat, orderMax: $orderMax, childId: $childId, childBreakQty: $childBreakQty, barCode: $barCode, kitKatRef: $kitKatRef, vatClaimable: $vatClaimable, vatAble: $vatAble, productClass: $productClass, categoryName: $categoryName, categoryImageUrl: $categoryImageUrl, hamperId: $hamperId, sellable: $sellable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  factory _Product(
      {required final int id,
      @JsonKey(name: 'category_id') final int? categoryId,
      required final String name,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final String? size,
      final String? brand,
      final String? type,
      final String? uom,
      @JsonKey(name: 'unit_pack_size') final String? unitPackSize,
      final String? flavour,
      @JsonKey(name: 'sale_price') required final double salePrice,
      @JsonKey(name: 'cost_price') final double? costPrice,
      final double? vaa,
      final double? vat,
      @JsonKey(name: 'order_max') final int? orderMax,
      @JsonKey(name: 'child_id') final int? childId,
      @JsonKey(name: 'child_break_qty') final int? childBreakQty,
      @JsonKey(name: 'bar_code') final String? barCode,
      @JsonKey(name: 'kit_kat_ref') final String? kitKatRef,
      @JsonKey(name: 'vat_claimable') final bool? vatClaimable,
      @JsonKey(name: 'vat_able') final bool? vatAble,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      required final ProductClass productClass,
      @JsonKey(name: 'category_name') final String? categoryName,
      @JsonKey(name: 'category_image_url') final String? categoryImageUrl,
      @JsonKey(name: 'hamper_id') final String? hamperId,
      required final bool sellable}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  String get name;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  String? get size;
  @override
  String? get brand;
  @override
  String? get type;
  @override
  String? get uom;
  @override
  @JsonKey(name: 'unit_pack_size')
  String? get unitPackSize;
  @override
  String? get flavour;
  @override
  @JsonKey(name: 'sale_price')
  double get salePrice;
  @override
  @JsonKey(name: 'cost_price')
  double? get costPrice;
  @override
  double? get vaa;
  @override
  double? get vat;
  @override
  @JsonKey(name: 'order_max')
  int? get orderMax;
  @override
  @JsonKey(name: 'child_id')
  int? get childId;
  @override
  @JsonKey(name: 'child_break_qty')
  int? get childBreakQty;
  @override
  @JsonKey(name: 'bar_code')
  String? get barCode;
  @override
  @JsonKey(name: 'kit_kat_ref')
  String? get kitKatRef;
  @override
  @JsonKey(name: 'vat_claimable')
  bool? get vatClaimable;
  @override
  @JsonKey(name: 'vat_able')
  bool? get vatAble;
  @override
  @ProductClassConverter()
  @JsonKey(name: 'class')
  ProductClass get productClass;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'category_image_url')
  String? get categoryImageUrl;
  @override
  @JsonKey(name: 'hamper_id')
  String? get hamperId;
  @override
  bool get sellable;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
