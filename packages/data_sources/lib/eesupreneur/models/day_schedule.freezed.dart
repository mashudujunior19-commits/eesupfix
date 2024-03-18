// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DaySchedule _$DayScheduleFromJson(Map<String, dynamic> json) {
  return _DaySchedule.fromJson(json);
}

/// @nodoc
mixin _$DaySchedule {
  String get day => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  @JsonKey(name: 'open')
  String get openTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'close')
  String get closeTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_closed')
  bool get isClosed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DayScheduleCopyWith<DaySchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayScheduleCopyWith<$Res> {
  factory $DayScheduleCopyWith(
          DaySchedule value, $Res Function(DaySchedule) then) =
      _$DayScheduleCopyWithImpl<$Res, DaySchedule>;
  @useResult
  $Res call(
      {String day,
      int index,
      @JsonKey(name: 'open') String openTime,
      @JsonKey(name: 'close') String closeTime,
      @JsonKey(name: 'is_closed') bool isClosed});
}

/// @nodoc
class _$DayScheduleCopyWithImpl<$Res, $Val extends DaySchedule>
    implements $DayScheduleCopyWith<$Res> {
  _$DayScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? index = null,
    Object? openTime = null,
    Object? closeTime = null,
    Object? isClosed = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      openTime: null == openTime
          ? _value.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String,
      closeTime: null == closeTime
          ? _value.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String,
      isClosed: null == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DayScheduleImplCopyWith<$Res>
    implements $DayScheduleCopyWith<$Res> {
  factory _$$DayScheduleImplCopyWith(
          _$DayScheduleImpl value, $Res Function(_$DayScheduleImpl) then) =
      __$$DayScheduleImplCopyWithImpl<$Res>;
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
class __$$DayScheduleImplCopyWithImpl<$Res>
    extends _$DayScheduleCopyWithImpl<$Res, _$DayScheduleImpl>
    implements _$$DayScheduleImplCopyWith<$Res> {
  __$$DayScheduleImplCopyWithImpl(
      _$DayScheduleImpl _value, $Res Function(_$DayScheduleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? index = null,
    Object? openTime = null,
    Object? closeTime = null,
    Object? isClosed = null,
  }) {
    return _then(_$DayScheduleImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      openTime: null == openTime
          ? _value.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String,
      closeTime: null == closeTime
          ? _value.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String,
      isClosed: null == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DayScheduleImpl implements _DaySchedule {
  const _$DayScheduleImpl(
      {required this.day,
      required this.index,
      @JsonKey(name: 'open') required this.openTime,
      @JsonKey(name: 'close') required this.closeTime,
      @JsonKey(name: 'is_closed') required this.isClosed});

  factory _$DayScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$DayScheduleImplFromJson(json);

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

  @override
  String toString() {
    return 'DaySchedule(day: $day, index: $index, openTime: $openTime, closeTime: $closeTime, isClosed: $isClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DayScheduleImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, day, index, openTime, closeTime, isClosed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DayScheduleImplCopyWith<_$DayScheduleImpl> get copyWith =>
      __$$DayScheduleImplCopyWithImpl<_$DayScheduleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DayScheduleImplToJson(
      this,
    );
  }
}

abstract class _DaySchedule implements DaySchedule {
  const factory _DaySchedule(
          {required final String day,
          required final int index,
          @JsonKey(name: 'open') required final String openTime,
          @JsonKey(name: 'close') required final String closeTime,
          @JsonKey(name: 'is_closed') required final bool isClosed}) =
      _$DayScheduleImpl;

  factory _DaySchedule.fromJson(Map<String, dynamic> json) =
      _$DayScheduleImpl.fromJson;

  @override
  String get day;
  @override
  int get index;
  @override
  @JsonKey(name: 'open')
  String get openTime;
  @override
  @JsonKey(name: 'close')
  String get closeTime;
  @override
  @JsonKey(name: 'is_closed')
  bool get isClosed;
  @override
  @JsonKey(ignore: true)
  _$$DayScheduleImplCopyWith<_$DayScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
