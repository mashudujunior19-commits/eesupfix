// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DaySchedule {
  String get day;
  int get index;
  @JsonKey(name: 'open')
  String get openTime;
  @JsonKey(name: 'close')
  String get closeTime;
  @JsonKey(name: 'is_closed')
  bool get isClosed;

  /// Create a copy of DaySchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DayScheduleCopyWith<DaySchedule> get copyWith =>
      _$DayScheduleCopyWithImpl<DaySchedule>(this as DaySchedule, _$identity);

  /// Serializes this DaySchedule to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DaySchedule &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, day, index, openTime, closeTime, isClosed);

  @override
  String toString() {
    return 'DaySchedule(day: $day, index: $index, openTime: $openTime, closeTime: $closeTime, isClosed: $isClosed)';
  }
}

/// @nodoc
abstract mixin class $DayScheduleCopyWith<$Res> {
  factory $DayScheduleCopyWith(
          DaySchedule value, $Res Function(DaySchedule) _then) =
      _$DayScheduleCopyWithImpl;
  @useResult
  $Res call(
      {String day,
      int index,
      @JsonKey(name: 'open') String openTime,
      @JsonKey(name: 'close') String closeTime,
      @JsonKey(name: 'is_closed') bool isClosed});
}

/// @nodoc
class _$DayScheduleCopyWithImpl<$Res> implements $DayScheduleCopyWith<$Res> {
  _$DayScheduleCopyWithImpl(this._self, this._then);

  final DaySchedule _self;
  final $Res Function(DaySchedule) _then;

  /// Create a copy of DaySchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? index = null,
    Object? openTime = null,
    Object? closeTime = null,
    Object? isClosed = null,
  }) {
    return _then(_self.copyWith(
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      openTime: null == openTime
          ? _self.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String,
      closeTime: null == closeTime
          ? _self.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String,
      isClosed: null == isClosed
          ? _self.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DaySchedule implements DaySchedule {
  const _DaySchedule(
      {required this.day,
      required this.index,
      @JsonKey(name: 'open') required this.openTime,
      @JsonKey(name: 'close') required this.closeTime,
      @JsonKey(name: 'is_closed') required this.isClosed});
  factory _DaySchedule.fromJson(Map<String, dynamic> json) =>
      _$DayScheduleFromJson(json);

  @override
  final String day;
  @override
  final int index;
  @override
  @JsonKey(name: 'open')
  final String openTime;
  @override
  @JsonKey(name: 'close')
  final String closeTime;
  @override
  @JsonKey(name: 'is_closed')
  final bool isClosed;

  /// Create a copy of DaySchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DayScheduleCopyWith<_DaySchedule> get copyWith =>
      __$DayScheduleCopyWithImpl<_DaySchedule>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DayScheduleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DaySchedule &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, day, index, openTime, closeTime, isClosed);

  @override
  String toString() {
    return 'DaySchedule(day: $day, index: $index, openTime: $openTime, closeTime: $closeTime, isClosed: $isClosed)';
  }
}

/// @nodoc
abstract mixin class _$DayScheduleCopyWith<$Res>
    implements $DayScheduleCopyWith<$Res> {
  factory _$DayScheduleCopyWith(
          _DaySchedule value, $Res Function(_DaySchedule) _then) =
      __$DayScheduleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String day,
      int index,
      @JsonKey(name: 'open') String openTime,
      @JsonKey(name: 'close') String closeTime,
      @JsonKey(name: 'is_closed') bool isClosed});
}

/// @nodoc
class __$DayScheduleCopyWithImpl<$Res> implements _$DayScheduleCopyWith<$Res> {
  __$DayScheduleCopyWithImpl(this._self, this._then);

  final _DaySchedule _self;
  final $Res Function(_DaySchedule) _then;

  /// Create a copy of DaySchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? day = null,
    Object? index = null,
    Object? openTime = null,
    Object? closeTime = null,
    Object? isClosed = null,
  }) {
    return _then(_DaySchedule(
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      openTime: null == openTime
          ? _self.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String,
      closeTime: null == closeTime
          ? _self.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String,
      isClosed: null == isClosed
          ? _self.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
