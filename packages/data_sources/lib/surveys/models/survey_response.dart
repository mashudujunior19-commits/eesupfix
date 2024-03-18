// ignore_for_file: invalid_annotation_target

import 'package:data_sources/eesupools/models/media_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_response.freezed.dart';
part 'survey_response.g.dart';

@freezed
class SurveyResponse with _$SurveyResponse {
  const factory SurveyResponse({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'survey_id') required String surveyId,
    required int score,
    required bool passed,
    @QuestionAnswerConverter() required List<QuestionAnswer> answers,
  }) = _SurveyResponse;

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);
}

class QuestionAnswerConverter
    implements JsonConverter<QuestionAnswer, Map<String, dynamic>> {
  const QuestionAnswerConverter();

  @override
  QuestionAnswer fromJson(Map<String, dynamic> json) {
    return QuestionAnswer.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(QuestionAnswer object) {
    return object.toJson();
  }
}

@freezed
class QuestionAnswer with _$QuestionAnswer {
  const factory QuestionAnswer({
    @JsonKey(name: 'question_id') required int questionId,
    @JsonKey(name: 'slider_value') int? sliderValue,
    @JsonKey(name: 'rating_value') int? ratingValue,
    @JsonKey(name: 'open_ended_answer') String? openEndedAnswer,
    @JsonKey(name: 'recording_url') String? recordingUrl,
    @MediaFileConverter() @JsonKey(name: 'files') List<MediaFile>? files,
    @JsonKey(name: 'date_time') String? dateTime,
    String? date,
    String? time,
  }) = _QuestionAnswer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerFromJson(json);
}
