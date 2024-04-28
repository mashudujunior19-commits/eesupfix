// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OptionImpl _$$OptionImplFromJson(Map<String, dynamic> json) => _$OptionImpl(
      optionId: (json['option_id'] as num).toInt(),
      option: json['option'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$$OptionImplToJson(_$OptionImpl instance) =>
    <String, dynamic>{
      'option_id': instance.optionId,
      'option': instance.option,
      'is_correct': instance.isCorrect,
    };
