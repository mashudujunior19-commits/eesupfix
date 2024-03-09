// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_survey.freezed.dart';
part 'partner_survey.g.dart';

@freezed
class PartnerSurvey with _$PartnerSurvey {
  const factory PartnerSurvey({
    required int index,
    @JsonKey(name: 'survey_id') required String surveyId,
  }) = _PartnerSurvey;

  factory PartnerSurvey.fromJson(Map<String, dynamic> json) =>
      _$PartnerSurveyFromJson(json);
}

class PartnerSurveyConverter
    implements JsonConverter<PartnerSurvey, Map<String, dynamic>> {
  const PartnerSurveyConverter();

  @override
  PartnerSurvey fromJson(Map<String, dynamic> json) {
    return PartnerSurvey.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PartnerSurvey instance) {
    return instance.toJson();
  }
}
