// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Choice _$ChoiceFromJson(Map<String, dynamic> json) => _Choice(
      choiceId: (json['option_id'] as num).toInt(),
      choice: json['option'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$ChoiceToJson(_Choice instance) => <String, dynamic>{
      'option_id': instance.choiceId,
      'option': instance.choice,
      'is_correct': instance.isCorrect,
    };
