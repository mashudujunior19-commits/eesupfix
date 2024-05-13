// ignore_for_file: invalid_annotation_target

import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eesupool.freezed.dart';
part 'eesupool.g.dart';

@freezed
class EESUpool with _$EESUpool {
  const factory EESUpool({
    @JsonKey(name: 'eesupool_id', includeToJson: false) int? eesupoolId,
    required String name,
    String? description,
    @JsonKey(name: 'admin_fee') double? adminFee,
    @JsonKey(name: 'receiving_fee') double? receivingFee,
    @JsonKey(name: 'collection_fee') double? collectionFee,
    @JsonKey(name: 'packaging_fee') double? packagingFee,
    @Default(true) @JsonKey(name: 'is_public') bool isPublic,
    @Default(false) @JsonKey(name: 'chat_enabled') bool chatEnabled,
    int? code,
    @JsonKey(name: 'address_id') int? addressId,
    @EESUpoolLevelConverter()
    @JsonKey(name: 'level', includeToJson: false)
    EESUpoolLevel? level,
    @JsonKey(name: 'box_code') String? boxCode,
    @JsonKey(name: 'street_code') String? streetCode,
    @JsonKey(name: 'parent_id') int? parentId,
    @JsonKey(name: 'chat_tags') List<String>? chatTags,
    @JsonKey(name: 'chat_tags_suggestions') List<String>? chatTagsSuggestions,
    @EESUpoolMemberRoleConverter()
    @JsonKey(includeToJson: false)
    EESUpoolMemberRole? role,
    @JsonKey(name: 'is_censored', includeToJson: false) bool? isCensored,
    @EESUpoolTypeConverter()
    @JsonKey(includeToJson: false)
    required EESUpoolType type,
    @JsonKey(name: 'member_id', includeToJson: false) String? memberId,
    @JsonKey(name: 'num_members', includeToJson: false) int? numMembers,
    @JsonKey(name: 'unseen_messages', includeToJson: false) int? unseenMessages,
    @AddressConverter() @JsonKey(includeToJson: false) Address? address,
  }) = _EESUpool;

  factory EESUpool.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolFromJson(json);
}

class EESUpoolConverter
    implements JsonConverter<List<EESUpool>, List<Map<String, dynamic>>> {
  const EESUpoolConverter();

  @override
  List<EESUpool> fromJson(List<Map<String, dynamic>> json) {
    return json.map((e) => EESUpool.fromJson(e)).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<EESUpool> object) {
    return object.map((e) => e.toJson()).toList();
  }
}
