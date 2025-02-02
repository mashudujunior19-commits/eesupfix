// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eesupool_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EESUpoolSettingsImpl _$$EESUpoolSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$EESUpoolSettingsImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      minimumOrderValue: (json['minimum_order_value'] as num?)?.toDouble(),
      adminOrderCount: (json['admin_order_count'] as num?)?.toInt(),
      dailyClosingOrderTime: json['daily_closing_order_time'] as String?,
      eesupoolId: (json['eesupool_id'] as num).toInt(),
      userCount: json['user_count'] as num,
    );

Map<String, dynamic> _$$EESUpoolSettingsImplToJson(
        _$EESUpoolSettingsImpl instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'minimum_order_value': instance.minimumOrderValue,
      'admin_order_count': instance.adminOrderCount,
      'daily_closing_order_time': instance.dailyClosingOrderTime,
      'eesupool_id': instance.eesupoolId,
      'user_count': instance.userCount,
    };
