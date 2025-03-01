// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EESUpoolOrder {
  @JsonKey(includeToJson: false)
  int get id;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'schedule_for')
  DateTime get scheduleFor;
  @JsonKey(name: 'closes_at')
  DateTime get closesAt;
  @JsonKey(name: 'secret_pin')
  int? get secretPin;
  @JsonKey(name: 'delivered_at')
  DateTime? get deliveredAt;
  @JsonKey(name: 'admin_fee')
  double? get adminFee;
  @JsonKey(name: 'packer_fee')
  double? get packerFee;
  @JsonKey(name: 'receiver_fee')
  double? get receiverFee;
  @JsonKey(name: 'collection_fee')
  double? get collectionFee;
  @JsonKey(name: 'address_id')
  int? get addressId;
  @JsonKey(name: 'receivers')
  List<String>? get receiversId;

  ///other
  @JsonKey(name: 'eesupool_name', includeToJson: false)
  String? get eesupoolName;
  @EESUpoolMemberConverter()
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<EESUpoolMember>? get receivers;
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address;
  @JsonKey(name: 'orders_count', includeToJson: false)
  int get ordersCount;
  @JsonKey(name: 'current_amount', includeToJson: false)
  double get currentAmount;

  /// Create a copy of EESUpoolOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EESUpoolOrderCopyWith<EESUpoolOrder> get copyWith =>
      _$EESUpoolOrderCopyWithImpl<EESUpoolOrder>(
          this as EESUpoolOrder, _$identity);

  /// Serializes this EESUpoolOrder to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EESUpoolOrder &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.scheduleFor, scheduleFor) ||
                other.scheduleFor == scheduleFor) &&
            (identical(other.closesAt, closesAt) ||
                other.closesAt == closesAt) &&
            (identical(other.secretPin, secretPin) ||
                other.secretPin == secretPin) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.adminFee, adminFee) ||
                other.adminFee == adminFee) &&
            (identical(other.packerFee, packerFee) ||
                other.packerFee == packerFee) &&
            (identical(other.receiverFee, receiverFee) ||
                other.receiverFee == receiverFee) &&
            (identical(other.collectionFee, collectionFee) ||
                other.collectionFee == collectionFee) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            const DeepCollectionEquality()
                .equals(other.receiversId, receiversId) &&
            (identical(other.eesupoolName, eesupoolName) ||
                other.eesupoolName == eesupoolName) &&
            const DeepCollectionEquality().equals(other.receivers, receivers) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.ordersCount, ordersCount) ||
                other.ordersCount == ordersCount) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eesupoolId,
      createdAt,
      scheduleFor,
      closesAt,
      secretPin,
      deliveredAt,
      adminFee,
      packerFee,
      receiverFee,
      collectionFee,
      addressId,
      const DeepCollectionEquality().hash(receiversId),
      eesupoolName,
      const DeepCollectionEquality().hash(receivers),
      address,
      ordersCount,
      currentAmount);

  @override
  String toString() {
    return 'EESUpoolOrder(id: $id, eesupoolId: $eesupoolId, createdAt: $createdAt, scheduleFor: $scheduleFor, closesAt: $closesAt, secretPin: $secretPin, deliveredAt: $deliveredAt, adminFee: $adminFee, packerFee: $packerFee, receiverFee: $receiverFee, collectionFee: $collectionFee, addressId: $addressId, receiversId: $receiversId, eesupoolName: $eesupoolName, receivers: $receivers, address: $address, ordersCount: $ordersCount, currentAmount: $currentAmount)';
  }
}

/// @nodoc
abstract mixin class $EESUpoolOrderCopyWith<$Res> {
  factory $EESUpoolOrderCopyWith(
          EESUpoolOrder value, $Res Function(EESUpoolOrder) _then) =
      _$EESUpoolOrderCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'schedule_for') DateTime scheduleFor,
      @JsonKey(name: 'closes_at') DateTime closesAt,
      @JsonKey(name: 'secret_pin') int? secretPin,
      @JsonKey(name: 'delivered_at') DateTime? deliveredAt,
      @JsonKey(name: 'admin_fee') double? adminFee,
      @JsonKey(name: 'packer_fee') double? packerFee,
      @JsonKey(name: 'receiver_fee') double? receiverFee,
      @JsonKey(name: 'collection_fee') double? collectionFee,
      @JsonKey(name: 'address_id') int? addressId,
      @JsonKey(name: 'receivers') List<String>? receiversId,
      @JsonKey(name: 'eesupool_name', includeToJson: false)
      String? eesupoolName,
      @EESUpoolMemberConverter()
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<EESUpoolMember>? receivers,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address,
      @JsonKey(name: 'orders_count', includeToJson: false) int ordersCount,
      @JsonKey(name: 'current_amount', includeToJson: false)
      double currentAmount});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$EESUpoolOrderCopyWithImpl<$Res>
    implements $EESUpoolOrderCopyWith<$Res> {
  _$EESUpoolOrderCopyWithImpl(this._self, this._then);

  final EESUpoolOrder _self;
  final $Res Function(EESUpoolOrder) _then;

  /// Create a copy of EESUpoolOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eesupoolId = null,
    Object? createdAt = null,
    Object? scheduleFor = null,
    Object? closesAt = null,
    Object? secretPin = freezed,
    Object? deliveredAt = freezed,
    Object? adminFee = freezed,
    Object? packerFee = freezed,
    Object? receiverFee = freezed,
    Object? collectionFee = freezed,
    Object? addressId = freezed,
    Object? receiversId = freezed,
    Object? eesupoolName = freezed,
    Object? receivers = freezed,
    Object? address = freezed,
    Object? ordersCount = null,
    Object? currentAmount = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduleFor: null == scheduleFor
          ? _self.scheduleFor
          : scheduleFor // ignore: cast_nullable_to_non_nullable
              as DateTime,
      closesAt: null == closesAt
          ? _self.closesAt
          : closesAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      secretPin: freezed == secretPin
          ? _self.secretPin
          : secretPin // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveredAt: freezed == deliveredAt
          ? _self.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adminFee: freezed == adminFee
          ? _self.adminFee
          : adminFee // ignore: cast_nullable_to_non_nullable
              as double?,
      packerFee: freezed == packerFee
          ? _self.packerFee
          : packerFee // ignore: cast_nullable_to_non_nullable
              as double?,
      receiverFee: freezed == receiverFee
          ? _self.receiverFee
          : receiverFee // ignore: cast_nullable_to_non_nullable
              as double?,
      collectionFee: freezed == collectionFee
          ? _self.collectionFee
          : collectionFee // ignore: cast_nullable_to_non_nullable
              as double?,
      addressId: freezed == addressId
          ? _self.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      receiversId: freezed == receiversId
          ? _self.receiversId
          : receiversId // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      eesupoolName: freezed == eesupoolName
          ? _self.eesupoolName
          : eesupoolName // ignore: cast_nullable_to_non_nullable
              as String?,
      receivers: freezed == receivers
          ? _self.receivers
          : receivers // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolMember>?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      ordersCount: null == ordersCount
          ? _self.ordersCount
          : ordersCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentAmount: null == currentAmount
          ? _self.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of EESUpoolOrder
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
class _EESUpoolOrder implements EESUpoolOrder {
  const _EESUpoolOrder(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'eesupool_id') required this.eesupoolId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'schedule_for') required this.scheduleFor,
      @JsonKey(name: 'closes_at') required this.closesAt,
      @JsonKey(name: 'secret_pin') this.secretPin,
      @JsonKey(name: 'delivered_at') this.deliveredAt,
      @JsonKey(name: 'admin_fee') this.adminFee,
      @JsonKey(name: 'packer_fee') this.packerFee,
      @JsonKey(name: 'receiver_fee') this.receiverFee,
      @JsonKey(name: 'collection_fee') this.collectionFee,
      @JsonKey(name: 'address_id') this.addressId,
      @JsonKey(name: 'receivers') final List<String>? receiversId,
      @JsonKey(name: 'eesupool_name', includeToJson: false) this.eesupoolName,
      @EESUpoolMemberConverter()
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<EESUpoolMember>? receivers,
      @AddressConverter() @JsonKey(includeToJson: false) this.address,
      @JsonKey(name: 'orders_count', includeToJson: false) this.ordersCount = 0,
      @JsonKey(name: 'current_amount', includeToJson: false)
      this.currentAmount = 0.00})
      : _receiversId = receiversId,
        _receivers = receivers;
  factory _EESUpoolOrder.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolOrderFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int id;
  @override
  @JsonKey(name: 'eesupool_id')
  final int eesupoolId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'schedule_for')
  final DateTime scheduleFor;
  @override
  @JsonKey(name: 'closes_at')
  final DateTime closesAt;
  @override
  @JsonKey(name: 'secret_pin')
  final int? secretPin;
  @override
  @JsonKey(name: 'delivered_at')
  final DateTime? deliveredAt;
  @override
  @JsonKey(name: 'admin_fee')
  final double? adminFee;
  @override
  @JsonKey(name: 'packer_fee')
  final double? packerFee;
  @override
  @JsonKey(name: 'receiver_fee')
  final double? receiverFee;
  @override
  @JsonKey(name: 'collection_fee')
  final double? collectionFee;
  @override
  @JsonKey(name: 'address_id')
  final int? addressId;
  final List<String>? _receiversId;
  @override
  @JsonKey(name: 'receivers')
  List<String>? get receiversId {
    final value = _receiversId;
    if (value == null) return null;
    if (_receiversId is EqualUnmodifiableListView) return _receiversId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  ///other
  @override
  @JsonKey(name: 'eesupool_name', includeToJson: false)
  final String? eesupoolName;
  final List<EESUpoolMember>? _receivers;
  @override
  @EESUpoolMemberConverter()
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<EESUpoolMember>? get receivers {
    final value = _receivers;
    if (value == null) return null;
    if (_receivers is EqualUnmodifiableListView) return _receivers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @AddressConverter()
  @JsonKey(includeToJson: false)
  final Address? address;
  @override
  @JsonKey(name: 'orders_count', includeToJson: false)
  final int ordersCount;
  @override
  @JsonKey(name: 'current_amount', includeToJson: false)
  final double currentAmount;

  /// Create a copy of EESUpoolOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EESUpoolOrderCopyWith<_EESUpoolOrder> get copyWith =>
      __$EESUpoolOrderCopyWithImpl<_EESUpoolOrder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EESUpoolOrderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EESUpoolOrder &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.scheduleFor, scheduleFor) ||
                other.scheduleFor == scheduleFor) &&
            (identical(other.closesAt, closesAt) ||
                other.closesAt == closesAt) &&
            (identical(other.secretPin, secretPin) ||
                other.secretPin == secretPin) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.adminFee, adminFee) ||
                other.adminFee == adminFee) &&
            (identical(other.packerFee, packerFee) ||
                other.packerFee == packerFee) &&
            (identical(other.receiverFee, receiverFee) ||
                other.receiverFee == receiverFee) &&
            (identical(other.collectionFee, collectionFee) ||
                other.collectionFee == collectionFee) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            const DeepCollectionEquality()
                .equals(other._receiversId, _receiversId) &&
            (identical(other.eesupoolName, eesupoolName) ||
                other.eesupoolName == eesupoolName) &&
            const DeepCollectionEquality()
                .equals(other._receivers, _receivers) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.ordersCount, ordersCount) ||
                other.ordersCount == ordersCount) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eesupoolId,
      createdAt,
      scheduleFor,
      closesAt,
      secretPin,
      deliveredAt,
      adminFee,
      packerFee,
      receiverFee,
      collectionFee,
      addressId,
      const DeepCollectionEquality().hash(_receiversId),
      eesupoolName,
      const DeepCollectionEquality().hash(_receivers),
      address,
      ordersCount,
      currentAmount);

  @override
  String toString() {
    return 'EESUpoolOrder(id: $id, eesupoolId: $eesupoolId, createdAt: $createdAt, scheduleFor: $scheduleFor, closesAt: $closesAt, secretPin: $secretPin, deliveredAt: $deliveredAt, adminFee: $adminFee, packerFee: $packerFee, receiverFee: $receiverFee, collectionFee: $collectionFee, addressId: $addressId, receiversId: $receiversId, eesupoolName: $eesupoolName, receivers: $receivers, address: $address, ordersCount: $ordersCount, currentAmount: $currentAmount)';
  }
}

/// @nodoc
abstract mixin class _$EESUpoolOrderCopyWith<$Res>
    implements $EESUpoolOrderCopyWith<$Res> {
  factory _$EESUpoolOrderCopyWith(
          _EESUpoolOrder value, $Res Function(_EESUpoolOrder) _then) =
      __$EESUpoolOrderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'schedule_for') DateTime scheduleFor,
      @JsonKey(name: 'closes_at') DateTime closesAt,
      @JsonKey(name: 'secret_pin') int? secretPin,
      @JsonKey(name: 'delivered_at') DateTime? deliveredAt,
      @JsonKey(name: 'admin_fee') double? adminFee,
      @JsonKey(name: 'packer_fee') double? packerFee,
      @JsonKey(name: 'receiver_fee') double? receiverFee,
      @JsonKey(name: 'collection_fee') double? collectionFee,
      @JsonKey(name: 'address_id') int? addressId,
      @JsonKey(name: 'receivers') List<String>? receiversId,
      @JsonKey(name: 'eesupool_name', includeToJson: false)
      String? eesupoolName,
      @EESUpoolMemberConverter()
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<EESUpoolMember>? receivers,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address,
      @JsonKey(name: 'orders_count', includeToJson: false) int ordersCount,
      @JsonKey(name: 'current_amount', includeToJson: false)
      double currentAmount});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$EESUpoolOrderCopyWithImpl<$Res>
    implements _$EESUpoolOrderCopyWith<$Res> {
  __$EESUpoolOrderCopyWithImpl(this._self, this._then);

  final _EESUpoolOrder _self;
  final $Res Function(_EESUpoolOrder) _then;

  /// Create a copy of EESUpoolOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? eesupoolId = null,
    Object? createdAt = null,
    Object? scheduleFor = null,
    Object? closesAt = null,
    Object? secretPin = freezed,
    Object? deliveredAt = freezed,
    Object? adminFee = freezed,
    Object? packerFee = freezed,
    Object? receiverFee = freezed,
    Object? collectionFee = freezed,
    Object? addressId = freezed,
    Object? receiversId = freezed,
    Object? eesupoolName = freezed,
    Object? receivers = freezed,
    Object? address = freezed,
    Object? ordersCount = null,
    Object? currentAmount = null,
  }) {
    return _then(_EESUpoolOrder(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduleFor: null == scheduleFor
          ? _self.scheduleFor
          : scheduleFor // ignore: cast_nullable_to_non_nullable
              as DateTime,
      closesAt: null == closesAt
          ? _self.closesAt
          : closesAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      secretPin: freezed == secretPin
          ? _self.secretPin
          : secretPin // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveredAt: freezed == deliveredAt
          ? _self.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adminFee: freezed == adminFee
          ? _self.adminFee
          : adminFee // ignore: cast_nullable_to_non_nullable
              as double?,
      packerFee: freezed == packerFee
          ? _self.packerFee
          : packerFee // ignore: cast_nullable_to_non_nullable
              as double?,
      receiverFee: freezed == receiverFee
          ? _self.receiverFee
          : receiverFee // ignore: cast_nullable_to_non_nullable
              as double?,
      collectionFee: freezed == collectionFee
          ? _self.collectionFee
          : collectionFee // ignore: cast_nullable_to_non_nullable
              as double?,
      addressId: freezed == addressId
          ? _self.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      receiversId: freezed == receiversId
          ? _self._receiversId
          : receiversId // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      eesupoolName: freezed == eesupoolName
          ? _self.eesupoolName
          : eesupoolName // ignore: cast_nullable_to_non_nullable
              as String?,
      receivers: freezed == receivers
          ? _self._receivers
          : receivers // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolMember>?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      ordersCount: null == ordersCount
          ? _self.ordersCount
          : ordersCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentAmount: null == currentAmount
          ? _self.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of EESUpoolOrder
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
mixin _$MemberOrderAssignment {
  @JsonKey(name: 'order_id')
  int get orderId;
  @JsonKey(name: 'eesupool_ord_id')
  int get eesupoolOrderId;
  @JsonKey(name: 'member_id')
  String get memberId;
  @JsonKey(name: 'full_name', includeToJson: false)
  String? get fullName;
  @JsonKey(name: 'corp_name', includeToJson: false)
  String? get corpName;
  @OrderEditPrivilageConverter()
  OrderEditPrivilage? get privilage;

  /// Create a copy of MemberOrderAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MemberOrderAssignmentCopyWith<MemberOrderAssignment> get copyWith =>
      _$MemberOrderAssignmentCopyWithImpl<MemberOrderAssignment>(
          this as MemberOrderAssignment, _$identity);

  /// Serializes this MemberOrderAssignment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MemberOrderAssignment &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.eesupoolOrderId, eesupoolOrderId) ||
                other.eesupoolOrderId == eesupoolOrderId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.corpName, corpName) ||
                other.corpName == corpName) &&
            (identical(other.privilage, privilage) ||
                other.privilage == privilage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, orderId, eesupoolOrderId,
      memberId, fullName, corpName, privilage);

  @override
  String toString() {
    return 'MemberOrderAssignment(orderId: $orderId, eesupoolOrderId: $eesupoolOrderId, memberId: $memberId, fullName: $fullName, corpName: $corpName, privilage: $privilage)';
  }
}

/// @nodoc
abstract mixin class $MemberOrderAssignmentCopyWith<$Res> {
  factory $MemberOrderAssignmentCopyWith(MemberOrderAssignment value,
          $Res Function(MemberOrderAssignment) _then) =
      _$MemberOrderAssignmentCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'order_id') int orderId,
      @JsonKey(name: 'eesupool_ord_id') int eesupoolOrderId,
      @JsonKey(name: 'member_id') String memberId,
      @JsonKey(name: 'full_name', includeToJson: false) String? fullName,
      @JsonKey(name: 'corp_name', includeToJson: false) String? corpName,
      @OrderEditPrivilageConverter() OrderEditPrivilage? privilage});
}

/// @nodoc
class _$MemberOrderAssignmentCopyWithImpl<$Res>
    implements $MemberOrderAssignmentCopyWith<$Res> {
  _$MemberOrderAssignmentCopyWithImpl(this._self, this._then);

  final MemberOrderAssignment _self;
  final $Res Function(MemberOrderAssignment) _then;

  /// Create a copy of MemberOrderAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? eesupoolOrderId = null,
    Object? memberId = null,
    Object? fullName = freezed,
    Object? corpName = freezed,
    Object? privilage = freezed,
  }) {
    return _then(_self.copyWith(
      orderId: null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolOrderId: null == eesupoolOrderId
          ? _self.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _self.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _self.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      privilage: freezed == privilage
          ? _self.privilage
          : privilage // ignore: cast_nullable_to_non_nullable
              as OrderEditPrivilage?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MemberOrderAssignment implements MemberOrderAssignment {
  const _MemberOrderAssignment(
      {@JsonKey(name: 'order_id') required this.orderId,
      @JsonKey(name: 'eesupool_ord_id') required this.eesupoolOrderId,
      @JsonKey(name: 'member_id') required this.memberId,
      @JsonKey(name: 'full_name', includeToJson: false) this.fullName,
      @JsonKey(name: 'corp_name', includeToJson: false) this.corpName,
      @OrderEditPrivilageConverter() this.privilage});
  factory _MemberOrderAssignment.fromJson(Map<String, dynamic> json) =>
      _$MemberOrderAssignmentFromJson(json);

  @override
  @JsonKey(name: 'order_id')
  final int orderId;
  @override
  @JsonKey(name: 'eesupool_ord_id')
  final int eesupoolOrderId;
  @override
  @JsonKey(name: 'member_id')
  final String memberId;
  @override
  @JsonKey(name: 'full_name', includeToJson: false)
  final String? fullName;
  @override
  @JsonKey(name: 'corp_name', includeToJson: false)
  final String? corpName;
  @override
  @OrderEditPrivilageConverter()
  final OrderEditPrivilage? privilage;

  /// Create a copy of MemberOrderAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MemberOrderAssignmentCopyWith<_MemberOrderAssignment> get copyWith =>
      __$MemberOrderAssignmentCopyWithImpl<_MemberOrderAssignment>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MemberOrderAssignmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MemberOrderAssignment &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.eesupoolOrderId, eesupoolOrderId) ||
                other.eesupoolOrderId == eesupoolOrderId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.corpName, corpName) ||
                other.corpName == corpName) &&
            (identical(other.privilage, privilage) ||
                other.privilage == privilage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, orderId, eesupoolOrderId,
      memberId, fullName, corpName, privilage);

  @override
  String toString() {
    return 'MemberOrderAssignment(orderId: $orderId, eesupoolOrderId: $eesupoolOrderId, memberId: $memberId, fullName: $fullName, corpName: $corpName, privilage: $privilage)';
  }
}

/// @nodoc
abstract mixin class _$MemberOrderAssignmentCopyWith<$Res>
    implements $MemberOrderAssignmentCopyWith<$Res> {
  factory _$MemberOrderAssignmentCopyWith(_MemberOrderAssignment value,
          $Res Function(_MemberOrderAssignment) _then) =
      __$MemberOrderAssignmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'order_id') int orderId,
      @JsonKey(name: 'eesupool_ord_id') int eesupoolOrderId,
      @JsonKey(name: 'member_id') String memberId,
      @JsonKey(name: 'full_name', includeToJson: false) String? fullName,
      @JsonKey(name: 'corp_name', includeToJson: false) String? corpName,
      @OrderEditPrivilageConverter() OrderEditPrivilage? privilage});
}

/// @nodoc
class __$MemberOrderAssignmentCopyWithImpl<$Res>
    implements _$MemberOrderAssignmentCopyWith<$Res> {
  __$MemberOrderAssignmentCopyWithImpl(this._self, this._then);

  final _MemberOrderAssignment _self;
  final $Res Function(_MemberOrderAssignment) _then;

  /// Create a copy of MemberOrderAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orderId = null,
    Object? eesupoolOrderId = null,
    Object? memberId = null,
    Object? fullName = freezed,
    Object? corpName = freezed,
    Object? privilage = freezed,
  }) {
    return _then(_MemberOrderAssignment(
      orderId: null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolOrderId: null == eesupoolOrderId
          ? _self.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _self.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _self.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      privilage: freezed == privilage
          ? _self.privilage
          : privilage // ignore: cast_nullable_to_non_nullable
              as OrderEditPrivilage?,
    ));
  }
}

// dart format on
