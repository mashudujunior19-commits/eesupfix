// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Partner _$PartnerFromJson(Map<String, dynamic> json) => _Partner(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      surveys: (json['surveys'] as List<dynamic>)
          .map((e) => const PartnerSurveyConverter()
              .fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      isOpen: json['is_open'] as bool,
      maxApps: (json['max_apps'] as num).toInt(),
    );

Map<String, dynamic> _$PartnerToJson(_Partner instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'surveys':
          instance.surveys.map(const PartnerSurveyConverter().toJson).toList(),
      'created_at': instance.createdAt?.toIso8601String(),
      'is_open': instance.isOpen,
      'max_apps': instance.maxApps,
    };
