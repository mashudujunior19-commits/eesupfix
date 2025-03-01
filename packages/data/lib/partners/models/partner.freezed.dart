// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Partner {
  String get id;
  String get title;
  String get description;
  @PartnerSurveyConverter()
  List<PartnerSurvey> get surveys;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @JsonKey(name: 'is_open')
  bool get isOpen;
  @JsonKey(name: 'max_apps')
  int get maxApps;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartnerCopyWith<Partner> get copyWith =>
      _$PartnerCopyWithImpl<Partner>(this as Partner, _$identity);

  /// Serializes this Partner to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Partner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.surveys, surveys) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.maxApps, maxApps) || other.maxApps == maxApps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      const DeepCollectionEquality().hash(surveys), createdAt, isOpen, maxApps);

  @override
  String toString() {
    return 'Partner(id: $id, title: $title, description: $description, surveys: $surveys, createdAt: $createdAt, isOpen: $isOpen, maxApps: $maxApps)';
  }
}

/// @nodoc
abstract mixin class $PartnerCopyWith<$Res> {
  factory $PartnerCopyWith(Partner value, $Res Function(Partner) _then) =
      _$PartnerCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      @PartnerSurveyConverter() List<PartnerSurvey> surveys,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'is_open') bool isOpen,
      @JsonKey(name: 'max_apps') int maxApps});
}

/// @nodoc
class _$PartnerCopyWithImpl<$Res> implements $PartnerCopyWith<$Res> {
  _$PartnerCopyWithImpl(this._self, this._then);

  final Partner _self;
  final $Res Function(Partner) _then;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? surveys = null,
    Object? createdAt = freezed,
    Object? isOpen = null,
    Object? maxApps = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      surveys: null == surveys
          ? _self.surveys
          : surveys // ignore: cast_nullable_to_non_nullable
              as List<PartnerSurvey>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOpen: null == isOpen
          ? _self.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      maxApps: null == maxApps
          ? _self.maxApps
          : maxApps // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Partner implements Partner {
  const _Partner(
      {required this.id,
      required this.title,
      required this.description,
      @PartnerSurveyConverter() required final List<PartnerSurvey> surveys,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'is_open') required this.isOpen,
      @JsonKey(name: 'max_apps') required this.maxApps})
      : _surveys = surveys;
  factory _Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  final List<PartnerSurvey> _surveys;
  @override
  @PartnerSurveyConverter()
  List<PartnerSurvey> get surveys {
    if (_surveys is EqualUnmodifiableListView) return _surveys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_surveys);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'is_open')
  final bool isOpen;
  @override
  @JsonKey(name: 'max_apps')
  final int maxApps;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartnerCopyWith<_Partner> get copyWith =>
      __$PartnerCopyWithImpl<_Partner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PartnerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Partner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._surveys, _surveys) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.maxApps, maxApps) || other.maxApps == maxApps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_surveys),
      createdAt,
      isOpen,
      maxApps);

  @override
  String toString() {
    return 'Partner(id: $id, title: $title, description: $description, surveys: $surveys, createdAt: $createdAt, isOpen: $isOpen, maxApps: $maxApps)';
  }
}

/// @nodoc
abstract mixin class _$PartnerCopyWith<$Res> implements $PartnerCopyWith<$Res> {
  factory _$PartnerCopyWith(_Partner value, $Res Function(_Partner) _then) =
      __$PartnerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      @PartnerSurveyConverter() List<PartnerSurvey> surveys,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'is_open') bool isOpen,
      @JsonKey(name: 'max_apps') int maxApps});
}

/// @nodoc
class __$PartnerCopyWithImpl<$Res> implements _$PartnerCopyWith<$Res> {
  __$PartnerCopyWithImpl(this._self, this._then);

  final _Partner _self;
  final $Res Function(_Partner) _then;

  /// Create a copy of Partner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? surveys = null,
    Object? createdAt = freezed,
    Object? isOpen = null,
    Object? maxApps = null,
  }) {
    return _then(_Partner(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      surveys: null == surveys
          ? _self._surveys
          : surveys // ignore: cast_nullable_to_non_nullable
              as List<PartnerSurvey>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOpen: null == isOpen
          ? _self.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      maxApps: null == maxApps
          ? _self.maxApps
          : maxApps // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
