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
    @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,

    /// 'Accepted' / 'Declined' once an invite or join request was answered.
    @JsonKey(name: 'response') String? response,

    /// 'get_involved' or 'partner_application' for application updates.
    @JsonKey(name: 'kind') String? kind,

    /// submitted | approved | declined
    @JsonKey(name: 'event') String? event,
    @JsonKey(name: 'submission_id') String? submissionId,
    @JsonKey(name: 'application_id') int? applicationId,
    @JsonKey(name: 'partner_id') String? partnerId,
    @JsonKey(name: 'reason') String? reason,

    /// KasiPool invites and join requests: true when they are for the
    /// person's Business profile.
    @JsonKey(name: 'as_business') bool? asBusiness,
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
