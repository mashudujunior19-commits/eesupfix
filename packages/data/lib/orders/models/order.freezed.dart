// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Order {
  int? get id;
  @JsonKey(name: 'customer_id')
  String get customerId;
  @JsonKey(name: 'eesupreneur_id')
  String? get eesupreneurId;
  @JsonKey(name: 'eesupool_order_id')
  int? get eesupoolOrderId;
  @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
  int? get walletId;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @JsonKey(name: 'placed_at', includeToJson: false)
  DateTime? get placedAt;
  @JsonKey(name: 'packaged_at')
  DateTime? get packagedAt;
  @JsonKey(name: 'ready_at')
  DateTime? get readyAt;
  @JsonKey(name: 'collected_at')
  DateTime? get collectedAt;
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt;
  double get value;
  @PaymentMethodConverter()
  @JsonKey(name: 'payment_method')
  PaymentMethod get paymentMethod;
  @JsonKey(name: 'secret_pin')
  int get secretPin;
  @JsonKey(name: 'delivery_address_id')
  int? get deliveryAddressId;
  @JsonKey(name: 'delivery_fee')
  double? get deliveryFee;
  @JsonKey(name: 'card_fee')
  double? get cardFee;
  @JsonKey(name: 'pay_fees_with_retail_wallet')
  dynamic get payFeesWithRetailWallet;
  @JsonKey(name: 'full_name')
  String? get fullName;
  @JsonKey(name: 'corp_name')
  String? get corpName;
  @MemberOrderAssignmentConverter()
  List<MemberOrderAssignment> get assignments;
  @OrderStatusConverter()
  @JsonKey(includeToJson: false)
  OrderStatus
      get status; // @EESUpreneurConverter() @JsonKey(includeToJson: false) EESUpreneur? eesupreneur,
// @EESUpoolConverter() @JsonKey(includeToJson: false) EESUpool? eesupool,
// @ProfileConverter() @JsonKey(includeToJson: false) Profile? customer,
  @OrderProductConverter()
  List<OrderProduct> get products;
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderCopyWith<Order> get copyWith =>
      _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Order &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.eesupreneurId, eesupreneurId) ||
                other.eesupreneurId == eesupreneurId) &&
            (identical(other.eesupoolOrderId, eesupoolOrderId) ||
                other.eesupoolOrderId == eesupoolOrderId) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.placedAt, placedAt) ||
                other.placedAt == placedAt) &&
            (identical(other.packagedAt, packagedAt) ||
                other.packagedAt == packagedAt) &&
            (identical(other.readyAt, readyAt) || other.readyAt == readyAt) &&
            (identical(other.collectedAt, collectedAt) ||
                other.collectedAt == collectedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.secretPin, secretPin) ||
                other.secretPin == secretPin) &&
            (identical(other.deliveryAddressId, deliveryAddressId) ||
                other.deliveryAddressId == deliveryAddressId) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.cardFee, cardFee) || other.cardFee == cardFee) &&
            const DeepCollectionEquality().equals(
                other.payFeesWithRetailWallet, payFeesWithRetailWallet) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.corpName, corpName) ||
                other.corpName == corpName) &&
            const DeepCollectionEquality()
                .equals(other.assignments, assignments) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.products, products) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        customerId,
        eesupreneurId,
        eesupoolOrderId,
        walletId,
        createdAt,
        placedAt,
        packagedAt,
        readyAt,
        collectedAt,
        cancelledAt,
        value,
        paymentMethod,
        secretPin,
        deliveryAddressId,
        deliveryFee,
        cardFee,
        const DeepCollectionEquality().hash(payFeesWithRetailWallet),
        fullName,
        corpName,
        const DeepCollectionEquality().hash(assignments),
        status,
        const DeepCollectionEquality().hash(products),
        address
      ]);

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, eesupreneurId: $eesupreneurId, eesupoolOrderId: $eesupoolOrderId, walletId: $walletId, createdAt: $createdAt, placedAt: $placedAt, packagedAt: $packagedAt, readyAt: $readyAt, collectedAt: $collectedAt, cancelledAt: $cancelledAt, value: $value, paymentMethod: $paymentMethod, secretPin: $secretPin, deliveryAddressId: $deliveryAddressId, deliveryFee: $deliveryFee, cardFee: $cardFee, payFeesWithRetailWallet: $payFeesWithRetailWallet, fullName: $fullName, corpName: $corpName, assignments: $assignments, status: $status, products: $products, address: $address)';
  }
}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) =
      _$OrderCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'customer_id') String customerId,
      @JsonKey(name: 'eesupreneur_id') String? eesupreneurId,
      @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,
      @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
      int? walletId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'placed_at', includeToJson: false) DateTime? placedAt,
      @JsonKey(name: 'packaged_at') DateTime? packagedAt,
      @JsonKey(name: 'ready_at') DateTime? readyAt,
      @JsonKey(name: 'collected_at') DateTime? collectedAt,
      @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
      double value,
      @PaymentMethodConverter()
      @JsonKey(name: 'payment_method')
      PaymentMethod paymentMethod,
      @JsonKey(name: 'secret_pin') int secretPin,
      @JsonKey(name: 'delivery_address_id') int? deliveryAddressId,
      @JsonKey(name: 'delivery_fee') double? deliveryFee,
      @JsonKey(name: 'card_fee') double? cardFee,
      @JsonKey(name: 'pay_fees_with_retail_wallet')
      dynamic payFeesWithRetailWallet,
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'corp_name') String? corpName,
      @MemberOrderAssignmentConverter() List<MemberOrderAssignment> assignments,
      @OrderStatusConverter() @JsonKey(includeToJson: false) OrderStatus status,
      @OrderProductConverter() List<OrderProduct> products,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res> implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = null,
    Object? eesupreneurId = freezed,
    Object? eesupoolOrderId = freezed,
    Object? walletId = freezed,
    Object? createdAt = freezed,
    Object? placedAt = freezed,
    Object? packagedAt = freezed,
    Object? readyAt = freezed,
    Object? collectedAt = freezed,
    Object? cancelledAt = freezed,
    Object? value = null,
    Object? paymentMethod = null,
    Object? secretPin = null,
    Object? deliveryAddressId = freezed,
    Object? deliveryFee = freezed,
    Object? cardFee = freezed,
    Object? payFeesWithRetailWallet = freezed,
    Object? fullName = freezed,
    Object? corpName = freezed,
    Object? assignments = null,
    Object? status = null,
    Object? products = null,
    Object? address = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      eesupreneurId: freezed == eesupreneurId
          ? _self.eesupreneurId
          : eesupreneurId // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolOrderId: freezed == eesupoolOrderId
          ? _self.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int?,
      walletId: freezed == walletId
          ? _self.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placedAt: freezed == placedAt
          ? _self.placedAt
          : placedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      packagedAt: freezed == packagedAt
          ? _self.packagedAt
          : packagedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readyAt: freezed == readyAt
          ? _self.readyAt
          : readyAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      collectedAt: freezed == collectedAt
          ? _self.collectedAt
          : collectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _self.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      secretPin: null == secretPin
          ? _self.secretPin
          : secretPin // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryAddressId: freezed == deliveryAddressId
          ? _self.deliveryAddressId
          : deliveryAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveryFee: freezed == deliveryFee
          ? _self.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double?,
      cardFee: freezed == cardFee
          ? _self.cardFee
          : cardFee // ignore: cast_nullable_to_non_nullable
              as double?,
      payFeesWithRetailWallet: freezed == payFeesWithRetailWallet
          ? _self.payFeesWithRetailWallet
          : payFeesWithRetailWallet // ignore: cast_nullable_to_non_nullable
              as dynamic,
      fullName: freezed == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _self.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      assignments: null == assignments
          ? _self.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<MemberOrderAssignment>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      products: null == products
          ? _self.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderProduct>,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.address!, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Order implements Order {
  const _Order(
      {this.id,
      @JsonKey(name: 'customer_id') required this.customerId,
      @JsonKey(name: 'eesupreneur_id') this.eesupreneurId,
      @JsonKey(name: 'eesupool_order_id') this.eesupoolOrderId,
      @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
      this.walletId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'placed_at', includeToJson: false) this.placedAt,
      @JsonKey(name: 'packaged_at') this.packagedAt,
      @JsonKey(name: 'ready_at') this.readyAt,
      @JsonKey(name: 'collected_at') this.collectedAt,
      @JsonKey(name: 'cancelled_at') this.cancelledAt,
      required this.value,
      @PaymentMethodConverter()
      @JsonKey(name: 'payment_method')
      required this.paymentMethod,
      @JsonKey(name: 'secret_pin') required this.secretPin,
      @JsonKey(name: 'delivery_address_id') this.deliveryAddressId,
      @JsonKey(name: 'delivery_fee') this.deliveryFee,
      @JsonKey(name: 'card_fee') this.cardFee,
      @JsonKey(name: 'pay_fees_with_retail_wallet')
      this.payFeesWithRetailWallet = false,
      @JsonKey(name: 'full_name') this.fullName,
      @JsonKey(name: 'corp_name') this.corpName,
      @MemberOrderAssignmentConverter()
      final List<MemberOrderAssignment> assignments = const [],
      @OrderStatusConverter()
      @JsonKey(includeToJson: false)
      required this.status,
      @OrderProductConverter() final List<OrderProduct> products = const [],
      @AddressConverter() @JsonKey(includeToJson: false) this.address})
      : _assignments = assignments,
        _products = products;
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'customer_id')
  final String customerId;
  @override
  @JsonKey(name: 'eesupreneur_id')
  final String? eesupreneurId;
  @override
  @JsonKey(name: 'eesupool_order_id')
  final int? eesupoolOrderId;
  @override
  @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
  final int? walletId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'placed_at', includeToJson: false)
  final DateTime? placedAt;
  @override
  @JsonKey(name: 'packaged_at')
  final DateTime? packagedAt;
  @override
  @JsonKey(name: 'ready_at')
  final DateTime? readyAt;
  @override
  @JsonKey(name: 'collected_at')
  final DateTime? collectedAt;
  @override
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;
  @override
  final double value;
  @override
  @PaymentMethodConverter()
  @JsonKey(name: 'payment_method')
  final PaymentMethod paymentMethod;
  @override
  @JsonKey(name: 'secret_pin')
  final int secretPin;
  @override
  @JsonKey(name: 'delivery_address_id')
  final int? deliveryAddressId;
  @override
  @JsonKey(name: 'delivery_fee')
  final double? deliveryFee;
  @override
  @JsonKey(name: 'card_fee')
  final double? cardFee;
  @override
  @JsonKey(name: 'pay_fees_with_retail_wallet')
  final dynamic payFeesWithRetailWallet;
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  @JsonKey(name: 'corp_name')
  final String? corpName;
  final List<MemberOrderAssignment> _assignments;
  @override
  @JsonKey()
  @MemberOrderAssignmentConverter()
  List<MemberOrderAssignment> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  @override
  @OrderStatusConverter()
  @JsonKey(includeToJson: false)
  final OrderStatus status;
// @EESUpreneurConverter() @JsonKey(includeToJson: false) EESUpreneur? eesupreneur,
// @EESUpoolConverter() @JsonKey(includeToJson: false) EESUpool? eesupool,
// @ProfileConverter() @JsonKey(includeToJson: false) Profile? customer,
  final List<OrderProduct> _products;
// @EESUpreneurConverter() @JsonKey(includeToJson: false) EESUpreneur? eesupreneur,
// @EESUpoolConverter() @JsonKey(includeToJson: false) EESUpool? eesupool,
// @ProfileConverter() @JsonKey(includeToJson: false) Profile? customer,
  @override
  @JsonKey()
  @OrderProductConverter()
  List<OrderProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  @AddressConverter()
  @JsonKey(includeToJson: false)
  final Address? address;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderCopyWith<_Order> get copyWith =>
      __$OrderCopyWithImpl<_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Order &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.eesupreneurId, eesupreneurId) ||
                other.eesupreneurId == eesupreneurId) &&
            (identical(other.eesupoolOrderId, eesupoolOrderId) ||
                other.eesupoolOrderId == eesupoolOrderId) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.placedAt, placedAt) ||
                other.placedAt == placedAt) &&
            (identical(other.packagedAt, packagedAt) ||
                other.packagedAt == packagedAt) &&
            (identical(other.readyAt, readyAt) || other.readyAt == readyAt) &&
            (identical(other.collectedAt, collectedAt) ||
                other.collectedAt == collectedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.secretPin, secretPin) ||
                other.secretPin == secretPin) &&
            (identical(other.deliveryAddressId, deliveryAddressId) ||
                other.deliveryAddressId == deliveryAddressId) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.cardFee, cardFee) || other.cardFee == cardFee) &&
            const DeepCollectionEquality().equals(
                other.payFeesWithRetailWallet, payFeesWithRetailWallet) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.corpName, corpName) ||
                other.corpName == corpName) &&
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        customerId,
        eesupreneurId,
        eesupoolOrderId,
        walletId,
        createdAt,
        placedAt,
        packagedAt,
        readyAt,
        collectedAt,
        cancelledAt,
        value,
        paymentMethod,
        secretPin,
        deliveryAddressId,
        deliveryFee,
        cardFee,
        const DeepCollectionEquality().hash(payFeesWithRetailWallet),
        fullName,
        corpName,
        const DeepCollectionEquality().hash(_assignments),
        status,
        const DeepCollectionEquality().hash(_products),
        address
      ]);

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, eesupreneurId: $eesupreneurId, eesupoolOrderId: $eesupoolOrderId, walletId: $walletId, createdAt: $createdAt, placedAt: $placedAt, packagedAt: $packagedAt, readyAt: $readyAt, collectedAt: $collectedAt, cancelledAt: $cancelledAt, value: $value, paymentMethod: $paymentMethod, secretPin: $secretPin, deliveryAddressId: $deliveryAddressId, deliveryFee: $deliveryFee, cardFee: $cardFee, payFeesWithRetailWallet: $payFeesWithRetailWallet, fullName: $fullName, corpName: $corpName, assignments: $assignments, status: $status, products: $products, address: $address)';
  }
}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) =
      __$OrderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'customer_id') String customerId,
      @JsonKey(name: 'eesupreneur_id') String? eesupreneurId,
      @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,
      @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
      int? walletId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'placed_at', includeToJson: false) DateTime? placedAt,
      @JsonKey(name: 'packaged_at') DateTime? packagedAt,
      @JsonKey(name: 'ready_at') DateTime? readyAt,
      @JsonKey(name: 'collected_at') DateTime? collectedAt,
      @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
      double value,
      @PaymentMethodConverter()
      @JsonKey(name: 'payment_method')
      PaymentMethod paymentMethod,
      @JsonKey(name: 'secret_pin') int secretPin,
      @JsonKey(name: 'delivery_address_id') int? deliveryAddressId,
      @JsonKey(name: 'delivery_fee') double? deliveryFee,
      @JsonKey(name: 'card_fee') double? cardFee,
      @JsonKey(name: 'pay_fees_with_retail_wallet')
      dynamic payFeesWithRetailWallet,
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'corp_name') String? corpName,
      @MemberOrderAssignmentConverter() List<MemberOrderAssignment> assignments,
      @OrderStatusConverter() @JsonKey(includeToJson: false) OrderStatus status,
      @OrderProductConverter() List<OrderProduct> products,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$OrderCopyWithImpl<$Res> implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? customerId = null,
    Object? eesupreneurId = freezed,
    Object? eesupoolOrderId = freezed,
    Object? walletId = freezed,
    Object? createdAt = freezed,
    Object? placedAt = freezed,
    Object? packagedAt = freezed,
    Object? readyAt = freezed,
    Object? collectedAt = freezed,
    Object? cancelledAt = freezed,
    Object? value = null,
    Object? paymentMethod = null,
    Object? secretPin = null,
    Object? deliveryAddressId = freezed,
    Object? deliveryFee = freezed,
    Object? cardFee = freezed,
    Object? payFeesWithRetailWallet = freezed,
    Object? fullName = freezed,
    Object? corpName = freezed,
    Object? assignments = null,
    Object? status = null,
    Object? products = null,
    Object? address = freezed,
  }) {
    return _then(_Order(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: null == customerId
          ? _self.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      eesupreneurId: freezed == eesupreneurId
          ? _self.eesupreneurId
          : eesupreneurId // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolOrderId: freezed == eesupoolOrderId
          ? _self.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int?,
      walletId: freezed == walletId
          ? _self.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placedAt: freezed == placedAt
          ? _self.placedAt
          : placedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      packagedAt: freezed == packagedAt
          ? _self.packagedAt
          : packagedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readyAt: freezed == readyAt
          ? _self.readyAt
          : readyAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      collectedAt: freezed == collectedAt
          ? _self.collectedAt
          : collectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _self.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      secretPin: null == secretPin
          ? _self.secretPin
          : secretPin // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryAddressId: freezed == deliveryAddressId
          ? _self.deliveryAddressId
          : deliveryAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveryFee: freezed == deliveryFee
          ? _self.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double?,
      cardFee: freezed == cardFee
          ? _self.cardFee
          : cardFee // ignore: cast_nullable_to_non_nullable
              as double?,
      payFeesWithRetailWallet: freezed == payFeesWithRetailWallet
          ? _self.payFeesWithRetailWallet!
          : payFeesWithRetailWallet,
      fullName: freezed == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _self.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      assignments: null == assignments
          ? _self._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<MemberOrderAssignment>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      products: null == products
          ? _self._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderProduct>,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.address!, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

// dart format on
