// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eesupool_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EESUpoolOrderImpl _$$EESUpoolOrderImplFromJson(Map<String, dynamic> json) =>
    _$EESUpoolOrderImpl(
      id: (json['id'] as num).toInt(),
      eesupoolId: (json['eesupool_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      scheduleFor: DateTime.parse(json['schedule_for'] as String),
      closesAt: DateTime.parse(json['closes_at'] as String),
      secretPin: (json['secret_pin'] as num?)?.toInt(),
      deliveredAt: json['delivered_at'] == null
          ? null
          : DateTime.parse(json['delivered_at'] as String),
      adminFee: (json['admin_fee'] as num?)?.toDouble(),
      packerFee: (json['packer_fee'] as num?)?.toDouble(),
      receiverFee: (json['receiver_fee'] as num?)?.toDouble(),
      collectionFee: (json['collection_fee'] as num?)?.toDouble(),
      addressId: (json['address_id'] as num?)?.toInt(),
      receiversId: (json['receivers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      eesupoolName: json['eesupool_name'] as String?,
      address: _$JsonConverterFromJson<Map<String, dynamic>, Address>(
          json['address'], const AddressConverter().fromJson),
      ordersCount: (json['orders_count'] as num?)?.toInt() ?? 0,
      currentAmount: (json['current_amount'] as num?)?.toDouble() ?? 0.00,
    );

Map<String, dynamic> _$$EESUpoolOrderImplToJson(_$EESUpoolOrderImpl instance) =>
    <String, dynamic>{
      'eesupool_id': instance.eesupoolId,
      'created_at': instance.createdAt.toIso8601String(),
      'schedule_for': instance.scheduleFor.toIso8601String(),
      'closes_at': instance.closesAt.toIso8601String(),
      'secret_pin': instance.secretPin,
      'delivered_at': instance.deliveredAt?.toIso8601String(),
      'admin_fee': instance.adminFee,
      'packer_fee': instance.packerFee,
      'receiver_fee': instance.receiverFee,
      'collection_fee': instance.collectionFee,
      'address_id': instance.addressId,
      'receivers': instance.receiversId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

_$MemberOrderAssignmentImpl _$$MemberOrderAssignmentImplFromJson(
        Map<String, dynamic> json) =>
    _$MemberOrderAssignmentImpl(
      orderId: (json['order_id'] as num).toInt(),
      eesupoolOrderId: (json['eesupool_ord_id'] as num).toInt(),
      memberId: json['member_id'] as String,
      fullName: json['full_name'] as String?,
      corpName: json['corp_name'] as String?,
      privilage: _$JsonConverterFromJson<String, OrderEditPrivilage>(
          json['privilage'], const OrderEditPrivilageConverter().fromJson),
    );

Map<String, dynamic> _$$MemberOrderAssignmentImplToJson(
        _$MemberOrderAssignmentImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'eesupool_ord_id': instance.eesupoolOrderId,
      'member_id': instance.memberId,
      'privilage': _$JsonConverterToJson<String, OrderEditPrivilage>(
          instance.privilage, const OrderEditPrivilageConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
