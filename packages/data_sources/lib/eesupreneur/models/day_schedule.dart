// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_schedule.freezed.dart';
part 'day_schedule.g.dart';

class DayScheduleConverter
    implements JsonConverter<DaySchedule, Map<String, dynamic>> {
  const DayScheduleConverter();

  @override
  DaySchedule fromJson(Map<String, dynamic> json) {
    return DaySchedule.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(DaySchedule object) {
    return object.toJson();
  }
}

@freezed
class DaySchedule with _$DaySchedule {
  const factory DaySchedule({
    required String day,
    required int index,
    @JsonKey(name: 'open') required String openTime,
    @JsonKey(name: 'close') required String closeTime,
    @JsonKey(name: 'is_closed') required bool isClosed,
  }) = _DaySchedule;

  factory DaySchedule.fromJson(Map<String, dynamic> json) =>
      _$DayScheduleFromJson(json);
}
