// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EESUpoolSettings {
  @JsonKey(includeToJson: false)
  int get id;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'minimum_order_value')
  double? get minimumOrderValue;
  @JsonKey(name: 'admin_order_count')
  int? get adminOrderCount;
  @JsonKey(name: 'daily_closing_order_time')
  String? get dailyClosingOrderTime;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @JsonKey(name: 'user_count')
  num? get userCount;

  /// Create a copy of EESUpoolSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EESUpoolSettingsCopyWith<EESUpoolSettings> get copyWith =>
      _$EESUpoolSettingsCopyWithImpl<EESUpoolSettings>(
          this as EESUpoolSettings, _$identity);

  /// Serializes this EESUpoolSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EESUpoolSettings &&
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

  @override
  String toString() {
    return 'EESUpoolSettings(id: $id, createdAt: $createdAt, minimumOrderValue: $minimumOrderValue, adminOrderCount: $adminOrderCount, dailyClosingOrderTime: $dailyClosingOrderTime, eesupoolId: $eesupoolId, userCount: $userCount)';
  }
}

/// @nodoc
abstract mixin class $EESUpoolSettingsCopyWith<$Res> {
  factory $EESUpoolSettingsCopyWith(
          EESUpoolSettings value, $Res Function(EESUpoolSettings) _then) =
      _$EESUpoolSettingsCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'minimum_order_value') double? minimumOrderValue,
      @JsonKey(name: 'admin_order_count') int? adminOrderCount,
      @JsonKey(name: 'daily_closing_order_time') String? dailyClosingOrderTime,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'user_count') num? userCount});
}

/// @nodoc
class _$EESUpoolSettingsCopyWithImpl<$Res>
    implements $EESUpoolSettingsCopyWith<$Res> {
  _$EESUpoolSettingsCopyWithImpl(this._self, this._then);

  final EESUpoolSettings _self;
  final $Res Function(EESUpoolSettings) _then;

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
    Object? userCount = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minimumOrderValue: freezed == minimumOrderValue
          ? _self.minimumOrderValue
          : minimumOrderValue // ignore: cast_nullable_to_non_nullable
              as double?,
      adminOrderCount: freezed == adminOrderCount
          ? _self.adminOrderCount
          : adminOrderCount // ignore: cast_nullable_to_non_nullable
              as int?,
      dailyClosingOrderTime: freezed == dailyClosingOrderTime
          ? _self.dailyClosingOrderTime
          : dailyClosingOrderTime // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      userCount: freezed == userCount
          ? _self.userCount
          : userCount // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EESUpoolSettings extends EESUpoolSettings {
  const _EESUpoolSettings(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'minimum_order_value') this.minimumOrderValue,
      @JsonKey(name: 'admin_order_count') this.adminOrderCount,
      @JsonKey(name: 'daily_closing_order_time') this.dailyClosingOrderTime,
      @JsonKey(name: 'eesupool_id') required this.eesupoolId,
      @JsonKey(name: 'user_count') this.userCount})
      : super._();
  factory _EESUpoolSettings.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolSettingsFromJson(json);

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
  @JsonKey(name: 'user_count')
  final num? userCount;

  /// Create a copy of EESUpoolSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EESUpoolSettingsCopyWith<_EESUpoolSettings> get copyWith =>
      __$EESUpoolSettingsCopyWithImpl<_EESUpoolSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EESUpoolSettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EESUpoolSettings &&
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

  @override
  String toString() {
    return 'EESUpoolSettings(id: $id, createdAt: $createdAt, minimumOrderValue: $minimumOrderValue, adminOrderCount: $adminOrderCount, dailyClosingOrderTime: $dailyClosingOrderTime, eesupoolId: $eesupoolId, userCount: $userCount)';
  }
}

/// @nodoc
abstract mixin class _$EESUpoolSettingsCopyWith<$Res>
    implements $EESUpoolSettingsCopyWith<$Res> {
  factory _$EESUpoolSettingsCopyWith(
          _EESUpoolSettings value, $Res Function(_EESUpoolSettings) _then) =
      __$EESUpoolSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'minimum_order_value') double? minimumOrderValue,
      @JsonKey(name: 'admin_order_count') int? adminOrderCount,
      @JsonKey(name: 'daily_closing_order_time') String? dailyClosingOrderTime,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'user_count') num? userCount});
}

/// @nodoc
class __$EESUpoolSettingsCopyWithImpl<$Res>
    implements _$EESUpoolSettingsCopyWith<$Res> {
  __$EESUpoolSettingsCopyWithImpl(this._self, this._then);

  final _EESUpoolSettings _self;
  final $Res Function(_EESUpoolSettings) _then;

  /// Create a copy of EESUpoolSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? minimumOrderValue = freezed,
    Object? adminOrderCount = freezed,
    Object? dailyClosingOrderTime = freezed,
    Object? eesupoolId = null,
    Object? userCount = freezed,
  }) {
    return _then(_EESUpoolSettings(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minimumOrderValue: freezed == minimumOrderValue
          ? _self.minimumOrderValue
          : minimumOrderValue // ignore: cast_nullable_to_non_nullable
              as double?,
      adminOrderCount: freezed == adminOrderCount
          ? _self.adminOrderCount
          : adminOrderCount // ignore: cast_nullable_to_non_nullable
              as int?,
      dailyClosingOrderTime: freezed == dailyClosingOrderTime
          ? _self.dailyClosingOrderTime
          : dailyClosingOrderTime // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      userCount: freezed == userCount
          ? _self.userCount
          : userCount // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

// dart format on
