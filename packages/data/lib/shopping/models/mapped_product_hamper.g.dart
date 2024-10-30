// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapped_product_hamper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HamperProductDetailImpl _$$HamperProductDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$HamperProductDetailImpl(
      hamperId: json['hamperId'] as String,
      productId: (json['productId'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      isFree: json['isFree'] as bool,
      name: json['name'] as String,
      brand: json['brand'] as String,
      type: json['type'] as String,
      imageUrl: json['imageUrl'] as String,
      salePrice: (json['salePrice'] as num).toDouble(),
      costPrice: (json['costPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$HamperProductDetailImplToJson(
        _$HamperProductDetailImpl instance) =>
    <String, dynamic>{
      'hamperId': instance.hamperId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'isFree': instance.isFree,
      'name': instance.name,
      'brand': instance.brand,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
      'salePrice': instance.salePrice,
      'costPrice': instance.costPrice,
    };
