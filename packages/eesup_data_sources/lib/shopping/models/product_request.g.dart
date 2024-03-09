// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductRequestImpl _$$ProductRequestImplFromJson(Map<String, dynamic> json) =>
    _$ProductRequestImpl(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      productId: json['product_id'] as int?,
      packSize: json['pack_size'] as String,
      type: json['type'] as String,
      brand: json['brand'] as String,
      variant: json['variant'] as String?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$$ProductRequestImplToJson(
        _$ProductRequestImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'product_id': instance.productId,
      'pack_size': instance.packSize,
      'type': instance.type,
      'brand': instance.brand,
      'variant': instance.variant,
      'quantity': instance.quantity,
    };
