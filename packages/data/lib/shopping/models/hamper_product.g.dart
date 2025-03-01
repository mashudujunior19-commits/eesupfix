// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hamper_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HamperProduct _$HamperProductFromJson(Map<String, dynamic> json) =>
    _HamperProduct(
      hamperId: json['hamper_id'] as String,
      productId: (json['product_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      isFree: json['is_free'] as bool,
    );

Map<String, dynamic> _$HamperProductToJson(_HamperProduct instance) =>
    <String, dynamic>{
      'hamper_id': instance.hamperId,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'is_free': instance.isFree,
    };
