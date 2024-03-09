// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'option.freezed.dart';
part 'option.g.dart';

@freezed
class Option with _$Option {
  const factory Option({
    @JsonKey(name: 'option_id') required int optionId,
    required String option,
    @JsonKey(name: 'is_correct') required bool isCorrect,
    @JsonKey(name: 'is_selected', includeFromJson: false)
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isSelected,
  }) = _Option;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}

class OptionConverter implements JsonConverter<Option, Map<String, dynamic>> {
  const OptionConverter();

  @override
  Option fromJson(Map<String, dynamic> json) {
    return Option.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Option object) {
    return object.toJson();
  }
}
