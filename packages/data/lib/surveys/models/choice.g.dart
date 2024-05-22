// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoiceImpl _$$ChoiceImplFromJson(Map<String, dynamic> json) => _$ChoiceImpl(
      choiceId: (json['option_id'] as num).toInt(),
      choice: json['option'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$$ChoiceImplToJson(_$ChoiceImpl instance) =>
    <String, dynamic>{
      'option_id': instance.choiceId,
      'option': instance.choice,
      'is_correct': instance.isCorrect,
    };
