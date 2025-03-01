// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
      id: (json['id'] as num).toInt(),
      products: (json['products'] as num?)?.toInt(),
      name: json['name'] as String,
      parentId: (json['parent_id'] as num?)?.toInt(),
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'name': instance.name,
      'parent_id': instance.parentId,
      'image_url': instance.imageUrl,
    };
