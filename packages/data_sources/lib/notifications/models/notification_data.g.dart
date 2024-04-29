// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDataImpl _$$NotificationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationDataImpl(
      userId: json['user_id'] as String?,
      eesupoolId: json['eesupool_id'] as int?,
      orderId: json['order_id'] as int?,
    );

Map<String, dynamic> _$$NotificationDataImplToJson(
        _$NotificationDataImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'eesupool_id': instance.eesupoolId,
      'order_id': instance.orderId,
    };
