// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MediaFile _$MediaFileFromJson(Map<String, dynamic> json) {
  return _MediaFile.fromJson(json);
}

/// @nodoc
mixin _$MediaFile {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this MediaFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaFileCopyWith<MediaFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaFileCopyWith<$Res> {
  factory $MediaFileCopyWith(MediaFile value, $Res Function(MediaFile) then) =
      _$MediaFileCopyWithImpl<$Res, MediaFile>;
  @useResult
  $Res call({String name, String url, String type});
}

/// @nodoc
class _$MediaFileCopyWithImpl<$Res, $Val extends MediaFile>
    implements $MediaFileCopyWith<$Res> {
  _$MediaFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaFileImplCopyWith<$Res>
    implements $MediaFileCopyWith<$Res> {
  factory _$$MediaFileImplCopyWith(
          _$MediaFileImpl value, $Res Function(_$MediaFileImpl) then) =
      __$$MediaFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String url, String type});
}

/// @nodoc
class __$$MediaFileImplCopyWithImpl<$Res>
    extends _$MediaFileCopyWithImpl<$Res, _$MediaFileImpl>
    implements _$$MediaFileImplCopyWith<$Res> {
  __$$MediaFileImplCopyWithImpl(
      _$MediaFileImpl _value, $Res Function(_$MediaFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
    Object? type = null,
  }) {
    return _then(_$MediaFileImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaFileImpl implements _MediaFile {
  const _$MediaFileImpl(
      {required this.name, required this.url, required this.type});

  factory _$MediaFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaFileImplFromJson(json);

  @override
  final String name;
  @override
  final String url;
  @override
  final String type;

  @override
  String toString() {
    return 'MediaFile(name: $name, url: $url, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaFileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url, type);

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaFileImplCopyWith<_$MediaFileImpl> get copyWith =>
      __$$MediaFileImplCopyWithImpl<_$MediaFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaFileImplToJson(
      this,
    );
  }
}

abstract class _MediaFile implements MediaFile {
  const factory _MediaFile(
      {required final String name,
      required final String url,
      required final String type}) = _$MediaFileImpl;

  factory _MediaFile.fromJson(Map<String, dynamic> json) =
      _$MediaFileImpl.fromJson;

  @override
  String get name;
  @override
  String get url;
  @override
  String get type;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaFileImplCopyWith<_$MediaFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
