// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EESUpoolEvent {
  @JsonKey(includeToJson: false)
  String get id;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  @JsonKey(name: 'title')
  String get title;
  @JsonKey(name: 'notes')
  String? get notes;
  @JsonKey(name: 'address_id')
  int? get addressId;
  @JsonKey(name: 'start_at')
  DateTime get startAt;
  @JsonKey(name: 'end_at')
  DateTime get endAt;
  @EESUpoolMemberConverter()
  @JsonKey(name: 'attendees', includeToJson: false)
  List<EESUpoolMember>? get attendees;
  @JsonKey(name: 'remote_url')
  String? get remoteUrl;
  @MediaFileConverter()
  List<MediaFile>? get attachments;

  /// Create a copy of EESUpoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EESUpoolEventCopyWith<EESUpoolEvent> get copyWith =>
      _$EESUpoolEventCopyWithImpl<EESUpoolEvent>(
          this as EESUpoolEvent, _$identity);

  /// Serializes this EESUpoolEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EESUpoolEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            const DeepCollectionEquality().equals(other.attendees, attendees) &&
            (identical(other.remoteUrl, remoteUrl) ||
                other.remoteUrl == remoteUrl) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eesupoolId,
      createdAt,
      title,
      notes,
      addressId,
      startAt,
      endAt,
      const DeepCollectionEquality().hash(attendees),
      remoteUrl,
      const DeepCollectionEquality().hash(attachments));

  @override
  String toString() {
    return 'EESUpoolEvent(id: $id, eesupoolId: $eesupoolId, createdAt: $createdAt, title: $title, notes: $notes, addressId: $addressId, startAt: $startAt, endAt: $endAt, attendees: $attendees, remoteUrl: $remoteUrl, attachments: $attachments)';
  }
}

/// @nodoc
abstract mixin class $EESUpoolEventCopyWith<$Res> {
  factory $EESUpoolEventCopyWith(
          EESUpoolEvent value, $Res Function(EESUpoolEvent) _then) =
      _$EESUpoolEventCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'notes') String? notes,
      @JsonKey(name: 'address_id') int? addressId,
      @JsonKey(name: 'start_at') DateTime startAt,
      @JsonKey(name: 'end_at') DateTime endAt,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'attendees', includeToJson: false)
      List<EESUpoolMember>? attendees,
      @JsonKey(name: 'remote_url') String? remoteUrl,
      @MediaFileConverter() List<MediaFile>? attachments});
}

/// @nodoc
class _$EESUpoolEventCopyWithImpl<$Res>
    implements $EESUpoolEventCopyWith<$Res> {
  _$EESUpoolEventCopyWithImpl(this._self, this._then);

  final EESUpoolEvent _self;
  final $Res Function(EESUpoolEvent) _then;

  /// Create a copy of EESUpoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eesupoolId = null,
    Object? createdAt = null,
    Object? title = null,
    Object? notes = freezed,
    Object? addressId = freezed,
    Object? startAt = null,
    Object? endAt = null,
    Object? attendees = freezed,
    Object? remoteUrl = freezed,
    Object? attachments = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      addressId: freezed == addressId
          ? _self.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      startAt: null == startAt
          ? _self.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _self.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attendees: freezed == attendees
          ? _self.attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolMember>?,
      remoteUrl: freezed == remoteUrl
          ? _self.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EESUpoolEvent implements EESUpoolEvent {
  const _EESUpoolEvent(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'eesupool_id') required this.eesupoolId,
      @JsonKey(name: 'created_at', includeToJson: false)
      required this.createdAt,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'notes') this.notes,
      @JsonKey(name: 'address_id') this.addressId,
      @JsonKey(name: 'start_at') required this.startAt,
      @JsonKey(name: 'end_at') required this.endAt,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'attendees', includeToJson: false)
      final List<EESUpoolMember>? attendees,
      @JsonKey(name: 'remote_url') this.remoteUrl,
      @MediaFileConverter() final List<MediaFile>? attachments})
      : _attendees = attendees,
        _attachments = attachments;
  factory _EESUpoolEvent.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolEventFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  @JsonKey(name: 'eesupool_id')
  final int eesupoolId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'notes')
  final String? notes;
  @override
  @JsonKey(name: 'address_id')
  final int? addressId;
  @override
  @JsonKey(name: 'start_at')
  final DateTime startAt;
  @override
  @JsonKey(name: 'end_at')
  final DateTime endAt;
  final List<EESUpoolMember>? _attendees;
  @override
  @EESUpoolMemberConverter()
  @JsonKey(name: 'attendees', includeToJson: false)
  List<EESUpoolMember>? get attendees {
    final value = _attendees;
    if (value == null) return null;
    if (_attendees is EqualUnmodifiableListView) return _attendees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'remote_url')
  final String? remoteUrl;
  final List<MediaFile>? _attachments;
  @override
  @MediaFileConverter()
  List<MediaFile>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of EESUpoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EESUpoolEventCopyWith<_EESUpoolEvent> get copyWith =>
      __$EESUpoolEventCopyWithImpl<_EESUpoolEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EESUpoolEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EESUpoolEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            const DeepCollectionEquality()
                .equals(other._attendees, _attendees) &&
            (identical(other.remoteUrl, remoteUrl) ||
                other.remoteUrl == remoteUrl) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eesupoolId,
      createdAt,
      title,
      notes,
      addressId,
      startAt,
      endAt,
      const DeepCollectionEquality().hash(_attendees),
      remoteUrl,
      const DeepCollectionEquality().hash(_attachments));

  @override
  String toString() {
    return 'EESUpoolEvent(id: $id, eesupoolId: $eesupoolId, createdAt: $createdAt, title: $title, notes: $notes, addressId: $addressId, startAt: $startAt, endAt: $endAt, attendees: $attendees, remoteUrl: $remoteUrl, attachments: $attachments)';
  }
}

/// @nodoc
abstract mixin class _$EESUpoolEventCopyWith<$Res>
    implements $EESUpoolEventCopyWith<$Res> {
  factory _$EESUpoolEventCopyWith(
          _EESUpoolEvent value, $Res Function(_EESUpoolEvent) _then) =
      __$EESUpoolEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'notes') String? notes,
      @JsonKey(name: 'address_id') int? addressId,
      @JsonKey(name: 'start_at') DateTime startAt,
      @JsonKey(name: 'end_at') DateTime endAt,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'attendees', includeToJson: false)
      List<EESUpoolMember>? attendees,
      @JsonKey(name: 'remote_url') String? remoteUrl,
      @MediaFileConverter() List<MediaFile>? attachments});
}

/// @nodoc
class __$EESUpoolEventCopyWithImpl<$Res>
    implements _$EESUpoolEventCopyWith<$Res> {
  __$EESUpoolEventCopyWithImpl(this._self, this._then);

  final _EESUpoolEvent _self;
  final $Res Function(_EESUpoolEvent) _then;

  /// Create a copy of EESUpoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? eesupoolId = null,
    Object? createdAt = null,
    Object? title = null,
    Object? notes = freezed,
    Object? addressId = freezed,
    Object? startAt = null,
    Object? endAt = null,
    Object? attendees = freezed,
    Object? remoteUrl = freezed,
    Object? attachments = freezed,
  }) {
    return _then(_EESUpoolEvent(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      addressId: freezed == addressId
          ? _self.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      startAt: null == startAt
          ? _self.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _self.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attendees: freezed == attendees
          ? _self._attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolMember>?,
      remoteUrl: freezed == remoteUrl
          ? _self.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
    ));
  }
}

// dart format on
