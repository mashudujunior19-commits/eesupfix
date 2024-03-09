// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as int,
      products: json['products'] as int?,
      name: json['name'] as String,
      parentId: json['parent_id'] as int?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'name': instance.name,
      'parent_id': instance.parentId,
      'image_url': instance.imageUrl,
    };
