// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_survey_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnerSurveyResponse _$PartnerSurveyResponseFromJson(
        Map<String, dynamic> json) =>
    _PartnerSurveyResponse(
      index: (json['index'] as num).toInt(),
      surveyId: json['survey_id'] as String,
      responseId: json['response_id'] as String,
    );

Map<String, dynamic> _$PartnerSurveyResponseToJson(
        _PartnerSurveyResponse instance) =>
    <String, dynamic>{
      'index': instance.index,
      'survey_id': instance.surveyId,
      'response_id': instance.responseId,
    };
