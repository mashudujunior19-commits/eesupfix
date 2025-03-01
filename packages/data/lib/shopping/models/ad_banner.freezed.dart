// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdBanner {
  int get id;
  @AdContentConverter()
  List<AdContent> get content;

  /// Create a copy of AdBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AdBannerCopyWith<AdBanner> get copyWith =>
      _$AdBannerCopyWithImpl<AdBanner>(this as AdBanner, _$identity);

  /// Serializes this AdBanner to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AdBanner &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.content, content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(content));

  @override
  String toString() {
    return 'AdBanner(id: $id, content: $content)';
  }
}

/// @nodoc
abstract mixin class $AdBannerCopyWith<$Res> {
  factory $AdBannerCopyWith(AdBanner value, $Res Function(AdBanner) _then) =
      _$AdBannerCopyWithImpl;
  @useResult
  $Res call({int id, @AdContentConverter() List<AdContent> content});
}

/// @nodoc
class _$AdBannerCopyWithImpl<$Res> implements $AdBannerCopyWith<$Res> {
  _$AdBannerCopyWithImpl(this._self, this._then);

  final AdBanner _self;
  final $Res Function(AdBanner) _then;

  /// Create a copy of AdBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<AdContent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AdBanner implements AdBanner {
  const _AdBanner(
      {required this.id,
      @AdContentConverter() required final List<AdContent> content})
      : _content = content;
  factory _AdBanner.fromJson(Map<String, dynamic> json) =>
      _$AdBannerFromJson(json);

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

  /// Create a copy of AdBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AdBannerCopyWith<_AdBanner> get copyWith =>
      __$AdBannerCopyWithImpl<_AdBanner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AdBannerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AdBanner &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._content, _content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_content));

  @override
  String toString() {
    return 'AdBanner(id: $id, content: $content)';
  }
}

/// @nodoc
abstract mixin class _$AdBannerCopyWith<$Res>
    implements $AdBannerCopyWith<$Res> {
  factory _$AdBannerCopyWith(_AdBanner value, $Res Function(_AdBanner) _then) =
      __$AdBannerCopyWithImpl;
  @override
  @useResult
  $Res call({int id, @AdContentConverter() List<AdContent> content});
}

/// @nodoc
class __$AdBannerCopyWithImpl<$Res> implements _$AdBannerCopyWith<$Res> {
  __$AdBannerCopyWithImpl(this._self, this._then);

  final _AdBanner _self;
  final $Res Function(_AdBanner) _then;

  /// Create a copy of AdBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_AdBanner(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _self._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<AdContent>,
    ));
  }
}

/// @nodoc
mixin _$AdContent {
  String get url;
  String get type;
  @JsonKey(name: 'order_number')
  int get orderNumber;

  /// Create a copy of AdContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AdContentCopyWith<AdContent> get copyWith =>
      _$AdContentCopyWithImpl<AdContent>(this as AdContent, _$identity);

  /// Serializes this AdContent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AdContent &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, type, orderNumber);

  @override
  String toString() {
    return 'AdContent(url: $url, type: $type, orderNumber: $orderNumber)';
  }
}

/// @nodoc
abstract mixin class $AdContentCopyWith<$Res> {
  factory $AdContentCopyWith(AdContent value, $Res Function(AdContent) _then) =
      _$AdContentCopyWithImpl;
  @useResult
  $Res call(
      {String url,
      String type,
      @JsonKey(name: 'order_number') int orderNumber});
}

/// @nodoc
class _$AdContentCopyWithImpl<$Res> implements $AdContentCopyWith<$Res> {
  _$AdContentCopyWithImpl(this._self, this._then);

  final AdContent _self;
  final $Res Function(AdContent) _then;

  /// Create a copy of AdContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? orderNumber = null,
  }) {
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _self.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AdContent implements AdContent {
  const _AdContent(
      {required this.url,
      required this.type,
      @JsonKey(name: 'order_number') required this.orderNumber});
  factory _AdContent.fromJson(Map<String, dynamic> json) =>
      _$AdContentFromJson(json);

  @override
  final String url;
  @override
  final String type;
  @override
  @JsonKey(name: 'order_number')
  final int orderNumber;

  /// Create a copy of AdContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AdContentCopyWith<_AdContent> get copyWith =>
      __$AdContentCopyWithImpl<_AdContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AdContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AdContent &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, type, orderNumber);

  @override
  String toString() {
    return 'AdContent(url: $url, type: $type, orderNumber: $orderNumber)';
  }
}

/// @nodoc
abstract mixin class _$AdContentCopyWith<$Res>
    implements $AdContentCopyWith<$Res> {
  factory _$AdContentCopyWith(
          _AdContent value, $Res Function(_AdContent) _then) =
      __$AdContentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String url,
      String type,
      @JsonKey(name: 'order_number') int orderNumber});
}

/// @nodoc
class __$AdContentCopyWithImpl<$Res> implements _$AdContentCopyWith<$Res> {
  __$AdContentCopyWithImpl(this._self, this._then);

  final _AdContent _self;
  final $Res Function(_AdContent) _then;

  /// Create a copy of AdContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? orderNumber = null,
  }) {
    return _then(_AdContent(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _self.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
