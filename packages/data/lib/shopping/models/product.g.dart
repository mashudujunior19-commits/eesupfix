// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      size: json['size'] as String?,
      brand: json['brand'] as String?,
      type: json['type'] as String?,
      uom: json['uom'] as String?,
      unitPackSize: json['unit_pack_size'] as String?,
      flavour: json['flavour'] as String?,
      salePrice: (json['sale_price'] as num).toDouble(),
      costPrice: (json['cost_price'] as num?)?.toDouble(),
      vaa: (json['vaa'] as num?)?.toDouble(),
      vat: (json['vat'] as num?)?.toDouble(),
      orderMax: (json['order_max'] as num?)?.toInt(),
      childId: (json['child_id'] as num?)?.toInt(),
      childBreakQty: (json['child_break_qty'] as num?)?.toInt(),
      barCode: json['bar_code'] as String?,
      kitKatRef: json['kit_kat_ref'] as String?,
      vatClaimable: json['vat_claimable'] as bool?,
      vatAble: json['vat_able'] as bool?,
      productClass:
          const ProductClassConverter().fromJson(json['class'] as String),
      categoryName: json['category_name'] as String?,
      categoryImageUrl: json['category_image_url'] as String?,
      hamperId: json['hamper_id'] as String?,
      sellable: json['sellable'] as bool,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'size': instance.size,
      'brand': instance.brand,
      'type': instance.type,
      'uom': instance.uom,
      'unit_pack_size': instance.unitPackSize,
      'flavour': instance.flavour,
      'sale_price': instance.salePrice,
      'cost_price': instance.costPrice,
      'vaa': instance.vaa,
      'vat': instance.vat,
      'order_max': instance.orderMax,
      'child_id': instance.childId,
      'child_break_qty': instance.childBreakQty,
      'bar_code': instance.barCode,
      'kit_kat_ref': instance.kitKatRef,
      'vat_claimable': instance.vatClaimable,
      'vat_able': instance.vatAble,
      'class': const ProductClassConverter().toJson(instance.productClass),
      'category_name': instance.categoryName,
      'category_image_url': instance.categoryImageUrl,
      'hamper_id': instance.hamperId,
      'sellable': instance.sellable,
    };
