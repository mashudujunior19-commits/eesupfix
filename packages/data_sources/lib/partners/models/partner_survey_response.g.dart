// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_survey_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerSurveyResponseImpl _$$PartnerSurveyResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PartnerSurveyResponseImpl(
      index: (json['index'] as num).toInt(),
      surveyId: json['survey_id'] as String,
      responseId: json['response_id'] as String,
    );

Map<String, dynamic> _$$PartnerSurveyResponseImplToJson(
        _$PartnerSurveyResponseImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'survey_id': instance.surveyId,
      'response_id': instance.responseId,
    };
