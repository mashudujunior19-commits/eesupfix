// ignore_for_file: invalid_annotation_target, constant_identifier_names
import 'package:data/surveys/models/question.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'survey.freezed.dart';
part 'survey.g.dart';

@freezed
abstract class Survey with _$Survey {
  const factory Survey({
    required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @QuestionConverter() required List<Question> questions,
    required String title,
    String? description,
    String? wallet,
    @SurveyTypeConverter() required SurveyType type,
    @JsonKey(name: 'max_responses') int? maxResponses,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'video_url') String? videoUrl,
    @JsonKey(name: 'reward_amount') double? rewardAmount,
    int? duration,
    int? points,
    @JsonKey(name: 'responded_at', includeToJson: false) DateTime? respondedAt,
    @JsonKey(name: 'pass_percentage') double? passPercentage,
    @JsonKey(name: 'enable_scoring') bool? enableScoring,
    @JsonKey(name: 'require_all') bool? requireAll,
    @JsonKey(name: 'enforce_time_limit') bool? enforceTimeLimit,
    @SurveyConverter() @JsonKey(name: 'pre_survey') Survey? preSurvey,
    bool? passed,
    int? score,
  }) = _Survey;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);
}

class SurveyConverter implements JsonConverter<Survey, Map<String, dynamic>> {
  const SurveyConverter();

  @override
  Survey fromJson(Map<String, dynamic> json) {
    return Survey.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Survey object) {
    return object.toJson();
  }
}

enum SurveyType {
  Test,
  Survey,
  Application;

  factory SurveyType.fromJson(String ty) {
    switch (ty) {
      case 'Test':
        return SurveyType.Test;
      case 'Survey':
        return SurveyType.Survey;
      case 'Application':
        return SurveyType.Application;
      default:
        throw Exception('Unknown survey type: $ty');
    }
  }

  @override
  String toString() {
    switch (this) {
      case SurveyType.Test:
        return 'Test';
      case SurveyType.Survey:
        return 'Survey';
      case SurveyType.Application:
        return 'Application';
    }
  }
}

class SurveyTypeConverter implements JsonConverter<SurveyType, String> {
  const SurveyTypeConverter();

  @override
  SurveyType fromJson(String json) {
    return SurveyType.fromJson(json);
  }

  @override
  String toJson(SurveyType object) {
    return object.name;
  }
}
