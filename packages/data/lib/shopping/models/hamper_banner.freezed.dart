// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hamper_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HamperBanner {
  int get id;
  @HamperContentConverter()
  List<HamperContent> get content;

  /// Create a copy of HamperBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HamperBannerCopyWith<HamperBanner> get copyWith =>
      _$HamperBannerCopyWithImpl<HamperBanner>(
          this as HamperBanner, _$identity);

  /// Serializes this HamperBanner to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HamperBanner &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.content, content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(content));

  @override
  String toString() {
    return 'HamperBanner(id: $id, content: $content)';
  }
}

/// @nodoc
abstract mixin class $HamperBannerCopyWith<$Res> {
  factory $HamperBannerCopyWith(
          HamperBanner value, $Res Function(HamperBanner) _then) =
      _$HamperBannerCopyWithImpl;
  @useResult
  $Res call({int id, @HamperContentConverter() List<HamperContent> content});
}

/// @nodoc
class _$HamperBannerCopyWithImpl<$Res> implements $HamperBannerCopyWith<$Res> {
  _$HamperBannerCopyWithImpl(this._self, this._then);

  final HamperBanner _self;
  final $Res Function(HamperBanner) _then;

  /// Create a copy of HamperBanner
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
              as List<HamperContent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _HamperBanner implements HamperBanner {
  const _HamperBanner(
      {required this.id,
      @HamperContentConverter() required final List<HamperContent> content})
      : _content = content;
  factory _HamperBanner.fromJson(Map<String, dynamic> json) =>
      _$HamperBannerFromJson(json);

  @override
  final int id;
  final List<HamperContent> _content;
  @override
  @HamperContentConverter()
  List<HamperContent> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  /// Create a copy of HamperBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HamperBannerCopyWith<_HamperBanner> get copyWith =>
      __$HamperBannerCopyWithImpl<_HamperBanner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HamperBannerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HamperBanner &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._content, _content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_content));

  @override
  String toString() {
    return 'HamperBanner(id: $id, content: $content)';
  }
}

/// @nodoc
abstract mixin class _$HamperBannerCopyWith<$Res>
    implements $HamperBannerCopyWith<$Res> {
  factory _$HamperBannerCopyWith(
          _HamperBanner value, $Res Function(_HamperBanner) _then) =
      __$HamperBannerCopyWithImpl;
  @override
  @useResult
  $Res call({int id, @HamperContentConverter() List<HamperContent> content});
}

/// @nodoc
class __$HamperBannerCopyWithImpl<$Res>
    implements _$HamperBannerCopyWith<$Res> {
  __$HamperBannerCopyWithImpl(this._self, this._then);

  final _HamperBanner _self;
  final $Res Function(_HamperBanner) _then;

  /// Create a copy of HamperBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_HamperBanner(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _self._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<HamperContent>,
    ));
  }
}

/// @nodoc
mixin _$HamperContent {
  String get type;
  @JsonKey(name: 'order_number')
  int get orderNumber;
  @JsonKey(name: 'base_image')
  String get baseImage;
  String get gif1;
  String get gif2;

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HamperContentCopyWith<HamperContent> get copyWith =>
      _$HamperContentCopyWithImpl<HamperContent>(
          this as HamperContent, _$identity);

  /// Serializes this HamperContent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HamperContent &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.baseImage, baseImage) ||
                other.baseImage == baseImage) &&
            (identical(other.gif1, gif1) || other.gif1 == gif1) &&
            (identical(other.gif2, gif2) || other.gif2 == gif2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, orderNumber, baseImage, gif1, gif2);

  @override
  String toString() {
    return 'HamperContent(type: $type, orderNumber: $orderNumber, baseImage: $baseImage, gif1: $gif1, gif2: $gif2)';
  }
}

/// @nodoc
abstract mixin class $HamperContentCopyWith<$Res> {
  factory $HamperContentCopyWith(
          HamperContent value, $Res Function(HamperContent) _then) =
      _$HamperContentCopyWithImpl;
  @useResult
  $Res call(
      {String type,
      @JsonKey(name: 'order_number') int orderNumber,
      @JsonKey(name: 'base_image') String baseImage,
      String gif1,
      String gif2});
}

/// @nodoc
class _$HamperContentCopyWithImpl<$Res>
    implements $HamperContentCopyWith<$Res> {
  _$HamperContentCopyWithImpl(this._self, this._then);

  final HamperContent _self;
  final $Res Function(HamperContent) _then;

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? orderNumber = null,
    Object? baseImage = null,
    Object? gif1 = null,
    Object? gif2 = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _self.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      baseImage: null == baseImage
          ? _self.baseImage
          : baseImage // ignore: cast_nullable_to_non_nullable
              as String,
      gif1: null == gif1
          ? _self.gif1
          : gif1 // ignore: cast_nullable_to_non_nullable
              as String,
      gif2: null == gif2
          ? _self.gif2
          : gif2 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _HamperContent implements HamperContent {
  const _HamperContent(
      {required this.type,
      @JsonKey(name: 'order_number') required this.orderNumber,
      @JsonKey(name: 'base_image') required this.baseImage,
      required this.gif1,
      required this.gif2});
  factory _HamperContent.fromJson(Map<String, dynamic> json) =>
      _$HamperContentFromJson(json);

  @override
  final String type;
  @override
  @JsonKey(name: 'order_number')
  final int orderNumber;
  @override
  @JsonKey(name: 'base_image')
  final String baseImage;
  @override
  final String gif1;
  @override
  final String gif2;

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HamperContentCopyWith<_HamperContent> get copyWith =>
      __$HamperContentCopyWithImpl<_HamperContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HamperContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HamperContent &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.baseImage, baseImage) ||
                other.baseImage == baseImage) &&
            (identical(other.gif1, gif1) || other.gif1 == gif1) &&
            (identical(other.gif2, gif2) || other.gif2 == gif2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, orderNumber, baseImage, gif1, gif2);

  @override
  String toString() {
    return 'HamperContent(type: $type, orderNumber: $orderNumber, baseImage: $baseImage, gif1: $gif1, gif2: $gif2)';
  }
}

/// @nodoc
abstract mixin class _$HamperContentCopyWith<$Res>
    implements $HamperContentCopyWith<$Res> {
  factory _$HamperContentCopyWith(
          _HamperContent value, $Res Function(_HamperContent) _then) =
      __$HamperContentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String type,
      @JsonKey(name: 'order_number') int orderNumber,
      @JsonKey(name: 'base_image') String baseImage,
      String gif1,
      String gif2});
}

/// @nodoc
class __$HamperContentCopyWithImpl<$Res>
    implements _$HamperContentCopyWith<$Res> {
  __$HamperContentCopyWithImpl(this._self, this._then);

  final _HamperContent _self;
  final $Res Function(_HamperContent) _then;

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? orderNumber = null,
    Object? baseImage = null,
    Object? gif1 = null,
    Object? gif2 = null,
  }) {
    return _then(_HamperContent(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _self.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      baseImage: null == baseImage
          ? _self.baseImage
          : baseImage // ignore: cast_nullable_to_non_nullable
              as String,
      gif1: null == gif1
          ? _self.gif1
          : gif1 // ignore: cast_nullable_to_non_nullable
              as String,
      gif2: null == gif2
          ? _self.gif2
          : gif2 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
