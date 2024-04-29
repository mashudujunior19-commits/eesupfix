// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      questionId: json['question_id'] as int,
      question: json['question'] as String,
      type: const QuestionTypeConverter().fromJson(json['type'] as String),
      isRequired: json['is_required'] as bool,
      allowRecording: json['allow_recording'] as bool?,
      allowMultipleSelection:
          json['allow_multiple_selection'] as bool? ?? false,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) =>
              const OptionConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['image_url'] as String?,
      numRatings: json['num_ratings'] as int?,
      sliderInterval: json['slider_interval'] as int?,
      sliderMax: json['slider_max'] as int?,
      sliderMin: json['slider_min'] as int?,
      comment: json['comment'] as String?,
      allowMultipleFiles: json['allow_multiple_files'] as bool? ?? false,
      mediaFileType: json['media_file_type'] as String?,
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'question': instance.question,
      'type': const QuestionTypeConverter().toJson(instance.type),
      'is_required': instance.isRequired,
      'allow_recording': instance.allowRecording,
      'allow_multiple_selection': instance.allowMultipleSelection,
      'options': instance.options?.map(const OptionConverter().toJson).toList(),
      'image_url': instance.imageUrl,
      'num_ratings': instance.numRatings,
      'slider_interval': instance.sliderInterval,
      'slider_max': instance.sliderMax,
      'slider_min': instance.sliderMin,
      'comment': instance.comment,
      'allow_multiple_files': instance.allowMultipleFiles,
      'media_file_type': instance.mediaFileType,
    };
