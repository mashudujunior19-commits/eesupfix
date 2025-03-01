// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'version_control.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VersionControl {
  int get id;
  DateTime get createdAt;
  String? get versionNumber;
  int? get buildNumber;
  bool? get isLive;
  String? get appStoreUrl;
  String? get iosUrl;
  String? get huaweiUrl;

  /// Create a copy of VersionControl
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VersionControlCopyWith<VersionControl> get copyWith =>
      _$VersionControlCopyWithImpl<VersionControl>(
          this as VersionControl, _$identity);

  /// Serializes this VersionControl to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VersionControl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.versionNumber, versionNumber) ||
                other.versionNumber == versionNumber) &&
            (identical(other.buildNumber, buildNumber) ||
                other.buildNumber == buildNumber) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.appStoreUrl, appStoreUrl) ||
                other.appStoreUrl == appStoreUrl) &&
            (identical(other.iosUrl, iosUrl) || other.iosUrl == iosUrl) &&
            (identical(other.huaweiUrl, huaweiUrl) ||
                other.huaweiUrl == huaweiUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, versionNumber,
      buildNumber, isLive, appStoreUrl, iosUrl, huaweiUrl);

  @override
  String toString() {
    return 'VersionControl(id: $id, createdAt: $createdAt, versionNumber: $versionNumber, buildNumber: $buildNumber, isLive: $isLive, appStoreUrl: $appStoreUrl, iosUrl: $iosUrl, huaweiUrl: $huaweiUrl)';
  }
}

/// @nodoc
abstract mixin class $VersionControlCopyWith<$Res> {
  factory $VersionControlCopyWith(
          VersionControl value, $Res Function(VersionControl) _then) =
      _$VersionControlCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      String? versionNumber,
      int? buildNumber,
      bool? isLive,
      String? appStoreUrl,
      String? iosUrl,
      String? huaweiUrl});
}

/// @nodoc
class _$VersionControlCopyWithImpl<$Res>
    implements $VersionControlCopyWith<$Res> {
  _$VersionControlCopyWithImpl(this._self, this._then);

  final VersionControl _self;
  final $Res Function(VersionControl) _then;

  /// Create a copy of VersionControl
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? versionNumber = freezed,
    Object? buildNumber = freezed,
    Object? isLive = freezed,
    Object? appStoreUrl = freezed,
    Object? iosUrl = freezed,
    Object? huaweiUrl = freezed,
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
      versionNumber: freezed == versionNumber
          ? _self.versionNumber
          : versionNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      buildNumber: freezed == buildNumber
          ? _self.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      isLive: freezed == isLive
          ? _self.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool?,
      appStoreUrl: freezed == appStoreUrl
          ? _self.appStoreUrl
          : appStoreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iosUrl: freezed == iosUrl
          ? _self.iosUrl
          : iosUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      huaweiUrl: freezed == huaweiUrl
          ? _self.huaweiUrl
          : huaweiUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _VersionControl implements VersionControl {
  const _VersionControl(
      {required this.id,
      required this.createdAt,
      this.versionNumber,
      this.buildNumber,
      this.isLive,
      this.appStoreUrl,
      this.iosUrl,
      this.huaweiUrl});
  factory _VersionControl.fromJson(Map<String, dynamic> json) =>
      _$VersionControlFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final String? versionNumber;
  @override
  final int? buildNumber;
  @override
  final bool? isLive;
  @override
  final String? appStoreUrl;
  @override
  final String? iosUrl;
  @override
  final String? huaweiUrl;

  /// Create a copy of VersionControl
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VersionControlCopyWith<_VersionControl> get copyWith =>
      __$VersionControlCopyWithImpl<_VersionControl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VersionControlToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VersionControl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.versionNumber, versionNumber) ||
                other.versionNumber == versionNumber) &&
            (identical(other.buildNumber, buildNumber) ||
                other.buildNumber == buildNumber) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.appStoreUrl, appStoreUrl) ||
                other.appStoreUrl == appStoreUrl) &&
            (identical(other.iosUrl, iosUrl) || other.iosUrl == iosUrl) &&
            (identical(other.huaweiUrl, huaweiUrl) ||
                other.huaweiUrl == huaweiUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, versionNumber,
      buildNumber, isLive, appStoreUrl, iosUrl, huaweiUrl);

  @override
  String toString() {
    return 'VersionControl(id: $id, createdAt: $createdAt, versionNumber: $versionNumber, buildNumber: $buildNumber, isLive: $isLive, appStoreUrl: $appStoreUrl, iosUrl: $iosUrl, huaweiUrl: $huaweiUrl)';
  }
}

/// @nodoc
abstract mixin class _$VersionControlCopyWith<$Res>
    implements $VersionControlCopyWith<$Res> {
  factory _$VersionControlCopyWith(
          _VersionControl value, $Res Function(_VersionControl) _then) =
      __$VersionControlCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      String? versionNumber,
      int? buildNumber,
      bool? isLive,
      String? appStoreUrl,
      String? iosUrl,
      String? huaweiUrl});
}

/// @nodoc
class __$VersionControlCopyWithImpl<$Res>
    implements _$VersionControlCopyWith<$Res> {
  __$VersionControlCopyWithImpl(this._self, this._then);

  final _VersionControl _self;
  final $Res Function(_VersionControl) _then;

  /// Create a copy of VersionControl
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? versionNumber = freezed,
    Object? buildNumber = freezed,
    Object? isLive = freezed,
    Object? appStoreUrl = freezed,
    Object? iosUrl = freezed,
    Object? huaweiUrl = freezed,
  }) {
    return _then(_VersionControl(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      versionNumber: freezed == versionNumber
          ? _self.versionNumber
          : versionNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      buildNumber: freezed == buildNumber
          ? _self.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      isLive: freezed == isLive
          ? _self.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool?,
      appStoreUrl: freezed == appStoreUrl
          ? _self.appStoreUrl
          : appStoreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iosUrl: freezed == iosUrl
          ? _self.iosUrl
          : iosUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      huaweiUrl: freezed == huaweiUrl
          ? _self.huaweiUrl
          : huaweiUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
