// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SurveyResponseImpl _$$SurveyResponseImplFromJson(Map<String, dynamic> json) =>
    _$SurveyResponseImpl(
      userId: json['user_id'] as String,
      surveyId: json['survey_id'] as String,
      score: (json['score'] as num).toInt(),
      passed: json['passed'] as bool,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => const QuestionAnswerConverter()
              .fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SurveyResponseImplToJson(
        _$SurveyResponseImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'survey_id': instance.surveyId,
      'score': instance.score,
      'passed': instance.passed,
      'answers':
          instance.answers.map(const QuestionAnswerConverter().toJson).toList(),
    };

_$QuestionAnswerImpl _$$QuestionAnswerImplFromJson(Map<String, dynamic> json) =>
    _$QuestionAnswerImpl(
      questionId: (json['question_id'] as num).toInt(),
      sliderValue: (json['slider_value'] as num?)?.toInt(),
      ratingValue: (json['rating_value'] as num?)?.toInt(),
      openEndedAnswer: json['open_ended_answer'] as String?,
      recordingUrl: json['recording_url'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) =>
              const MediaFileConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      dateTime: json['date_time'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$$QuestionAnswerImplToJson(
        _$QuestionAnswerImpl instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'slider_value': instance.sliderValue,
      'rating_value': instance.ratingValue,
      'open_ended_answer': instance.openEndedAnswer,
      'recording_url': instance.recordingUrl,
      'files': instance.files?.map(const MediaFileConverter().toJson).toList(),
      'date_time': instance.dateTime,
      'date': instance.date,
      'time': instance.time,
    };
