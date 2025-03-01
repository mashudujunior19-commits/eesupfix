// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnerSurvey _$PartnerSurveyFromJson(Map<String, dynamic> json) =>
    _PartnerSurvey(
      index: (json['index'] as num).toInt(),
      surveyId: json['survey_id'] as String,
    );

Map<String, dynamic> _$PartnerSurveyToJson(_PartnerSurvey instance) =>
    <String, dynamic>{
      'index': instance.index,
      'survey_id': instance.surveyId,
    };
