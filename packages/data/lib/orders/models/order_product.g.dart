// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderProductImpl _$$OrderProductImplFromJson(Map<String, dynamic> json) =>
    _$OrderProductImpl(
      productId: (json['product_id'] as num).toInt(),
      orderId: (json['order_id'] as num?)?.toInt(),
      category: json['class'] as String?,
      imageUrl: json['image_url'] as String?,
      size: json['size'] as String?,
      productClass: _$JsonConverterFromJson<String, ProductClass>(
          json['class'], const ProductClassConverter().fromJson),
      price: (json['price'] as num).toDouble(),
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      customerAcceptedQty:
          (json['customer_accepted_qty'] as num?)?.toInt() ?? 0,
      eesupreneurAcceptedQty:
          (json['eesupreneur_accepted_qty'] as num?)?.toInt() ?? 0,
      damagedQty: (json['damaged_qty'] as num?)?.toInt() ?? 0,
      substituteBrand: json['substitute_brand'] as bool? ?? false,
      substituteVariant: json['substitute_variant'] as bool? ?? false,
    );

Map<String, dynamic> _$$OrderProductImplToJson(_$OrderProductImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'class': instance.category,
      'price': instance.price,
      'name': instance.name,
      'quantity': instance.quantity,
      'customer_accepted_qty': instance.customerAcceptedQty,
      'eesupreneur_accepted_qty': instance.eesupreneurAcceptedQty,
      'damaged_qty': instance.damagedQty,
      'substitute_brand': instance.substituteBrand,
      'substitute_variant': instance.substituteVariant,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
