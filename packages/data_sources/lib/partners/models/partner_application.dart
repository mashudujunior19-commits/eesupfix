// ignore_for_file: invalid_annotation_target

import 'package:data_sources/partners/models/partner_survey_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'partner_application.freezed.dart';
part 'partner_application.g.dart';

@freezed
class PartnerApplication with _$PartnerApplication {
  const factory PartnerApplication({
    required int id,
    @JsonKey(name: 'partner_id') required String partnerId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'approved_at') DateTime? approvedAt,
    @PartnerSurveyResponseConverter()
    @JsonKey(name: 'survey_responses')
    required List<PartnerSurveyResponse> surveyResponses,
  }) = _PartnerApplication;

  factory PartnerApplication.fromJson(Map<String, dynamic> json) =>
      _$PartnerApplicationFromJson(json);
}
