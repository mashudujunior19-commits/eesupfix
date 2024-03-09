// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BasketProductImpl _$$BasketProductImplFromJson(Map<String, dynamic> json) =>
    _$BasketProductImpl(
      basketId: json['basket_id'] as String,
      productId: json['product_id'] as int,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      substituteBrand: json['substitute_brand'] as bool? ?? false,
      substituteVariant: json['substitute_variant'] as bool? ?? false,
      size: json['size'] as String?,
      productClass:
          const ProductClassConverter().fromJson(json['class'] as String),
      sellable: json['sellable'] as bool,
    );

Map<String, dynamic> _$$BasketProductImplToJson(_$BasketProductImpl instance) =>
    <String, dynamic>{
      'basket_id': instance.basketId,
      'product_id': instance.productId,
      'image_url': instance.imageUrl,
      'category': instance.category,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'substitute_brand': instance.substituteBrand,
      'substitute_variant': instance.substituteVariant,
      'size': instance.size,
      'class': const ProductClassConverter().toJson(instance.productClass),
      'sellable': instance.sellable,
    };
