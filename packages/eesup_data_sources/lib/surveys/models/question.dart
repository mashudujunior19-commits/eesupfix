// ignore_for_file: invalid_annotation_target

import 'dart:io';
import 'package:eesup_data_source/surveys/models/option.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    @JsonKey(name: 'question_id') required int questionId,
    required String question,
    @QuestionTypeConverter() required QuestionType type,
    @JsonKey(name: 'is_required') required bool isRequired,
    @JsonKey(name: 'allow_recording') bool? allowRecording,
    @JsonKey(name: 'allow_multiple_selection') @Default(false) bool allowMultipleSelection,
    @OptionConverter() List<Option>? options,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'num_ratings') int? numRatings,
    @JsonKey(name: 'slider_interval') int? sliderInterval,
    @JsonKey(name: 'slider_max') int? sliderMax,
    @JsonKey(name: 'slider_min') int? sliderMin,
    String? comment,
    @JsonKey(name: 'allow_multiple_files')
    @Default(false)
    bool allowMultipleFiles,
    @JsonKey(name: 'media_file_type') String? mediaFileType,

    ///answering
    @JsonKey(includeFromJson: false, includeToJson: false) int? sliderValue,
    @JsonKey(includeFromJson: false, includeToJson: false) int? ratingValue,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? openEndedAnswer,
    @JsonKey(includeFromJson: false, includeToJson: false) String? recordingUrl,
    @JsonKey(includeFromJson: false, includeToJson: false) File? recordingFile,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<String>? fileUrls,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<File>? pickedfiles,
    @JsonKey(includeFromJson: false, includeToJson: false) File? singleFile,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? singleFileUrl,
    @JsonKey(includeFromJson: false, includeToJson: false) String? pickedDate,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? dateTimePicked,
    @JsonKey(includeFromJson: false, includeToJson: false) String? timePicked,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}

class QuestionConverter
    implements JsonConverter<Question, Map<String, dynamic>> {
  const QuestionConverter();

  @override
  Question fromJson(Map<String, dynamic> json) {
    return Question.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Question object) {
    return object.toJson();
  }
}

class QuestionTypeConverter implements JsonConverter<QuestionType, String> {
  const QuestionTypeConverter();

  @override
  QuestionType fromJson(String json) {
    return QuestionType.fromString(json);
  }

  @override
  String toJson(QuestionType object) {
    return object.toString();
  }
}

enum QuestionType {
  multipleChoice,
  openEnded,
  slider,
  rating,
  date,
  time,
  dateTime,
  fileUpload;

  factory QuestionType.fromString(String value) {
    switch (value) {
      case 'Multiple Choice':
        return QuestionType.multipleChoice;
      case 'Open-ended':
        return QuestionType.openEnded;
      case 'Slider scale':
        return QuestionType.slider;
      case 'Rating':
        return QuestionType.rating;
      case 'File-upload':
        return QuestionType.fileUpload;
      case 'Date':
        return QuestionType.date;
      case 'Time':
        return QuestionType.time;
      case 'Date & Time':
        return QuestionType.dateTime;
      default:
        return QuestionType.multipleChoice;
    }
  }

  @override
  String toString() {
    switch (this) {
      case QuestionType.multipleChoice:
        return 'Multiple Choice';
      case QuestionType.openEnded:
        return 'Open-ended';
      case QuestionType.slider:
        return 'Slider scale';
      case QuestionType.rating:
        return 'Rating';
      case QuestionType.fileUpload:
        return 'File-upload';
      case QuestionType.date:
        return 'Date';
      case QuestionType.time:
        return 'Time';
      case QuestionType.dateTime:
        return 'Date & Time';
      default:
        return 'Multiple Choice';
    }
  }
}
