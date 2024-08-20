// ignore_for_file: invalid_annotation_target

import 'package:data/notifications/models/notification_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notification with _$Notification {
  const factory Notification({
    required int id,
    required String title,
    String? body,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @NotificationTypeConveter() required NotificationType type,
    @NotificationDataConveter() NotificationData? data,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

class NotificationTypeConveter
    implements JsonConverter<NotificationType, String> {
  const NotificationTypeConveter();

  @override
  NotificationType fromJson(String json) {
    return NotificationType.from(json);
  }

  @override
  String toJson(NotificationType data) {
    return data.toString();
  }
}

enum NotificationType {
  order,
  eesupool,
  eesupoolInvite,
  eesupoolRequest,
  other;

  factory NotificationType.from(String type) {
    switch (type) {
      case 'order':
        return NotificationType.order;
      case 'eesupool':
        return NotificationType.eesupool;
      case 'eesupool_invite':
        return NotificationType.eesupoolInvite;
      case 'eesupool_request':
        return NotificationType.eesupoolRequest;
      default:
        return NotificationType.other;
    }
  }

  @override
  String toString() {
    switch (this) {
      case NotificationType.order:
        return 'order';
      case NotificationType.eesupool:
        return 'eesupool';
      case NotificationType.eesupoolInvite:
        return 'eesupool_invite';
      case NotificationType.eesupoolRequest:
        return "eesupool_request";
      default:
        return 'other';
    }
  }
}
