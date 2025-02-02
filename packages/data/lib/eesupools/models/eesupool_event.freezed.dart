// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EESUpoolEvent _$EESUpoolEventFromJson(Map<String, dynamic> json) {
  return _EESUpoolEvent.fromJson(json);
}

/// @nodoc
mixin _$EESUpoolEvent {
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'notes')
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_id')
  int? get addressId => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_at')
  DateTime get startAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_at')
  DateTime get endAt => throw _privateConstructorUsedError;
  @EESUpoolMemberConverter()
  @JsonKey(name: 'attendees', includeToJson: false)
  List<EESUpoolMember>? get attendees => throw _privateConstructorUsedError;
  @JsonKey(name: 'remote_url')
  String? get remoteUrl => throw _privateConstructorUsedError;
  @MediaFileConverter()
  List<MediaFile>? get attachments => throw _privateConstructorUsedError;

  /// Serializes this EESUpoolEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EESUpoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EESUpoolEventCopyWith<EESUpoolEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EESUpoolEventCopyWith<$Res> {
  factory $EESUpoolEventCopyWith(
          EESUpoolEvent value, $Res Function(EESUpoolEvent) then) =
      _$EESUpoolEventCopyWithImpl<$Res, EESUpoolEvent>;
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
class _$EESUpoolEventCopyWithImpl<$Res, $Val extends EESUpoolEvent>
    implements $EESUpoolEventCopyWith<$Res> {
  _$EESUpoolEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attendees: freezed == attendees
          ? _value.attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolMember>?,
      remoteUrl: freezed == remoteUrl
          ? _value.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EESUpoolEventImplCopyWith<$Res>
    implements $EESUpoolEventCopyWith<$Res> {
  factory _$$EESUpoolEventImplCopyWith(
          _$EESUpoolEventImpl value, $Res Function(_$EESUpoolEventImpl) then) =
      __$$EESUpoolEventImplCopyWithImpl<$Res>;
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
class __$$EESUpoolEventImplCopyWithImpl<$Res>
    extends _$EESUpoolEventCopyWithImpl<$Res, _$EESUpoolEventImpl>
    implements _$$EESUpoolEventImplCopyWith<$Res> {
  __$$EESUpoolEventImplCopyWithImpl(
      _$EESUpoolEventImpl _value, $Res Function(_$EESUpoolEventImpl) _then)
      : super(_value, _then);

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
    return _then(_$EESUpoolEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attendees: freezed == attendees
          ? _value._attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolMember>?,
      remoteUrl: freezed == remoteUrl
          ? _value.remoteUrl
          : remoteUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EESUpoolEventImpl implements _EESUpoolEvent {
  const _$EESUpoolEventImpl(
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

  factory _$EESUpoolEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EESUpoolEventImplFromJson(json);

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

  @override
  String toString() {
    return 'EESUpoolEvent(id: $id, eesupoolId: $eesupoolId, createdAt: $createdAt, title: $title, notes: $notes, addressId: $addressId, startAt: $startAt, endAt: $endAt, attendees: $attendees, remoteUrl: $remoteUrl, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EESUpoolEventImpl &&
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

  /// Create a copy of EESUpoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EESUpoolEventImplCopyWith<_$EESUpoolEventImpl> get copyWith =>
      __$$EESUpoolEventImplCopyWithImpl<_$EESUpoolEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EESUpoolEventImplToJson(
      this,
    );
  }
}

abstract class _EESUpoolEvent implements EESUpoolEvent {
  const factory _EESUpoolEvent(
          {@JsonKey(includeToJson: false) required final String id,
          @JsonKey(name: 'eesupool_id') required final int eesupoolId,
          @JsonKey(name: 'created_at', includeToJson: false)
          required final DateTime createdAt,
          @JsonKey(name: 'title') required final String title,
          @JsonKey(name: 'notes') final String? notes,
          @JsonKey(name: 'address_id') final int? addressId,
          @JsonKey(name: 'start_at') required final DateTime startAt,
          @JsonKey(name: 'end_at') required final DateTime endAt,
          @EESUpoolMemberConverter()
          @JsonKey(name: 'attendees', includeToJson: false)
          final List<EESUpoolMember>? attendees,
          @JsonKey(name: 'remote_url') final String? remoteUrl,
          @MediaFileConverter() final List<MediaFile>? attachments}) =
      _$EESUpoolEventImpl;

  factory _EESUpoolEvent.fromJson(Map<String, dynamic> json) =
      _$EESUpoolEventImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'notes')
  String? get notes;
  @override
  @JsonKey(name: 'address_id')
  int? get addressId;
  @override
  @JsonKey(name: 'start_at')
  DateTime get startAt;
  @override
  @JsonKey(name: 'end_at')
  DateTime get endAt;
  @override
  @EESUpoolMemberConverter()
  @JsonKey(name: 'attendees', includeToJson: false)
  List<EESUpoolMember>? get attendees;
  @override
  @JsonKey(name: 'remote_url')
  String? get remoteUrl;
  @override
  @MediaFileConverter()
  List<MediaFile>? get attachments;

  /// Create a copy of EESUpoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EESUpoolEventImplCopyWith<_$EESUpoolEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
