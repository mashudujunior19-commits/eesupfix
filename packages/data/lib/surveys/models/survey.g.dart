// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Survey _$SurveyFromJson(Map<String, dynamic> json) => _Survey(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      questions: (json['questions'] as List<dynamic>)
          .map((e) =>
              const QuestionConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      description: json['description'] as String?,
      wallet: json['wallet'] as String?,
      type: const SurveyTypeConverter().fromJson(json['type'] as String),
      maxResponses: (json['max_responses'] as num?)?.toInt(),
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      rewardAmount: (json['reward_amount'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toInt(),
      points: (json['points'] as num?)?.toInt(),
      respondedAt: json['responded_at'] == null
          ? null
          : DateTime.parse(json['responded_at'] as String),
      passPercentage: (json['pass_percentage'] as num?)?.toDouble(),
      enableScoring: json['enable_scoring'] as bool?,
      requireAll: json['require_all'] as bool?,
      enforceTimeLimit: json['enforce_time_limit'] as bool?,
      preSurvey: _$JsonConverterFromJson<Map<String, dynamic>, Survey>(
          json['pre_survey'], const SurveyConverter().fromJson),
      passed: json['passed'] as bool?,
      score: (json['score'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SurveyToJson(_Survey instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'questions':
          instance.questions.map(const QuestionConverter().toJson).toList(),
      'title': instance.title,
      'description': instance.description,
      'wallet': instance.wallet,
      'type': const SurveyTypeConverter().toJson(instance.type),
      'max_responses': instance.maxResponses,
      'image_url': instance.imageUrl,
      'video_url': instance.videoUrl,
      'reward_amount': instance.rewardAmount,
      'duration': instance.duration,
      'points': instance.points,
      'pass_percentage': instance.passPercentage,
      'enable_scoring': instance.enableScoring,
      'require_all': instance.requireAll,
      'enforce_time_limit': instance.enforceTimeLimit,
      'pre_survey': _$JsonConverterToJson<Map<String, dynamic>, Survey>(
          instance.preSurvey, const SurveyConverter().toJson),
      'passed': instance.passed,
      'score': instance.score,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
