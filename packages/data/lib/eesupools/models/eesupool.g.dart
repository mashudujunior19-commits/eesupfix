// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eesupool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EESUpool _$EESUpoolFromJson(Map<String, dynamic> json) => _EESUpool(
      eesupoolId: (json['eesupool_id'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      adminFee: (json['admin_fee'] as num?)?.toDouble(),
      receivingFee: (json['receiving_fee'] as num?)?.toDouble(),
      collectionFee: (json['collection_fee'] as num?)?.toDouble(),
      packagingFee: (json['packaging_fee'] as num?)?.toDouble(),
      isPublic: json['is_public'] as bool? ?? true,
      chatEnabled: json['chat_enabled'] as bool? ?? false,
      code: (json['code'] as num?)?.toInt(),
      addressId: (json['address_id'] as num?)?.toInt(),
      level: _$JsonConverterFromJson<String, EESUpoolLevel>(
          json['level'], const EESUpoolLevelConverter().fromJson),
      boxCode: json['box_code'] as String?,
      streetCode: json['street_code'] as String?,
      parentId: (json['parent_id'] as num?)?.toInt(),
      chatTags: (json['chat_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      chatTagsSuggestions: (json['chat_tags_suggestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      role: _$JsonConverterFromJson<String, EESUpoolMemberRole>(
          json['role'], const EESUpoolMemberRoleConverter().fromJson),
      isCensored: json['is_censored'] as bool?,
      type: const EESUpoolTypeConverter().fromJson(json['type'] as String),
      memberId: json['member_id'] as String?,
      numMembers: (json['num_members'] as num?)?.toInt(),
      unseenMessages: (json['unseen_messages'] as num?)?.toInt(),
      address: _$JsonConverterFromJson<Map<String, dynamic>, Address>(
          json['address'], const AddressConverter().fromJson),
    );

Map<String, dynamic> _$EESUpoolToJson(_EESUpool instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'admin_fee': instance.adminFee,
      'receiving_fee': instance.receivingFee,
      'collection_fee': instance.collectionFee,
      'packaging_fee': instance.packagingFee,
      'is_public': instance.isPublic,
      'chat_enabled': instance.chatEnabled,
      'code': instance.code,
      'address_id': instance.addressId,
      'box_code': instance.boxCode,
      'street_code': instance.streetCode,
      'parent_id': instance.parentId,
      'chat_tags': instance.chatTags,
      'chat_tags_suggestions': instance.chatTagsSuggestions,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
