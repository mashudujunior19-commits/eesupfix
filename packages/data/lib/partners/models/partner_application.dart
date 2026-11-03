// ignore_for_file: invalid_annotation_target

import 'package:data/partners/models/partner_survey_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'partner_application.freezed.dart';
part 'partner_application.g.dart';

@freezed
abstract class PartnerApplication with _$PartnerApplication {
  const factory PartnerApplication({
    required int id,
    @JsonKey(name: 'partner_id') required String partnerId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'approved_at') DateTime? approvedAt,
    @JsonKey(name: 'rejected_at') DateTime? rejectedAt,

    /// Why the reviewer declined it (shown to the applicant).
    @JsonKey(name: 'decline_reason') String? declineReason,
    @PartnerSurveyResponseConverter()
    @JsonKey(name: 'survey_responses')
    required List<PartnerSurveyResponse> surveyResponses,
  }) = _PartnerApplication;

  const PartnerApplication._();

  /// pending -> approved | declined (both final).
  bool get isApproved => approvedAt != null;
  bool get isDeclined => rejectedAt != null && approvedAt == null;
  bool get isPending => !isApproved && !isDeclined;
  String get statusLabel =>
      isApproved ? 'Approved' : (isDeclined ? 'Declined' : 'Pending');

  factory PartnerApplication.fromJson(Map<String, dynamic> json) =>
      _$PartnerApplicationFromJson(json);
}
