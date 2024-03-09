// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['id'] as int?,
      customerId: json['customer_id'] as String,
      eesupreneurId: json['eesupreneur_id'] as String?,
      eesupoolOrderId: json['eesupool_order_id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      placedAt: json['placed_at'] == null
          ? null
          : DateTime.parse(json['placed_at'] as String),
      packagedAt: json['packaged_at'] == null
          ? null
          : DateTime.parse(json['packaged_at'] as String),
      readyAt: json['ready_at'] == null
          ? null
          : DateTime.parse(json['ready_at'] as String),
      collectedAt: json['collected_at'] == null
          ? null
          : DateTime.parse(json['collected_at'] as String),
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      value: (json['value'] as num).toDouble(),
      paymentMethod: const PaymentMethodConverter()
          .fromJson(json['payment_method'] as String),
      secretPin: json['secret_pin'] as int,
      deliveryAddressId: json['delivery_address_id'] as int?,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble(),
      fullName: json['full_name'] as String?,
      corpName: json['corp_name'] as String?,
      assignments: (json['assignments'] as List<dynamic>?)
              ?.map((e) => const MemberOrderAssignmentConverter()
                  .fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: const OrderStatusConverter().fromJson(json['status'] as String),
      products: json['products'] == null
          ? const []
          : const OrderProductConverter().fromJson(json['products'] as List),
      address: _$JsonConverterFromJson<Map<String, dynamic>, Address>(
          json['address'], const AddressConverter().fromJson),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'eesupreneur_id': instance.eesupreneurId,
      'eesupool_order_id': instance.eesupoolOrderId,
      'created_at': instance.createdAt?.toIso8601String(),
      'packaged_at': instance.packagedAt?.toIso8601String(),
      'ready_at': instance.readyAt?.toIso8601String(),
      'collected_at': instance.collectedAt?.toIso8601String(),
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'value': instance.value,
      'payment_method':
          const PaymentMethodConverter().toJson(instance.paymentMethod),
      'secret_pin': instance.secretPin,
      'delivery_address_id': instance.deliveryAddressId,
      'delivery_fee': instance.deliveryFee,
      'full_name': instance.fullName,
      'corp_name': instance.corpName,
      'assignments': instance.assignments
          .map(const MemberOrderAssignmentConverter().toJson)
          .toList(),
      'products': const OrderProductConverter().toJson(instance.products),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
