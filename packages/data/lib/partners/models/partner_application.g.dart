// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnerApplication _$PartnerApplicationFromJson(Map<String, dynamic> json) =>
    _PartnerApplication(
      id: (json['id'] as num).toInt(),
      partnerId: json['partner_id'] as String,
      userId: json['user_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      approvedAt: json['approved_at'] == null
          ? null
          : DateTime.parse(json['approved_at'] as String),
      surveyResponses: (json['survey_responses'] as List<dynamic>)
          .map((e) => const PartnerSurveyResponseConverter()
              .fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PartnerApplicationToJson(_PartnerApplication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partner_id': instance.partnerId,
      'user_id': instance.userId,
      'created_at': instance.createdAt?.toIso8601String(),
      'approved_at': instance.approvedAt?.toIso8601String(),
      'survey_responses': instance.surveyResponses
          .map(const PartnerSurveyResponseConverter().toJson)
          .toList(),
    };
