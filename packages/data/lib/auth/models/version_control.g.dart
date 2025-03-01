// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_control.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VersionControl _$VersionControlFromJson(Map<String, dynamic> json) =>
    _VersionControl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      versionNumber: json['versionNumber'] as String?,
      buildNumber: (json['buildNumber'] as num?)?.toInt(),
      isLive: json['isLive'] as bool?,
      appStoreUrl: json['appStoreUrl'] as String?,
      iosUrl: json['iosUrl'] as String?,
      huaweiUrl: json['huaweiUrl'] as String?,
    );

Map<String, dynamic> _$VersionControlToJson(_VersionControl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'versionNumber': instance.versionNumber,
      'buildNumber': instance.buildNumber,
      'isLive': instance.isLive,
      'appStoreUrl': instance.appStoreUrl,
      'iosUrl': instance.iosUrl,
      'huaweiUrl': instance.huaweiUrl,
    };
