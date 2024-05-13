// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EESUpoolOrder _$EESUpoolOrderFromJson(Map<String, dynamic> json) {
  return _EESUpoolOrder.fromJson(json);
}

/// @nodoc
mixin _$EESUpoolOrder {
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'schedule_for')
  DateTime get scheduleFor => throw _privateConstructorUsedError;
  @JsonKey(name: 'closes_at')
  DateTime get closesAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'secret_pin')
  int? get secretPin => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_at')
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_fee')
  double? get adminFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'packer_fee')
  double? get packerFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiver_fee')
  double? get receiverFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'collection_fee')
  double? get collectionFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_id')
  int? get addressId => throw _privateConstructorUsedError;
  @JsonKey(name: 'receivers')
  List<String>? get receiversId => throw _privateConstructorUsedError;

  ///other
  @JsonKey(name: 'eesupool_name', includeToJson: false)
  String? get eesupoolName => throw _privateConstructorUsedError;
  @EESUpoolMemberConverter()
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<EESUpoolMember>? get receivers => throw _privateConstructorUsedError;
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'orders_count', includeToJson: false)
  int get ordersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_amount', includeToJson: false)
  double get currentAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EESUpoolOrderCopyWith<EESUpoolOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EESUpoolOrderCopyWith<$Res> {
  factory $EESUpoolOrderCopyWith(
          EESUpoolOrder value, $Res Function(EESUpoolOrder) then) =
      _$EESUpoolOrderCopyWithImpl<$Res, EESUpoolOrder>;
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
class _$EESUpoolOrderCopyWithImpl<$Res, $Val extends EESUpoolOrder>
    implements $EESUpoolOrderCopyWith<$Res> {
  _$EESUpoolOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduleFor: null == scheduleFor
          ? _value.scheduleFor
          : scheduleFor // ignore: cast_nullable_to_non_nullable
              as DateTime,
      closesAt: null == closesAt
          ? _value.closesAt
          : closesAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      secretPin: freezed == secretPin
          ? _value.secretPin
          : secretPin // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adminFee: freezed == adminFee
          ? _value.adminFee
          : adminFee // ignore: cast_nullable_to_non_nullable
              as double?,
      packerFee: freezed == packerFee
          ? _value.packerFee
          : packerFee // ignore: cast_nullable_to_non_nullable
              as double?,
      receiverFee: freezed == receiverFee
          ? _value.receiverFee
          : receiverFee // ignore: cast_nullable_to_non_nullable
              as double?,
      collectionFee: freezed == collectionFee
          ? _value.collectionFee
          : collectionFee // ignore: cast_nullable_to_non_nullable
              as double?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      receiversId: freezed == receiversId
          ? _value.receiversId
          : receiversId // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      eesupoolName: freezed == eesupoolName
          ? _value.eesupoolName
          : eesupoolName // ignore: cast_nullable_to_non_nullable
              as String?,
      receivers: freezed == receivers
          ? _value.receivers
          : receivers // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolMember>?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      ordersCount: null == ordersCount
          ? _value.ordersCount
          : ordersCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
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
abstract class _$$EESUpoolOrderImplCopyWith<$Res>
    implements $EESUpoolOrderCopyWith<$Res> {
  factory _$$EESUpoolOrderImplCopyWith(
          _$EESUpoolOrderImpl value, $Res Function(_$EESUpoolOrderImpl) then) =
      __$$EESUpoolOrderImplCopyWithImpl<$Res>;
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
class __$$EESUpoolOrderImplCopyWithImpl<$Res>
    extends _$EESUpoolOrderCopyWithImpl<$Res, _$EESUpoolOrderImpl>
    implements _$$EESUpoolOrderImplCopyWith<$Res> {
  __$$EESUpoolOrderImplCopyWithImpl(
      _$EESUpoolOrderImpl _value, $Res Function(_$EESUpoolOrderImpl) _then)
      : super(_value, _then);

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
    return _then(_$EESUpoolOrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduleFor: null == scheduleFor
          ? _value.scheduleFor
          : scheduleFor // ignore: cast_nullable_to_non_nullable
              as DateTime,
      closesAt: null == closesAt
          ? _value.closesAt
          : closesAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      secretPin: freezed == secretPin
          ? _value.secretPin
          : secretPin // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      adminFee: freezed == adminFee
          ? _value.adminFee
          : adminFee // ignore: cast_nullable_to_non_nullable
              as double?,
      packerFee: freezed == packerFee
          ? _value.packerFee
          : packerFee // ignore: cast_nullable_to_non_nullable
              as double?,
      receiverFee: freezed == receiverFee
          ? _value.receiverFee
          : receiverFee // ignore: cast_nullable_to_non_nullable
              as double?,
      collectionFee: freezed == collectionFee
          ? _value.collectionFee
          : collectionFee // ignore: cast_nullable_to_non_nullable
              as double?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      receiversId: freezed == receiversId
          ? _value._receiversId
          : receiversId // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      eesupoolName: freezed == eesupoolName
          ? _value.eesupoolName
          : eesupoolName // ignore: cast_nullable_to_non_nullable
              as String?,
      receivers: freezed == receivers
          ? _value._receivers
          : receivers // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolMember>?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      ordersCount: null == ordersCount
          ? _value.ordersCount
          : ordersCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EESUpoolOrderImpl implements _EESUpoolOrder {
  const _$EESUpoolOrderImpl(
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

  factory _$EESUpoolOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$EESUpoolOrderImplFromJson(json);

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

  @override
  String toString() {
    return 'EESUpoolOrder(id: $id, eesupoolId: $eesupoolId, createdAt: $createdAt, scheduleFor: $scheduleFor, closesAt: $closesAt, secretPin: $secretPin, deliveredAt: $deliveredAt, adminFee: $adminFee, packerFee: $packerFee, receiverFee: $receiverFee, collectionFee: $collectionFee, addressId: $addressId, receiversId: $receiversId, eesupoolName: $eesupoolName, receivers: $receivers, address: $address, ordersCount: $ordersCount, currentAmount: $currentAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EESUpoolOrderImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EESUpoolOrderImplCopyWith<_$EESUpoolOrderImpl> get copyWith =>
      __$$EESUpoolOrderImplCopyWithImpl<_$EESUpoolOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EESUpoolOrderImplToJson(
      this,
    );
  }
}

abstract class _EESUpoolOrder implements EESUpoolOrder {
  const factory _EESUpoolOrder(
      {@JsonKey(includeToJson: false) required final int id,
      @JsonKey(name: 'eesupool_id') required final int eesupoolId,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'schedule_for') required final DateTime scheduleFor,
      @JsonKey(name: 'closes_at') required final DateTime closesAt,
      @JsonKey(name: 'secret_pin') final int? secretPin,
      @JsonKey(name: 'delivered_at') final DateTime? deliveredAt,
      @JsonKey(name: 'admin_fee') final double? adminFee,
      @JsonKey(name: 'packer_fee') final double? packerFee,
      @JsonKey(name: 'receiver_fee') final double? receiverFee,
      @JsonKey(name: 'collection_fee') final double? collectionFee,
      @JsonKey(name: 'address_id') final int? addressId,
      @JsonKey(name: 'receivers') final List<String>? receiversId,
      @JsonKey(name: 'eesupool_name', includeToJson: false)
      final String? eesupoolName,
      @EESUpoolMemberConverter()
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<EESUpoolMember>? receivers,
      @AddressConverter() @JsonKey(includeToJson: false) final Address? address,
      @JsonKey(name: 'orders_count', includeToJson: false)
      final int ordersCount,
      @JsonKey(name: 'current_amount', includeToJson: false)
      final double currentAmount}) = _$EESUpoolOrderImpl;

  factory _EESUpoolOrder.fromJson(Map<String, dynamic> json) =
      _$EESUpoolOrderImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int get id;
  @override
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'schedule_for')
  DateTime get scheduleFor;
  @override
  @JsonKey(name: 'closes_at')
  DateTime get closesAt;
  @override
  @JsonKey(name: 'secret_pin')
  int? get secretPin;
  @override
  @JsonKey(name: 'delivered_at')
  DateTime? get deliveredAt;
  @override
  @JsonKey(name: 'admin_fee')
  double? get adminFee;
  @override
  @JsonKey(name: 'packer_fee')
  double? get packerFee;
  @override
  @JsonKey(name: 'receiver_fee')
  double? get receiverFee;
  @override
  @JsonKey(name: 'collection_fee')
  double? get collectionFee;
  @override
  @JsonKey(name: 'address_id')
  int? get addressId;
  @override
  @JsonKey(name: 'receivers')
  List<String>? get receiversId;
  @override

  ///other
  @JsonKey(name: 'eesupool_name', includeToJson: false)
  String? get eesupoolName;
  @override
  @EESUpoolMemberConverter()
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<EESUpoolMember>? get receivers;
  @override
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address;
  @override
  @JsonKey(name: 'orders_count', includeToJson: false)
  int get ordersCount;
  @override
  @JsonKey(name: 'current_amount', includeToJson: false)
  double get currentAmount;
  @override
  @JsonKey(ignore: true)
  _$$EESUpoolOrderImplCopyWith<_$EESUpoolOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemberOrderAssignment _$MemberOrderAssignmentFromJson(
    Map<String, dynamic> json) {
  return _MemberOrderAssignment.fromJson(json);
}

/// @nodoc
mixin _$MemberOrderAssignment {
  @JsonKey(name: 'order_id')
  int get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_ord_id')
  int get eesupoolOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id')
  String get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name', includeToJson: false)
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'corp_name', includeToJson: false)
  String? get corpName => throw _privateConstructorUsedError;
  @OrderEditPrivilageConverter()
  OrderEditPrivilage? get privilage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemberOrderAssignmentCopyWith<MemberOrderAssignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberOrderAssignmentCopyWith<$Res> {
  factory $MemberOrderAssignmentCopyWith(MemberOrderAssignment value,
          $Res Function(MemberOrderAssignment) then) =
      _$MemberOrderAssignmentCopyWithImpl<$Res, MemberOrderAssignment>;
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
class _$MemberOrderAssignmentCopyWithImpl<$Res,
        $Val extends MemberOrderAssignment>
    implements $MemberOrderAssignmentCopyWith<$Res> {
  _$MemberOrderAssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolOrderId: null == eesupoolOrderId
          ? _value.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _value.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      privilage: freezed == privilage
          ? _value.privilage
          : privilage // ignore: cast_nullable_to_non_nullable
              as OrderEditPrivilage?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemberOrderAssignmentImplCopyWith<$Res>
    implements $MemberOrderAssignmentCopyWith<$Res> {
  factory _$$MemberOrderAssignmentImplCopyWith(
          _$MemberOrderAssignmentImpl value,
          $Res Function(_$MemberOrderAssignmentImpl) then) =
      __$$MemberOrderAssignmentImplCopyWithImpl<$Res>;
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
class __$$MemberOrderAssignmentImplCopyWithImpl<$Res>
    extends _$MemberOrderAssignmentCopyWithImpl<$Res,
        _$MemberOrderAssignmentImpl>
    implements _$$MemberOrderAssignmentImplCopyWith<$Res> {
  __$$MemberOrderAssignmentImplCopyWithImpl(_$MemberOrderAssignmentImpl _value,
      $Res Function(_$MemberOrderAssignmentImpl) _then)
      : super(_value, _then);

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
    return _then(_$MemberOrderAssignmentImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolOrderId: null == eesupoolOrderId
          ? _value.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _value.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      privilage: freezed == privilage
          ? _value.privilage
          : privilage // ignore: cast_nullable_to_non_nullable
              as OrderEditPrivilage?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberOrderAssignmentImpl implements _MemberOrderAssignment {
  const _$MemberOrderAssignmentImpl(
      {@JsonKey(name: 'order_id') required this.orderId,
      @JsonKey(name: 'eesupool_ord_id') required this.eesupoolOrderId,
      @JsonKey(name: 'member_id') required this.memberId,
      @JsonKey(name: 'full_name', includeToJson: false) this.fullName,
      @JsonKey(name: 'corp_name', includeToJson: false) this.corpName,
      @OrderEditPrivilageConverter() this.privilage});

  factory _$MemberOrderAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberOrderAssignmentImplFromJson(json);

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

  @override
  String toString() {
    return 'MemberOrderAssignment(orderId: $orderId, eesupoolOrderId: $eesupoolOrderId, memberId: $memberId, fullName: $fullName, corpName: $corpName, privilage: $privilage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberOrderAssignmentImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, orderId, eesupoolOrderId,
      memberId, fullName, corpName, privilage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberOrderAssignmentImplCopyWith<_$MemberOrderAssignmentImpl>
      get copyWith => __$$MemberOrderAssignmentImplCopyWithImpl<
          _$MemberOrderAssignmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberOrderAssignmentImplToJson(
      this,
    );
  }
}

abstract class _MemberOrderAssignment implements MemberOrderAssignment {
  const factory _MemberOrderAssignment(
      {@JsonKey(name: 'order_id') required final int orderId,
      @JsonKey(name: 'eesupool_ord_id') required final int eesupoolOrderId,
      @JsonKey(name: 'member_id') required final String memberId,
      @JsonKey(name: 'full_name', includeToJson: false) final String? fullName,
      @JsonKey(name: 'corp_name', includeToJson: false) final String? corpName,
      @OrderEditPrivilageConverter()
      final OrderEditPrivilage? privilage}) = _$MemberOrderAssignmentImpl;

  factory _MemberOrderAssignment.fromJson(Map<String, dynamic> json) =
      _$MemberOrderAssignmentImpl.fromJson;

  @override
  @JsonKey(name: 'order_id')
  int get orderId;
  @override
  @JsonKey(name: 'eesupool_ord_id')
  int get eesupoolOrderId;
  @override
  @JsonKey(name: 'member_id')
  String get memberId;
  @override
  @JsonKey(name: 'full_name', includeToJson: false)
  String? get fullName;
  @override
  @JsonKey(name: 'corp_name', includeToJson: false)
  String? get corpName;
  @override
  @OrderEditPrivilageConverter()
  OrderEditPrivilage? get privilage;
  @override
  @JsonKey(ignore: true)
  _$$MemberOrderAssignmentImplCopyWith<_$MemberOrderAssignmentImpl>
      get copyWith => throw _privateConstructorUsedError;
}
