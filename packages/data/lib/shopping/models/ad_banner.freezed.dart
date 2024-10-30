// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdBanner _$AdBannerFromJson(Map<String, dynamic> json) {
  return _AdBanner.fromJson(json);
}

/// @nodoc
mixin _$AdBanner {
  int get id => throw _privateConstructorUsedError;
  @AdContentConverter()
  List<AdContent> get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdBannerCopyWith<AdBanner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdBannerCopyWith<$Res> {
  factory $AdBannerCopyWith(AdBanner value, $Res Function(AdBanner) then) =
      _$AdBannerCopyWithImpl<$Res, AdBanner>;
  @useResult
  $Res call({int id, @AdContentConverter() List<AdContent> content});
}

/// @nodoc
class _$AdBannerCopyWithImpl<$Res, $Val extends AdBanner>
    implements $AdBannerCopyWith<$Res> {
  _$AdBannerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<AdContent>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdBannerImplCopyWith<$Res>
    implements $AdBannerCopyWith<$Res> {
  factory _$$AdBannerImplCopyWith(
          _$AdBannerImpl value, $Res Function(_$AdBannerImpl) then) =
      __$$AdBannerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, @AdContentConverter() List<AdContent> content});
}

/// @nodoc
class __$$AdBannerImplCopyWithImpl<$Res>
    extends _$AdBannerCopyWithImpl<$Res, _$AdBannerImpl>
    implements _$$AdBannerImplCopyWith<$Res> {
  __$$AdBannerImplCopyWithImpl(
      _$AdBannerImpl _value, $Res Function(_$AdBannerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_$AdBannerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<AdContent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdBannerImpl implements _AdBanner {
  const _$AdBannerImpl(
      {required this.id,
      @AdContentConverter() required final List<AdContent> content})
      : _content = content;

  factory _$AdBannerImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdBannerImplFromJson(json);

  @override
  final int id;
  final List<AdContent> _content;
  @override
  @AdContentConverter()
  List<AdContent> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  String toString() {
    return 'AdBanner(id: $id, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdBannerImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._content, _content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_content));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdBannerImplCopyWith<_$AdBannerImpl> get copyWith =>
      __$$AdBannerImplCopyWithImpl<_$AdBannerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdBannerImplToJson(
      this,
    );
  }
}

abstract class _AdBanner implements AdBanner {
  const factory _AdBanner(
          {required final int id,
          @AdContentConverter() required final List<AdContent> content}) =
      _$AdBannerImpl;

  factory _AdBanner.fromJson(Map<String, dynamic> json) =
      _$AdBannerImpl.fromJson;

  @override
  int get id;
  @override
  @AdContentConverter()
  List<AdContent> get content;
  @override
  @JsonKey(ignore: true)
  _$$AdBannerImplCopyWith<_$AdBannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdContent _$AdContentFromJson(Map<String, dynamic> json) {
  return _AdContent.fromJson(json);
}

/// @nodoc
mixin _$AdContent {
  String get url => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_number')
  int get orderNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdContentCopyWith<AdContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdContentCopyWith<$Res> {
  factory $AdContentCopyWith(AdContent value, $Res Function(AdContent) then) =
      _$AdContentCopyWithImpl<$Res, AdContent>;
  @useResult
  $Res call(
      {String url,
      String type,
      @JsonKey(name: 'order_number') int orderNumber});
}

/// @nodoc
class _$AdContentCopyWithImpl<$Res, $Val extends AdContent>
    implements $AdContentCopyWith<$Res> {
  _$AdContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? orderNumber = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdContentImplCopyWith<$Res>
    implements $AdContentCopyWith<$Res> {
  factory _$$AdContentImplCopyWith(
          _$AdContentImpl value, $Res Function(_$AdContentImpl) then) =
      __$$AdContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String type,
      @JsonKey(name: 'order_number') int orderNumber});
}

/// @nodoc
class __$$AdContentImplCopyWithImpl<$Res>
    extends _$AdContentCopyWithImpl<$Res, _$AdContentImpl>
    implements _$$AdContentImplCopyWith<$Res> {
  __$$AdContentImplCopyWithImpl(
      _$AdContentImpl _value, $Res Function(_$AdContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? orderNumber = null,
  }) {
    return _then(_$AdContentImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdContentImpl implements _AdContent {
  const _$AdContentImpl(
      {required this.url,
      required this.type,
      @JsonKey(name: 'order_number') required this.orderNumber});

  factory _$AdContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdContentImplFromJson(json);

  @override
  final String url;
  @override
  final String type;
  @override
  @JsonKey(name: 'order_number')
  final int orderNumber;

  @override
  String toString() {
    return 'AdContent(url: $url, type: $type, orderNumber: $orderNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdContentImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, type, orderNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdContentImplCopyWith<_$AdContentImpl> get copyWith =>
      __$$AdContentImplCopyWithImpl<_$AdContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdContentImplToJson(
      this,
    );
  }
}

abstract class _AdContent implements AdContent {
  const factory _AdContent(
          {required final String url,
          required final String type,
          @JsonKey(name: 'order_number') required final int orderNumber}) =
      _$AdContentImpl;

  factory _AdContent.fromJson(Map<String, dynamic> json) =
      _$AdContentImpl.fromJson;

  @override
  String get url;
  @override
  String get type;
  @override
  @JsonKey(name: 'order_number')
  int get orderNumber;
  @override
  @JsonKey(ignore: true)
  _$$AdContentImplCopyWith<_$AdContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
