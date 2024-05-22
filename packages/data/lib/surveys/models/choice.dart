// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'choice.freezed.dart';
part 'choice.g.dart';

@freezed
class Choice with _$Choice {
  const factory Choice({
    @JsonKey(name: 'option_id') required int choiceId,
    @JsonKey(name: 'option') required String choice,
    @JsonKey(name: 'is_correct') required bool isCorrect,
    @JsonKey(name: 'is_selected', includeFromJson: false)
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isSelected,
  }) = _Choice;

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
}

class ChoiceConverter implements JsonConverter<Choice, Map<String, dynamic>> {
  const ChoiceConverter();

  @override
  Choice fromJson(Map<String, dynamic> json) {
    return Choice.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Choice object) {
    return object.toJson();
  }
}
