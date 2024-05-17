// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eesupool_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EESUpoolMemberImpl _$$EESUpoolMemberImplFromJson(Map<String, dynamic> json) =>
    _$EESUpoolMemberImpl(
      memberId: json['member_id'] as String,
      eesupoolId: (json['eesupool_id'] as num).toInt(),
      userId: json['user_id'] as String,
      role:
          const EESUpoolMemberRoleConverter().fromJson(json['role'] as String),
      isCensored: json['is_censored'] as bool,
      fullName: json['full_name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$EESUpoolMemberImplToJson(
        _$EESUpoolMemberImpl instance) =>
    <String, dynamic>{
      'eesupool_id': instance.eesupoolId,
      'user_id': instance.userId,
      'role': const EESUpoolMemberRoleConverter().toJson(instance.role),
      'is_censored': instance.isCensored,
    };
