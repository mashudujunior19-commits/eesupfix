// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hamper_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HamperProductImpl _$$HamperProductImplFromJson(Map<String, dynamic> json) =>
    _$HamperProductImpl(
      hamperId: json['hamper_id'] as String,
      productId: (json['product_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      isFree: json['is_free'] as bool,
    );

Map<String, dynamic> _$$HamperProductImplToJson(_$HamperProductImpl instance) =>
    <String, dynamic>{
      'hamper_id': instance.hamperId,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'is_free': instance.isFree,
    };
