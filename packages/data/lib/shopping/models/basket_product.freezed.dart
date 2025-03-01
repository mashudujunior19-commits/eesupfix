// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basket_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BasketProduct {
  @JsonKey(name: 'basket_id')
  String get basketId;
  @JsonKey(name: 'product_id')
  int get productId;
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  String get category;
  String get name;
  int get quantity;
  double get price;
  @JsonKey(name: 'substitute_brand')
  bool get substituteBrand;
  @JsonKey(name: 'substitute_variant')
  bool get substituteVariant;
  String? get size;
  @ProductClassConverter()
  @JsonKey(name: 'class')
  ProductClass get productClass;
  bool get sellable;

  /// Create a copy of BasketProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BasketProductCopyWith<BasketProduct> get copyWith =>
      _$BasketProductCopyWithImpl<BasketProduct>(
          this as BasketProduct, _$identity);

  /// Serializes this BasketProduct to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BasketProduct &&
            (identical(other.basketId, basketId) ||
                other.basketId == basketId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.substituteBrand, substituteBrand) ||
                other.substituteBrand == substituteBrand) &&
            (identical(other.substituteVariant, substituteVariant) ||
                other.substituteVariant == substituteVariant) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.productClass, productClass) ||
                other.productClass == productClass) &&
            (identical(other.sellable, sellable) ||
                other.sellable == sellable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      basketId,
      productId,
      imageUrl,
      category,
      name,
      quantity,
      price,
      substituteBrand,
      substituteVariant,
      size,
      productClass,
      sellable);

  @override
  String toString() {
    return 'BasketProduct(basketId: $basketId, productId: $productId, imageUrl: $imageUrl, category: $category, name: $name, quantity: $quantity, price: $price, substituteBrand: $substituteBrand, substituteVariant: $substituteVariant, size: $size, productClass: $productClass, sellable: $sellable)';
  }
}

/// @nodoc
abstract mixin class $BasketProductCopyWith<$Res> {
  factory $BasketProductCopyWith(
          BasketProduct value, $Res Function(BasketProduct) _then) =
      _$BasketProductCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'basket_id') String basketId,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'image_url') String? imageUrl,
      String category,
      String name,
      int quantity,
      double price,
      @JsonKey(name: 'substitute_brand') bool substituteBrand,
      @JsonKey(name: 'substitute_variant') bool substituteVariant,
      String? size,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      ProductClass productClass,
      bool sellable});
}

/// @nodoc
class _$BasketProductCopyWithImpl<$Res>
    implements $BasketProductCopyWith<$Res> {
  _$BasketProductCopyWithImpl(this._self, this._then);

  final BasketProduct _self;
  final $Res Function(BasketProduct) _then;

  /// Create a copy of BasketProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basketId = null,
    Object? productId = null,
    Object? imageUrl = freezed,
    Object? category = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = null,
    Object? substituteBrand = null,
    Object? substituteVariant = null,
    Object? size = freezed,
    Object? productClass = null,
    Object? sellable = null,
  }) {
    return _then(_self.copyWith(
      basketId: null == basketId
          ? _self.basketId
          : basketId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      substituteBrand: null == substituteBrand
          ? _self.substituteBrand
          : substituteBrand // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteVariant: null == substituteVariant
          ? _self.substituteVariant
          : substituteVariant // ignore: cast_nullable_to_non_nullable
              as bool,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      productClass: null == productClass
          ? _self.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass,
      sellable: null == sellable
          ? _self.sellable
          : sellable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _BasketProduct implements BasketProduct {
  const _BasketProduct(
      {@JsonKey(name: 'basket_id') required this.basketId,
      @JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'image_url') this.imageUrl,
      required this.category,
      required this.name,
      required this.quantity,
      required this.price,
      @JsonKey(name: 'substitute_brand') this.substituteBrand = false,
      @JsonKey(name: 'substitute_variant') this.substituteVariant = false,
      this.size,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      required this.productClass,
      required this.sellable});
  factory _BasketProduct.fromJson(Map<String, dynamic> json) =>
      _$BasketProductFromJson(json);

  @override
  @JsonKey(name: 'basket_id')
  final String basketId;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  final String category;
  @override
  final String name;
  @override
  final int quantity;
  @override
  final double price;
  @override
  @JsonKey(name: 'substitute_brand')
  final bool substituteBrand;
  @override
  @JsonKey(name: 'substitute_variant')
  final bool substituteVariant;
  @override
  final String? size;
  @override
  @ProductClassConverter()
  @JsonKey(name: 'class')
  final ProductClass productClass;
  @override
  final bool sellable;

  /// Create a copy of BasketProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BasketProductCopyWith<_BasketProduct> get copyWith =>
      __$BasketProductCopyWithImpl<_BasketProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BasketProductToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BasketProduct &&
            (identical(other.basketId, basketId) ||
                other.basketId == basketId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.substituteBrand, substituteBrand) ||
                other.substituteBrand == substituteBrand) &&
            (identical(other.substituteVariant, substituteVariant) ||
                other.substituteVariant == substituteVariant) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.productClass, productClass) ||
                other.productClass == productClass) &&
            (identical(other.sellable, sellable) ||
                other.sellable == sellable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      basketId,
      productId,
      imageUrl,
      category,
      name,
      quantity,
      price,
      substituteBrand,
      substituteVariant,
      size,
      productClass,
      sellable);

  @override
  String toString() {
    return 'BasketProduct(basketId: $basketId, productId: $productId, imageUrl: $imageUrl, category: $category, name: $name, quantity: $quantity, price: $price, substituteBrand: $substituteBrand, substituteVariant: $substituteVariant, size: $size, productClass: $productClass, sellable: $sellable)';
  }
}

/// @nodoc
abstract mixin class _$BasketProductCopyWith<$Res>
    implements $BasketProductCopyWith<$Res> {
  factory _$BasketProductCopyWith(
          _BasketProduct value, $Res Function(_BasketProduct) _then) =
      __$BasketProductCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'basket_id') String basketId,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'image_url') String? imageUrl,
      String category,
      String name,
      int quantity,
      double price,
      @JsonKey(name: 'substitute_brand') bool substituteBrand,
      @JsonKey(name: 'substitute_variant') bool substituteVariant,
      String? size,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      ProductClass productClass,
      bool sellable});
}

/// @nodoc
class __$BasketProductCopyWithImpl<$Res>
    implements _$BasketProductCopyWith<$Res> {
  __$BasketProductCopyWithImpl(this._self, this._then);

  final _BasketProduct _self;
  final $Res Function(_BasketProduct) _then;

  /// Create a copy of BasketProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? basketId = null,
    Object? productId = null,
    Object? imageUrl = freezed,
    Object? category = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = null,
    Object? substituteBrand = null,
    Object? substituteVariant = null,
    Object? size = freezed,
    Object? productClass = null,
    Object? sellable = null,
  }) {
    return _then(_BasketProduct(
      basketId: null == basketId
          ? _self.basketId
          : basketId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      substituteBrand: null == substituteBrand
          ? _self.substituteBrand
          : substituteBrand // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteVariant: null == substituteVariant
          ? _self.substituteVariant
          : substituteVariant // ignore: cast_nullable_to_non_nullable
              as bool,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      productClass: null == productClass
          ? _self.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass,
      sellable: null == sellable
          ? _self.sellable
          : sellable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
