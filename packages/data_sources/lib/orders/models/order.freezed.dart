// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  String get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupreneur_id')
  String? get eesupreneurId => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_order_id')
  int? get eesupoolOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
  int? get walletId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'placed_at', includeToJson: false)
  DateTime? get placedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'packaged_at')
  DateTime? get packagedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ready_at')
  DateTime? get readyAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'collected_at')
  DateTime? get collectedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  @PaymentMethodConverter()
  @JsonKey(name: 'payment_method')
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'secret_pin')
  int get secretPin => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_address_id')
  int? get deliveryAddressId => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_fee')
  double? get deliveryFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'card_fee')
  double? get cardFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'corp_name')
  String? get corpName => throw _privateConstructorUsedError;
  @MemberOrderAssignmentConverter()
  List<MemberOrderAssignment> get assignments =>
      throw _privateConstructorUsedError;
  @OrderStatusConverter()
  @JsonKey(includeToJson: false)
  OrderStatus get status =>
      throw _privateConstructorUsedError; // @EESUpreneurConverter() @JsonKey(includeToJson: false) EESUpreneur? eesupreneur,
// @EESUpoolConverter() @JsonKey(includeToJson: false) EESUpool? eesupool,
// @ProfileConverter() @JsonKey(includeToJson: false) Profile? customer,
  @OrderProductConverter()
  List<OrderProduct> get products => throw _privateConstructorUsedError;
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
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
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'corp_name') String? corpName,
      @MemberOrderAssignmentConverter() List<MemberOrderAssignment> assignments,
      @OrderStatusConverter() @JsonKey(includeToJson: false) OrderStatus status,
      @OrderProductConverter() List<OrderProduct> products,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    Object? fullName = freezed,
    Object? corpName = freezed,
    Object? assignments = null,
    Object? status = null,
    Object? products = null,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      eesupreneurId: freezed == eesupreneurId
          ? _value.eesupreneurId
          : eesupreneurId // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolOrderId: freezed == eesupoolOrderId
          ? _value.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int?,
      walletId: freezed == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placedAt: freezed == placedAt
          ? _value.placedAt
          : placedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      packagedAt: freezed == packagedAt
          ? _value.packagedAt
          : packagedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readyAt: freezed == readyAt
          ? _value.readyAt
          : readyAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      collectedAt: freezed == collectedAt
          ? _value.collectedAt
          : collectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      secretPin: null == secretPin
          ? _value.secretPin
          : secretPin // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryAddressId: freezed == deliveryAddressId
          ? _value.deliveryAddressId
          : deliveryAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveryFee: freezed == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double?,
      cardFee: freezed == cardFee
          ? _value.cardFee
          : cardFee // ignore: cast_nullable_to_non_nullable
              as double?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _value.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      assignments: null == assignments
          ? _value.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<MemberOrderAssignment>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderProduct>,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
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
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

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
    Object? fullName = freezed,
    Object? corpName = freezed,
    Object? assignments = null,
    Object? status = null,
    Object? products = null,
    Object? address = freezed,
  }) {
    return _then(_$OrderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      eesupreneurId: freezed == eesupreneurId
          ? _value.eesupreneurId
          : eesupreneurId // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolOrderId: freezed == eesupoolOrderId
          ? _value.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int?,
      walletId: freezed == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placedAt: freezed == placedAt
          ? _value.placedAt
          : placedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      packagedAt: freezed == packagedAt
          ? _value.packagedAt
          : packagedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readyAt: freezed == readyAt
          ? _value.readyAt
          : readyAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      collectedAt: freezed == collectedAt
          ? _value.collectedAt
          : collectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      secretPin: null == secretPin
          ? _value.secretPin
          : secretPin // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryAddressId: freezed == deliveryAddressId
          ? _value.deliveryAddressId
          : deliveryAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveryFee: freezed == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double?,
      cardFee: freezed == cardFee
          ? _value.cardFee
          : cardFee // ignore: cast_nullable_to_non_nullable
              as double?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _value.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      assignments: null == assignments
          ? _value._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<MemberOrderAssignment>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderProduct>,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
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

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

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

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, eesupreneurId: $eesupreneurId, eesupoolOrderId: $eesupoolOrderId, walletId: $walletId, createdAt: $createdAt, placedAt: $placedAt, packagedAt: $packagedAt, readyAt: $readyAt, collectedAt: $collectedAt, cancelledAt: $cancelledAt, value: $value, paymentMethod: $paymentMethod, secretPin: $secretPin, deliveryAddressId: $deliveryAddressId, deliveryFee: $deliveryFee, cardFee: $cardFee, fullName: $fullName, corpName: $corpName, assignments: $assignments, status: $status, products: $products, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
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

  @JsonKey(ignore: true)
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
        fullName,
        corpName,
        const DeepCollectionEquality().hash(_assignments),
        status,
        const DeepCollectionEquality().hash(_products),
        address
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {final int? id,
      @JsonKey(name: 'customer_id') required final String customerId,
      @JsonKey(name: 'eesupreneur_id') final String? eesupreneurId,
      @JsonKey(name: 'eesupool_order_id') final int? eesupoolOrderId,
      @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
      final int? walletId,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'placed_at', includeToJson: false)
      final DateTime? placedAt,
      @JsonKey(name: 'packaged_at') final DateTime? packagedAt,
      @JsonKey(name: 'ready_at') final DateTime? readyAt,
      @JsonKey(name: 'collected_at') final DateTime? collectedAt,
      @JsonKey(name: 'cancelled_at') final DateTime? cancelledAt,
      required final double value,
      @PaymentMethodConverter()
      @JsonKey(name: 'payment_method')
      required final PaymentMethod paymentMethod,
      @JsonKey(name: 'secret_pin') required final int secretPin,
      @JsonKey(name: 'delivery_address_id') final int? deliveryAddressId,
      @JsonKey(name: 'delivery_fee') final double? deliveryFee,
      @JsonKey(name: 'card_fee') final double? cardFee,
      @JsonKey(name: 'full_name') final String? fullName,
      @JsonKey(name: 'corp_name') final String? corpName,
      @MemberOrderAssignmentConverter()
      final List<MemberOrderAssignment> assignments,
      @OrderStatusConverter()
      @JsonKey(includeToJson: false)
      required final OrderStatus status,
      @OrderProductConverter() final List<OrderProduct> products,
      @AddressConverter()
      @JsonKey(includeToJson: false)
      final Address? address}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'customer_id')
  String get customerId;
  @override
  @JsonKey(name: 'eesupreneur_id')
  String? get eesupreneurId;
  @override
  @JsonKey(name: 'eesupool_order_id')
  int? get eesupoolOrderId;
  @override
  @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
  int? get walletId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'placed_at', includeToJson: false)
  DateTime? get placedAt;
  @override
  @JsonKey(name: 'packaged_at')
  DateTime? get packagedAt;
  @override
  @JsonKey(name: 'ready_at')
  DateTime? get readyAt;
  @override
  @JsonKey(name: 'collected_at')
  DateTime? get collectedAt;
  @override
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt;
  @override
  double get value;
  @override
  @PaymentMethodConverter()
  @JsonKey(name: 'payment_method')
  PaymentMethod get paymentMethod;
  @override
  @JsonKey(name: 'secret_pin')
  int get secretPin;
  @override
  @JsonKey(name: 'delivery_address_id')
  int? get deliveryAddressId;
  @override
  @JsonKey(name: 'delivery_fee')
  double? get deliveryFee;
  @override
  @JsonKey(name: 'card_fee')
  double? get cardFee;
  @override
  @JsonKey(name: 'full_name')
  String? get fullName;
  @override
  @JsonKey(name: 'corp_name')
  String? get corpName;
  @override
  @MemberOrderAssignmentConverter()
  List<MemberOrderAssignment> get assignments;
  @override
  @OrderStatusConverter()
  @JsonKey(includeToJson: false)
  OrderStatus get status;
  @override // @EESUpreneurConverter() @JsonKey(includeToJson: false) EESUpreneur? eesupreneur,
// @EESUpoolConverter() @JsonKey(includeToJson: false) EESUpool? eesupool,
// @ProfileConverter() @JsonKey(includeToJson: false) Profile? customer,
  @OrderProductConverter()
  List<OrderProduct> get products;
  @override
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address;
  @override
  @JsonKey(ignore: true)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
