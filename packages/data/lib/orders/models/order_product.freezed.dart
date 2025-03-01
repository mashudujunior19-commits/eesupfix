// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderProduct {
  @JsonKey(name: 'product_id')
  int get productId;
  @JsonKey(name: 'order_id', includeToJson: false)
  int? get orderId;
  @ProductClassConverter()
  @JsonKey(name: 'class')
  @JsonKey(includeToJson: false)
  @JsonKey(includeToJson: false)
  String? get category;
  @JsonKey(includeToJson: false, name: 'image_url')
  String? get imageUrl;
  @JsonKey(includeToJson: false)
  String? get size;
  @ProductClassConverter()
  @JsonKey(includeToJson: false, name: 'class', includeFromJson: true)
  ProductClass? get productClass;
  double get price;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get costPrice;
  String get name;
  int get quantity;
  @JsonKey(name: 'customer_accepted_qty')
  int get customerAcceptedQty;
  @JsonKey(name: 'eesupreneur_accepted_qty')
  int get eesupreneurAcceptedQty;
  @JsonKey(name: 'damaged_qty')
  int get damagedQty;
  @JsonKey(name: 'substitute_brand')
  bool get substituteBrand;
  @JsonKey(name: 'substitute_variant')
  bool get substituteVariant;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isExpanded;

  /// Create a copy of OrderProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderProductCopyWith<OrderProduct> get copyWith =>
      _$OrderProductCopyWithImpl<OrderProduct>(
          this as OrderProduct, _$identity);

  /// Serializes this OrderProduct to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderProduct &&
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
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
      costPrice,
      name,
      quantity,
      customerAcceptedQty,
      eesupreneurAcceptedQty,
      damagedQty,
      substituteBrand,
      substituteVariant,
      isExpanded);

  @override
  String toString() {
    return 'OrderProduct(productId: $productId, orderId: $orderId, category: $category, imageUrl: $imageUrl, size: $size, productClass: $productClass, price: $price, costPrice: $costPrice, name: $name, quantity: $quantity, customerAcceptedQty: $customerAcceptedQty, eesupreneurAcceptedQty: $eesupreneurAcceptedQty, damagedQty: $damagedQty, substituteBrand: $substituteBrand, substituteVariant: $substituteVariant, isExpanded: $isExpanded)';
  }
}

/// @nodoc
abstract mixin class $OrderProductCopyWith<$Res> {
  factory $OrderProductCopyWith(
          OrderProduct value, $Res Function(OrderProduct) _then) =
      _$OrderProductCopyWithImpl;
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
      @JsonKey(includeFromJson: false, includeToJson: false) double? costPrice,
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
class _$OrderProductCopyWithImpl<$Res> implements $OrderProductCopyWith<$Res> {
  _$OrderProductCopyWithImpl(this._self, this._then);

  final OrderProduct _self;
  final $Res Function(OrderProduct) _then;

  /// Create a copy of OrderProduct
  /// with the given fields replaced by the non-null parameter values.
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
    Object? costPrice = freezed,
    Object? name = null,
    Object? quantity = null,
    Object? customerAcceptedQty = null,
    Object? eesupreneurAcceptedQty = null,
    Object? damagedQty = null,
    Object? substituteBrand = null,
    Object? substituteVariant = null,
    Object? isExpanded = null,
  }) {
    return _then(_self.copyWith(
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: freezed == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      productClass: freezed == productClass
          ? _self.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _self.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      customerAcceptedQty: null == customerAcceptedQty
          ? _self.customerAcceptedQty
          : customerAcceptedQty // ignore: cast_nullable_to_non_nullable
              as int,
      eesupreneurAcceptedQty: null == eesupreneurAcceptedQty
          ? _self.eesupreneurAcceptedQty
          : eesupreneurAcceptedQty // ignore: cast_nullable_to_non_nullable
              as int,
      damagedQty: null == damagedQty
          ? _self.damagedQty
          : damagedQty // ignore: cast_nullable_to_non_nullable
              as int,
      substituteBrand: null == substituteBrand
          ? _self.substituteBrand
          : substituteBrand // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteVariant: null == substituteVariant
          ? _self.substituteVariant
          : substituteVariant // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpanded: null == isExpanded
          ? _self.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OrderProduct implements OrderProduct {
  _OrderProduct(
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
      @JsonKey(includeFromJson: false, includeToJson: false) this.costPrice,
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
  factory _OrderProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderProductFromJson(json);

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
  @JsonKey(includeFromJson: false, includeToJson: false)
  final double? costPrice;
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

  /// Create a copy of OrderProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderProductCopyWith<_OrderProduct> get copyWith =>
      __$OrderProductCopyWithImpl<_OrderProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrderProductToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderProduct &&
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
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
      costPrice,
      name,
      quantity,
      customerAcceptedQty,
      eesupreneurAcceptedQty,
      damagedQty,
      substituteBrand,
      substituteVariant,
      isExpanded);

  @override
  String toString() {
    return 'OrderProduct(productId: $productId, orderId: $orderId, category: $category, imageUrl: $imageUrl, size: $size, productClass: $productClass, price: $price, costPrice: $costPrice, name: $name, quantity: $quantity, customerAcceptedQty: $customerAcceptedQty, eesupreneurAcceptedQty: $eesupreneurAcceptedQty, damagedQty: $damagedQty, substituteBrand: $substituteBrand, substituteVariant: $substituteVariant, isExpanded: $isExpanded)';
  }
}

/// @nodoc
abstract mixin class _$OrderProductCopyWith<$Res>
    implements $OrderProductCopyWith<$Res> {
  factory _$OrderProductCopyWith(
          _OrderProduct value, $Res Function(_OrderProduct) _then) =
      __$OrderProductCopyWithImpl;
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
      @JsonKey(includeFromJson: false, includeToJson: false) double? costPrice,
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
class __$OrderProductCopyWithImpl<$Res>
    implements _$OrderProductCopyWith<$Res> {
  __$OrderProductCopyWithImpl(this._self, this._then);

  final _OrderProduct _self;
  final $Res Function(_OrderProduct) _then;

  /// Create a copy of OrderProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? productId = null,
    Object? orderId = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
    Object? size = freezed,
    Object? productClass = freezed,
    Object? price = null,
    Object? costPrice = freezed,
    Object? name = null,
    Object? quantity = null,
    Object? customerAcceptedQty = null,
    Object? eesupreneurAcceptedQty = null,
    Object? damagedQty = null,
    Object? substituteBrand = null,
    Object? substituteVariant = null,
    Object? isExpanded = null,
  }) {
    return _then(_OrderProduct(
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: freezed == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      productClass: freezed == productClass
          ? _self.productClass
          : productClass // ignore: cast_nullable_to_non_nullable
              as ProductClass?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _self.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      customerAcceptedQty: null == customerAcceptedQty
          ? _self.customerAcceptedQty
          : customerAcceptedQty // ignore: cast_nullable_to_non_nullable
              as int,
      eesupreneurAcceptedQty: null == eesupreneurAcceptedQty
          ? _self.eesupreneurAcceptedQty
          : eesupreneurAcceptedQty // ignore: cast_nullable_to_non_nullable
              as int,
      damagedQty: null == damagedQty
          ? _self.damagedQty
          : damagedQty // ignore: cast_nullable_to_non_nullable
              as int,
      substituteBrand: null == substituteBrand
          ? _self.substituteBrand
          : substituteBrand // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteVariant: null == substituteVariant
          ? _self.substituteVariant
          : substituteVariant // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpanded: null == isExpanded
          ? _self.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
