// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basket_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BasketProduct _$BasketProductFromJson(Map<String, dynamic> json) {
  return _BasketProduct.fromJson(json);
}

/// @nodoc
mixin _$BasketProduct {
  @JsonKey(name: 'basket_id')
  String get basketId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'substitute_brand')
  bool get substituteBrand => throw _privateConstructorUsedError;
  @JsonKey(name: 'substitute_variant')
  bool get substituteVariant => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  @ProductClassConverter()
  @JsonKey(name: 'class')
  ProductClass get productClass => throw _privateConstructorUsedError;
  bool get sellable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BasketProductCopyWith<BasketProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasketProductCopyWith<$Res> {
  factory $BasketProductCopyWith(
          BasketProduct value, $Res Function(BasketProduct) then) =
      _$BasketProductCopyWithImpl<$Res, BasketProduct>;
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
class _$BasketProductCopyWithImpl<$Res, $Val extends BasketProduct>
    implements $BasketProductCopyWith<$Res> {
  _$BasketProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      basketId: null == basketId
          ? _value.basketId
          : basketId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      substituteBrand: null == substituteBrand
          ? _value.substituteBrand
          : substituteBrand // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteVariant: null == substituteVariant
          ? _value.substituteVariant
          : substituteVariant // ignore: cast_nullable_to_non_nullable
              as bool,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      productClass: null == productClass
          ? _value.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass,
      sellable: null == sellable
          ? _value.sellable
          : sellable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BasketProductImplCopyWith<$Res>
    implements $BasketProductCopyWith<$Res> {
  factory _$$BasketProductImplCopyWith(
          _$BasketProductImpl value, $Res Function(_$BasketProductImpl) then) =
      __$$BasketProductImplCopyWithImpl<$Res>;
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
class __$$BasketProductImplCopyWithImpl<$Res>
    extends _$BasketProductCopyWithImpl<$Res, _$BasketProductImpl>
    implements _$$BasketProductImplCopyWith<$Res> {
  __$$BasketProductImplCopyWithImpl(
      _$BasketProductImpl _value, $Res Function(_$BasketProductImpl) _then)
      : super(_value, _then);

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
    return _then(_$BasketProductImpl(
      basketId: null == basketId
          ? _value.basketId
          : basketId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      substituteBrand: null == substituteBrand
          ? _value.substituteBrand
          : substituteBrand // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteVariant: null == substituteVariant
          ? _value.substituteVariant
          : substituteVariant // ignore: cast_nullable_to_non_nullable
              as bool,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      productClass: null == productClass
          ? _value.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass,
      sellable: null == sellable
          ? _value.sellable
          : sellable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BasketProductImpl implements _BasketProduct {
  const _$BasketProductImpl(
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

  factory _$BasketProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$BasketProductImplFromJson(json);

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

  @override
  String toString() {
    return 'BasketProduct(basketId: $basketId, productId: $productId, imageUrl: $imageUrl, category: $category, name: $name, quantity: $quantity, price: $price, substituteBrand: $substituteBrand, substituteVariant: $substituteVariant, size: $size, productClass: $productClass, sellable: $sellable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasketProductImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BasketProductImplCopyWith<_$BasketProductImpl> get copyWith =>
      __$$BasketProductImplCopyWithImpl<_$BasketProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BasketProductImplToJson(
      this,
    );
  }
}

abstract class _BasketProduct implements BasketProduct {
  const factory _BasketProduct(
      {@JsonKey(name: 'basket_id') required final String basketId,
      @JsonKey(name: 'product_id') required final int productId,
      @JsonKey(name: 'image_url') final String? imageUrl,
      required final String category,
      required final String name,
      required final int quantity,
      required final double price,
      @JsonKey(name: 'substitute_brand') final bool substituteBrand,
      @JsonKey(name: 'substitute_variant') final bool substituteVariant,
      final String? size,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      required final ProductClass productClass,
      required final bool sellable}) = _$BasketProductImpl;

  factory _BasketProduct.fromJson(Map<String, dynamic> json) =
      _$BasketProductImpl.fromJson;

  @override
  @JsonKey(name: 'basket_id')
  String get basketId;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  String get category;
  @override
  String get name;
  @override
  int get quantity;
  @override
  double get price;
  @override
  @JsonKey(name: 'substitute_brand')
  bool get substituteBrand;
  @override
  @JsonKey(name: 'substitute_variant')
  bool get substituteVariant;
  @override
  String? get size;
  @override
  @ProductClassConverter()
  @JsonKey(name: 'class')
  ProductClass get productClass;
  @override
  bool get sellable;
  @override
  @JsonKey(ignore: true)
  _$$BasketProductImplCopyWith<_$BasketProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
