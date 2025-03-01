// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DaySchedule _$DayScheduleFromJson(Map<String, dynamic> json) => _DaySchedule(
      day: json['day'] as String,
      index: (json['index'] as num).toInt(),
      openTime: json['open'] as String,
      closeTime: json['close'] as String,
      isClosed: json['is_closed'] as bool,
    );

Map<String, dynamic> _$DayScheduleToJson(_DaySchedule instance) =>
    <String, dynamic>{
      'day': instance.day,
      'index': instance.index,
      'open': instance.openTime,
      'close': instance.closeTime,
      'is_closed': instance.isClosed,
    };
