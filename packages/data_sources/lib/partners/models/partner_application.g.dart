// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerApplicationImpl _$$PartnerApplicationImplFromJson(
        Map<String, dynamic> json) =>
    _$PartnerApplicationImpl(
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

Map<String, dynamic> _$$PartnerApplicationImplToJson(
        _$PartnerApplicationImpl instance) =>
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
