// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_survey_response.freezed.dart';
part 'partner_survey_response.g.dart';

@freezed
class PartnerSurveyResponse with _$PartnerSurveyResponse {
  const factory PartnerSurveyResponse({
    required int index,
    @JsonKey(name: 'survey_id') required String surveyId,
    @JsonKey(name: 'response_id') required String responseId,
  }) = _PartnerSurveyResponse;

  factory PartnerSurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$PartnerSurveyResponseFromJson(json);
}

class PartnerSurveyResponseConverter
    implements JsonConverter<PartnerSurveyResponse, Map<String, dynamic>> {
  const PartnerSurveyResponseConverter();

  @override
  PartnerSurveyResponse fromJson(Map<String, dynamic> json) {
    return PartnerSurveyResponse.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PartnerSurveyResponse instance) {
    return instance.toJson();
  }
}
