// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eesupool_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EESUpoolRequestImpl _$$EESUpoolRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$EESUpoolRequestImpl(
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      eesupoolId: (json['eesupool_id'] as num).toInt(),
      type: json['request_type'] as String,
      status: json['status'] as String,
      eesupoolName: json['eesupool_name'] as String?,
      fullName: json['full_name'] as String?,
      corporateName: json['corporate_name'] as String?,
      role: const UserRoleConverter().fromJson(json['role'] as String),
    );

Map<String, dynamic> _$$EESUpoolRequestImplToJson(
        _$EESUpoolRequestImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
      'eesupool_id': instance.eesupoolId,
      'request_type': instance.type,
      'status': instance.status,
      'eesupool_name': instance.eesupoolName,
      'full_name': instance.fullName,
      'corporate_name': instance.corporateName,
      'role': const UserRoleConverter().toJson(instance.role),
    };
