// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EESUpoolSettings _$EESUpoolSettingsFromJson(Map<String, dynamic> json) {
  return _EESUpoolSettings.fromJson(json);
}

/// @nodoc
mixin _$EESUpoolSettings {
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'minimum_order_value')
  double? get minimumOrderValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_order_count')
  int? get adminOrderCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'daily_closing_order_time')
  String? get dailyClosingOrderTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_count', fromJson: _userCountFromJson)
  num get userCount => throw _privateConstructorUsedError;

  /// Serializes this EESUpoolSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EESUpoolSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EESUpoolSettingsCopyWith<EESUpoolSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EESUpoolSettingsCopyWith<$Res> {
  factory $EESUpoolSettingsCopyWith(
          EESUpoolSettings value, $Res Function(EESUpoolSettings) then) =
      _$EESUpoolSettingsCopyWithImpl<$Res, EESUpoolSettings>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'minimum_order_value') double? minimumOrderValue,
      @JsonKey(name: 'admin_order_count') int? adminOrderCount,
      @JsonKey(name: 'daily_closing_order_time') String? dailyClosingOrderTime,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'user_count', fromJson: _userCountFromJson)
      num userCount});
}

/// @nodoc
class _$EESUpoolSettingsCopyWithImpl<$Res, $Val extends EESUpoolSettings>
    implements $EESUpoolSettingsCopyWith<$Res> {
  _$EESUpoolSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EESUpoolSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? minimumOrderValue = freezed,
    Object? adminOrderCount = freezed,
    Object? dailyClosingOrderTime = freezed,
    Object? eesupoolId = null,
    Object? userCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minimumOrderValue: freezed == minimumOrderValue
          ? _value.minimumOrderValue
          : minimumOrderValue // ignore: cast_nullable_to_non_nullable
              as double?,
      adminOrderCount: freezed == adminOrderCount
          ? _value.adminOrderCount
          : adminOrderCount // ignore: cast_nullable_to_non_nullable
              as int?,
      dailyClosingOrderTime: freezed == dailyClosingOrderTime
          ? _value.dailyClosingOrderTime
          : dailyClosingOrderTime // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      userCount: null == userCount
          ? _value.userCount
          : userCount // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EESUpoolSettingsImplCopyWith<$Res>
    implements $EESUpoolSettingsCopyWith<$Res> {
  factory _$$EESUpoolSettingsImplCopyWith(_$EESUpoolSettingsImpl value,
          $Res Function(_$EESUpoolSettingsImpl) then) =
      __$$EESUpoolSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'minimum_order_value') double? minimumOrderValue,
      @JsonKey(name: 'admin_order_count') int? adminOrderCount,
      @JsonKey(name: 'daily_closing_order_time') String? dailyClosingOrderTime,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'user_count', fromJson: _userCountFromJson)
      num userCount});
}

/// @nodoc
class __$$EESUpoolSettingsImplCopyWithImpl<$Res>
    extends _$EESUpoolSettingsCopyWithImpl<$Res, _$EESUpoolSettingsImpl>
    implements _$$EESUpoolSettingsImplCopyWith<$Res> {
  __$$EESUpoolSettingsImplCopyWithImpl(_$EESUpoolSettingsImpl _value,
      $Res Function(_$EESUpoolSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of EESUpoolSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? minimumOrderValue = freezed,
    Object? adminOrderCount = freezed,
    Object? dailyClosingOrderTime = freezed,
    Object? eesupoolId = null,
    Object? userCount = null,
  }) {
    return _then(_$EESUpoolSettingsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minimumOrderValue: freezed == minimumOrderValue
          ? _value.minimumOrderValue
          : minimumOrderValue // ignore: cast_nullable_to_non_nullable
              as double?,
      adminOrderCount: freezed == adminOrderCount
          ? _value.adminOrderCount
          : adminOrderCount // ignore: cast_nullable_to_non_nullable
              as int?,
      dailyClosingOrderTime: freezed == dailyClosingOrderTime
          ? _value.dailyClosingOrderTime
          : dailyClosingOrderTime // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      userCount: null == userCount
          ? _value.userCount
          : userCount // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EESUpoolSettingsImpl extends _EESUpoolSettings {
  const _$EESUpoolSettingsImpl(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'minimum_order_value') this.minimumOrderValue,
      @JsonKey(name: 'admin_order_count') this.adminOrderCount,
      @JsonKey(name: 'daily_closing_order_time') this.dailyClosingOrderTime,
      @JsonKey(name: 'eesupool_id') required this.eesupoolId,
      @JsonKey(name: 'user_count', fromJson: _userCountFromJson)
      required this.userCount})
      : super._();

  factory _$EESUpoolSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$EESUpoolSettingsImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int id;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'minimum_order_value')
  final double? minimumOrderValue;
  @override
  @JsonKey(name: 'admin_order_count')
  final int? adminOrderCount;
  @override
  @JsonKey(name: 'daily_closing_order_time')
  final String? dailyClosingOrderTime;
  @override
  @JsonKey(name: 'eesupool_id')
  final int eesupoolId;
  @override
  @JsonKey(name: 'user_count', fromJson: _userCountFromJson)
  final num userCount;

  @override
  String toString() {
    return 'EESUpoolSettings(id: $id, createdAt: $createdAt, minimumOrderValue: $minimumOrderValue, adminOrderCount: $adminOrderCount, dailyClosingOrderTime: $dailyClosingOrderTime, eesupoolId: $eesupoolId, userCount: $userCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EESUpoolSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.minimumOrderValue, minimumOrderValue) ||
                other.minimumOrderValue == minimumOrderValue) &&
            (identical(other.adminOrderCount, adminOrderCount) ||
                other.adminOrderCount == adminOrderCount) &&
            (identical(other.dailyClosingOrderTime, dailyClosingOrderTime) ||
                other.dailyClosingOrderTime == dailyClosingOrderTime) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.userCount, userCount) ||
                other.userCount == userCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, minimumOrderValue,
      adminOrderCount, dailyClosingOrderTime, eesupoolId, userCount);

  /// Create a copy of EESUpoolSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EESUpoolSettingsImplCopyWith<_$EESUpoolSettingsImpl> get copyWith =>
      __$$EESUpoolSettingsImplCopyWithImpl<_$EESUpoolSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EESUpoolSettingsImplToJson(
      this,
    );
  }
}

abstract class _EESUpoolSettings extends EESUpoolSettings {
  const factory _EESUpoolSettings(
      {@JsonKey(includeToJson: false) required final int id,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'minimum_order_value') final double? minimumOrderValue,
      @JsonKey(name: 'admin_order_count') final int? adminOrderCount,
      @JsonKey(name: 'daily_closing_order_time')
      final String? dailyClosingOrderTime,
      @JsonKey(name: 'eesupool_id') required final int eesupoolId,
      @JsonKey(name: 'user_count', fromJson: _userCountFromJson)
      required final num userCount}) = _$EESUpoolSettingsImpl;
  const _EESUpoolSettings._() : super._();

  factory _EESUpoolSettings.fromJson(Map<String, dynamic> json) =
      _$EESUpoolSettingsImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int get id;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'minimum_order_value')
  double? get minimumOrderValue;
  @override
  @JsonKey(name: 'admin_order_count')
  int? get adminOrderCount;
  @override
  @JsonKey(name: 'daily_closing_order_time')
  String? get dailyClosingOrderTime;
  @override
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @override
  @JsonKey(name: 'user_count', fromJson: _userCountFromJson)
  num get userCount;

  /// Create a copy of EESUpoolSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EESUpoolSettingsImplCopyWith<_$EESUpoolSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
