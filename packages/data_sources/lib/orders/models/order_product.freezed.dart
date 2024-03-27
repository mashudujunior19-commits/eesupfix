// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) {
  return _OrderProduct.fromJson(json);
}

/// @nodoc
mixin _$OrderProduct {
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id', includeToJson: false)
  int? get orderId => throw _privateConstructorUsedError;
  @ProductClassConverter()
  @JsonKey(name: 'class')
  @JsonKey(includeToJson: false)
  @JsonKey(includeToJson: false)
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String? get size => throw _privateConstructorUsedError;
  @ProductClassConverter()
  @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
  ProductClass? get productClass => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_accepted_qty')
  int get customerAcceptedQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupreneur_accepted_qty')
  int get eesupreneurAcceptedQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'damaged_qty')
  int get damagedQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'substitute_brand')
  bool get substituteBrand => throw _privateConstructorUsedError;
  @JsonKey(name: 'substitute_variant')
  bool get substituteVariant => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isExpanded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderProductCopyWith<OrderProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderProductCopyWith<$Res> {
  factory $OrderProductCopyWith(
          OrderProduct value, $Res Function(OrderProduct) then) =
      _$OrderProductCopyWithImpl<$Res, OrderProduct>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'order_id', includeToJson: false) int? orderId,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      @JsonKey(includeToJson: false)
      @JsonKey(includeToJson: false)
      String? category,
      @JsonKey(includeToJson: false, name: 'image_url') String? imageUrl,
      @JsonKey(includeToJson: false) String? size,
      @ProductClassConverter()
      @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
      ProductClass? productClass,
      double price,
      String name,
      int quantity,
      @JsonKey(name: 'customer_accepted_qty') int customerAcceptedQty,
      @JsonKey(name: 'eesupreneur_accepted_qty') int eesupreneurAcceptedQty,
      @JsonKey(name: 'damaged_qty') int damagedQty,
      @JsonKey(name: 'substitute_brand') bool substituteBrand,
      @JsonKey(name: 'substitute_variant') bool substituteVariant,
      @JsonKey(includeFromJson: false, includeToJson: false) bool isExpanded});
}

/// @nodoc
class _$OrderProductCopyWithImpl<$Res, $Val extends OrderProduct>
    implements $OrderProductCopyWith<$Res> {
  _$OrderProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? orderId = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
    Object? size = freezed,
    Object? productClass = freezed,
    Object? price = null,
    Object? name = null,
    Object? quantity = null,
    Object? customerAcceptedQty = null,
    Object? eesupreneurAcceptedQty = null,
    Object? damagedQty = null,
    Object? substituteBrand = null,
    Object? substituteVariant = null,
    Object? isExpanded = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      productClass: freezed == productClass
          ? _value.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      customerAcceptedQty: null == customerAcceptedQty
          ? _value.customerAcceptedQty
          : customerAcceptedQty // ignore: cast_nullable_to_non_nullable
              as int,
      eesupreneurAcceptedQty: null == eesupreneurAcceptedQty
          ? _value.eesupreneurAcceptedQty
          : eesupreneurAcceptedQty // ignore: cast_nullable_to_non_nullable
              as int,
      damagedQty: null == damagedQty
          ? _value.damagedQty
          : damagedQty // ignore: cast_nullable_to_non_nullable
              as int,
      substituteBrand: null == substituteBrand
          ? _value.substituteBrand
          : substituteBrand // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteVariant: null == substituteVariant
          ? _value.substituteVariant
          : substituteVariant // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpanded: null == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderProductImplCopyWith<$Res>
    implements $OrderProductCopyWith<$Res> {
  factory _$$OrderProductImplCopyWith(
          _$OrderProductImpl value, $Res Function(_$OrderProductImpl) then) =
      __$$OrderProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'order_id', includeToJson: false) int? orderId,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      @JsonKey(includeToJson: false)
      @JsonKey(includeToJson: false)
      String? category,
      @JsonKey(includeToJson: false, name: 'image_url') String? imageUrl,
      @JsonKey(includeToJson: false) String? size,
      @ProductClassConverter()
      @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
      ProductClass? productClass,
      double price,
      String name,
      int quantity,
      @JsonKey(name: 'customer_accepted_qty') int customerAcceptedQty,
      @JsonKey(name: 'eesupreneur_accepted_qty') int eesupreneurAcceptedQty,
      @JsonKey(name: 'damaged_qty') int damagedQty,
      @JsonKey(name: 'substitute_brand') bool substituteBrand,
      @JsonKey(name: 'substitute_variant') bool substituteVariant,
      @JsonKey(includeFromJson: false, includeToJson: false) bool isExpanded});
}

/// @nodoc
class __$$OrderProductImplCopyWithImpl<$Res>
    extends _$OrderProductCopyWithImpl<$Res, _$OrderProductImpl>
    implements _$$OrderProductImplCopyWith<$Res> {
  __$$OrderProductImplCopyWithImpl(
      _$OrderProductImpl _value, $Res Function(_$OrderProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? orderId = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
    Object? size = freezed,
    Object? productClass = freezed,
    Object? price = null,
    Object? name = null,
    Object? quantity = null,
    Object? customerAcceptedQty = null,
    Object? eesupreneurAcceptedQty = null,
    Object? damagedQty = null,
    Object? substituteBrand = null,
    Object? substituteVariant = null,
    Object? isExpanded = null,
  }) {
    return _then(_$OrderProductImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      productClass: freezed == productClass
          ? _value.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      customerAcceptedQty: null == customerAcceptedQty
          ? _value.customerAcceptedQty
          : customerAcceptedQty // ignore: cast_nullable_to_non_nullable
              as int,
      eesupreneurAcceptedQty: null == eesupreneurAcceptedQty
          ? _value.eesupreneurAcceptedQty
          : eesupreneurAcceptedQty // ignore: cast_nullable_to_non_nullable
              as int,
      damagedQty: null == damagedQty
          ? _value.damagedQty
          : damagedQty // ignore: cast_nullable_to_non_nullable
              as int,
      substituteBrand: null == substituteBrand
          ? _value.substituteBrand
          : substituteBrand // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteVariant: null == substituteVariant
          ? _value.substituteVariant
          : substituteVariant // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpanded: null == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderProductImpl implements _OrderProduct {
  _$OrderProductImpl(
      {@JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'order_id', includeToJson: false) this.orderId,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      @JsonKey(includeToJson: false)
      @JsonKey(includeToJson: false)
      this.category,
      @JsonKey(includeToJson: false, name: 'image_url') this.imageUrl,
      @JsonKey(includeToJson: false) this.size,
      @ProductClassConverter()
      @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
      this.productClass,
      required this.price,
      required this.name,
      required this.quantity,
      @JsonKey(name: 'customer_accepted_qty') this.customerAcceptedQty = 0,
      @JsonKey(name: 'eesupreneur_accepted_qty')
      this.eesupreneurAcceptedQty = 0,
      @JsonKey(name: 'damaged_qty') this.damagedQty = 0,
      @JsonKey(name: 'substitute_brand') this.substituteBrand = false,
      @JsonKey(name: 'substitute_variant') this.substituteVariant = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.isExpanded = false});

  factory _$OrderProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderProductImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'order_id', includeToJson: false)
  final int? orderId;
  @override
  @ProductClassConverter()
  @JsonKey(name: 'class')
  @JsonKey(includeToJson: false)
  @JsonKey(includeToJson: false)
  final String? category;
  @override
  @JsonKey(includeToJson: false, name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(includeToJson: false)
  final String? size;
  @override
  @ProductClassConverter()
  @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
  final ProductClass? productClass;
  @override
  final double price;
  @override
  final String name;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'customer_accepted_qty')
  final int customerAcceptedQty;
  @override
  @JsonKey(name: 'eesupreneur_accepted_qty')
  final int eesupreneurAcceptedQty;
  @override
  @JsonKey(name: 'damaged_qty')
  final int damagedQty;
  @override
  @JsonKey(name: 'substitute_brand')
  final bool substituteBrand;
  @override
  @JsonKey(name: 'substitute_variant')
  final bool substituteVariant;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isExpanded;

  @override
  String toString() {
    return 'OrderProduct(productId: $productId, orderId: $orderId, category: $category, imageUrl: $imageUrl, size: $size, productClass: $productClass, price: $price, name: $name, quantity: $quantity, customerAcceptedQty: $customerAcceptedQty, eesupreneurAcceptedQty: $eesupreneurAcceptedQty, damagedQty: $damagedQty, substituteBrand: $substituteBrand, substituteVariant: $substituteVariant, isExpanded: $isExpanded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderProductImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.productClass, productClass) ||
                other.productClass == productClass) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.customerAcceptedQty, customerAcceptedQty) ||
                other.customerAcceptedQty == customerAcceptedQty) &&
            (identical(other.eesupreneurAcceptedQty, eesupreneurAcceptedQty) ||
                other.eesupreneurAcceptedQty == eesupreneurAcceptedQty) &&
            (identical(other.damagedQty, damagedQty) ||
                other.damagedQty == damagedQty) &&
            (identical(other.substituteBrand, substituteBrand) ||
                other.substituteBrand == substituteBrand) &&
            (identical(other.substituteVariant, substituteVariant) ||
                other.substituteVariant == substituteVariant) &&
            (identical(other.isExpanded, isExpanded) ||
                other.isExpanded == isExpanded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      orderId,
      category,
      imageUrl,
      size,
      productClass,
      price,
      name,
      quantity,
      customerAcceptedQty,
      eesupreneurAcceptedQty,
      damagedQty,
      substituteBrand,
      substituteVariant,
      isExpanded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderProductImplCopyWith<_$OrderProductImpl> get copyWith =>
      __$$OrderProductImplCopyWithImpl<_$OrderProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderProductImplToJson(
      this,
    );
  }
}

abstract class _OrderProduct implements OrderProduct {
  factory _OrderProduct(
      {@JsonKey(name: 'product_id') required final int productId,
      @JsonKey(name: 'order_id', includeToJson: false) final int? orderId,
      @ProductClassConverter()
      @JsonKey(name: 'class')
      @JsonKey(includeToJson: false)
      @JsonKey(includeToJson: false)
      final String? category,
      @JsonKey(includeToJson: false, name: 'image_url') final String? imageUrl,
      @JsonKey(includeToJson: false) final String? size,
      @ProductClassConverter()
      @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
      final ProductClass? productClass,
      required final double price,
      required final String name,
      required final int quantity,
      @JsonKey(name: 'customer_accepted_qty') final int customerAcceptedQty,
      @JsonKey(name: 'eesupreneur_accepted_qty')
      final int eesupreneurAcceptedQty,
      @JsonKey(name: 'damaged_qty') final int damagedQty,
      @JsonKey(name: 'substitute_brand') final bool substituteBrand,
      @JsonKey(name: 'substitute_variant') final bool substituteVariant,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool isExpanded}) = _$OrderProductImpl;

  factory _OrderProduct.fromJson(Map<String, dynamic> json) =
      _$OrderProductImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'order_id', includeToJson: false)
  int? get orderId;
  @override
  @ProductClassConverter()
  @JsonKey(name: 'class')
  @JsonKey(includeToJson: false)
  @JsonKey(includeToJson: false)
  String? get category;
  @override
  @JsonKey(includeToJson: false, name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(includeToJson: false)
  String? get size;
  @override
  @ProductClassConverter()
  @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
  ProductClass? get productClass;
  @override
  double get price;
  @override
  String get name;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'customer_accepted_qty')
  int get customerAcceptedQty;
  @override
  @JsonKey(name: 'eesupreneur_accepted_qty')
  int get eesupreneurAcceptedQty;
  @override
  @JsonKey(name: 'damaged_qty')
  int get damagedQty;
  @override
  @JsonKey(name: 'substitute_brand')
  bool get substituteBrand;
  @override
  @JsonKey(name: 'substitute_variant')
  bool get substituteVariant;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isExpanded;
  @override
  @JsonKey(ignore: true)
  _$$OrderProductImplCopyWith<_$OrderProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
