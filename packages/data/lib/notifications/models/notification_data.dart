// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

@freezed
abstract class NotificationData with _$NotificationData {
  const factory NotificationData({
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'eesupool_id') int? eesupoolId,
    @JsonKey(name: 'order_id') int? orderId,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}

class NotificationDataConveter
    implements JsonConverter<NotificationData, Map<String, dynamic>> {
  const NotificationDataConveter();

  @override
  NotificationData fromJson(Map<String, dynamic> json) {
    return NotificationData.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(NotificationData data) {
    return data.toJson();
  }
}
