// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hamper_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HamperBanner {
  int get id => throw _privateConstructorUsedError;
  @HamperContentConverter()
  List<HamperContent> get content => throw _privateConstructorUsedError;
  String get hamperCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'profit_percentage')
  double get profitPercentage => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'profit_allocation_id')
  int get profitAllocationId => throw _privateConstructorUsedError;

  /// Create a copy of HamperBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HamperBannerCopyWith<HamperBanner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HamperBannerCopyWith<$Res> {
  factory $HamperBannerCopyWith(
          HamperBanner value, $Res Function(HamperBanner) then) =
      _$HamperBannerCopyWithImpl<$Res, HamperBanner>;
  @useResult
  $Res call(
      {int id,
      @HamperContentConverter() List<HamperContent> content,
      String hamperCode,
      @JsonKey(name: 'profit_percentage') double profitPercentage,
      double value,
      @JsonKey(name: 'profit_allocation_id') int profitAllocationId});
}

/// @nodoc
class _$HamperBannerCopyWithImpl<$Res, $Val extends HamperBanner>
    implements $HamperBannerCopyWith<$Res> {
  _$HamperBannerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HamperBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? hamperCode = null,
    Object? profitPercentage = null,
    Object? value = null,
    Object? profitAllocationId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<HamperContent>,
      hamperCode: null == hamperCode
          ? _value.hamperCode
          : hamperCode // ignore: cast_nullable_to_non_nullable
              as String,
      profitPercentage: null == profitPercentage
          ? _value.profitPercentage
          : profitPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      profitAllocationId: null == profitAllocationId
          ? _value.profitAllocationId
          : profitAllocationId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HamperBannerImplCopyWith<$Res>
    implements $HamperBannerCopyWith<$Res> {
  factory _$$HamperBannerImplCopyWith(
          _$HamperBannerImpl value, $Res Function(_$HamperBannerImpl) then) =
      __$$HamperBannerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @HamperContentConverter() List<HamperContent> content,
      String hamperCode,
      @JsonKey(name: 'profit_percentage') double profitPercentage,
      double value,
      @JsonKey(name: 'profit_allocation_id') int profitAllocationId});
}

/// @nodoc
class __$$HamperBannerImplCopyWithImpl<$Res>
    extends _$HamperBannerCopyWithImpl<$Res, _$HamperBannerImpl>
    implements _$$HamperBannerImplCopyWith<$Res> {
  __$$HamperBannerImplCopyWithImpl(
      _$HamperBannerImpl _value, $Res Function(_$HamperBannerImpl) _then)
      : super(_value, _then);

  /// Create a copy of HamperBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? hamperCode = null,
    Object? profitPercentage = null,
    Object? value = null,
    Object? profitAllocationId = null,
  }) {
    return _then(_$HamperBannerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<HamperContent>,
      hamperCode: null == hamperCode
          ? _value.hamperCode
          : hamperCode // ignore: cast_nullable_to_non_nullable
              as String,
      profitPercentage: null == profitPercentage
          ? _value.profitPercentage
          : profitPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      profitAllocationId: null == profitAllocationId
          ? _value.profitAllocationId
          : profitAllocationId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HamperBannerImpl implements _HamperBanner {
  const _$HamperBannerImpl(
      {required this.id,
      @HamperContentConverter() required final List<HamperContent> content,
      required this.hamperCode,
      @JsonKey(name: 'profit_percentage') required this.profitPercentage,
      required this.value,
      @JsonKey(name: 'profit_allocation_id') required this.profitAllocationId})
      : _content = content;

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

  @override
  final String hamperCode;
  @override
  @JsonKey(name: 'profit_percentage')
  final double profitPercentage;
  @override
  final double value;
  @override
  @JsonKey(name: 'profit_allocation_id')
  final int profitAllocationId;

  @override
  String toString() {
    return 'HamperBanner(id: $id, content: $content, hamperCode: $hamperCode, profitPercentage: $profitPercentage, value: $value, profitAllocationId: $profitAllocationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HamperBannerImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.hamperCode, hamperCode) ||
                other.hamperCode == hamperCode) &&
            (identical(other.profitPercentage, profitPercentage) ||
                other.profitPercentage == profitPercentage) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.profitAllocationId, profitAllocationId) ||
                other.profitAllocationId == profitAllocationId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_content),
      hamperCode,
      profitPercentage,
      value,
      profitAllocationId);

  /// Create a copy of HamperBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HamperBannerImplCopyWith<_$HamperBannerImpl> get copyWith =>
      __$$HamperBannerImplCopyWithImpl<_$HamperBannerImpl>(this, _$identity);
}

abstract class _HamperBanner implements HamperBanner {
  const factory _HamperBanner(
      {required final int id,
      @HamperContentConverter() required final List<HamperContent> content,
      required final String hamperCode,
      @JsonKey(name: 'profit_percentage')
      required final double profitPercentage,
      required final double value,
      @JsonKey(name: 'profit_allocation_id')
      required final int profitAllocationId}) = _$HamperBannerImpl;

  @override
  int get id;
  @override
  @HamperContentConverter()
  List<HamperContent> get content;
  @override
  String get hamperCode;
  @override
  @JsonKey(name: 'profit_percentage')
  double get profitPercentage;
  @override
  double get value;
  @override
  @JsonKey(name: 'profit_allocation_id')
  int get profitAllocationId;

  /// Create a copy of HamperBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HamperBannerImplCopyWith<_$HamperBannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HamperContent _$HamperContentFromJson(Map<String, dynamic> json) {
  return _HamperContent.fromJson(json);
}

/// @nodoc
mixin _$HamperContent {
  int get orderNumber => throw _privateConstructorUsedError;
  String get baseImage => throw _privateConstructorUsedError;
  String get gif1 => throw _privateConstructorUsedError;
  String get gif2 => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this HamperContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HamperContentCopyWith<HamperContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HamperContentCopyWith<$Res> {
  factory $HamperContentCopyWith(
          HamperContent value, $Res Function(HamperContent) then) =
      _$HamperContentCopyWithImpl<$Res, HamperContent>;
  @useResult
  $Res call(
      {int orderNumber,
      String baseImage,
      String gif1,
      String gif2,
      String type});
}

/// @nodoc
class _$HamperContentCopyWithImpl<$Res, $Val extends HamperContent>
    implements $HamperContentCopyWith<$Res> {
  _$HamperContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = null,
    Object? baseImage = null,
    Object? gif1 = null,
    Object? gif2 = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      baseImage: null == baseImage
          ? _value.baseImage
          : baseImage // ignore: cast_nullable_to_non_nullable
              as String,
      gif1: null == gif1
          ? _value.gif1
          : gif1 // ignore: cast_nullable_to_non_nullable
              as String,
      gif2: null == gif2
          ? _value.gif2
          : gif2 // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HamperContentImplCopyWith<$Res>
    implements $HamperContentCopyWith<$Res> {
  factory _$$HamperContentImplCopyWith(
          _$HamperContentImpl value, $Res Function(_$HamperContentImpl) then) =
      __$$HamperContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int orderNumber,
      String baseImage,
      String gif1,
      String gif2,
      String type});
}

/// @nodoc
class __$$HamperContentImplCopyWithImpl<$Res>
    extends _$HamperContentCopyWithImpl<$Res, _$HamperContentImpl>
    implements _$$HamperContentImplCopyWith<$Res> {
  __$$HamperContentImplCopyWithImpl(
      _$HamperContentImpl _value, $Res Function(_$HamperContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = null,
    Object? baseImage = null,
    Object? gif1 = null,
    Object? gif2 = null,
    Object? type = null,
  }) {
    return _then(_$HamperContentImpl(
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      baseImage: null == baseImage
          ? _value.baseImage
          : baseImage // ignore: cast_nullable_to_non_nullable
              as String,
      gif1: null == gif1
          ? _value.gif1
          : gif1 // ignore: cast_nullable_to_non_nullable
              as String,
      gif2: null == gif2
          ? _value.gif2
          : gif2 // ignore: cast_nullable_to_non_nullable
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
class _$HamperContentImpl implements _HamperContent {
  const _$HamperContentImpl(
      {required this.orderNumber,
      required this.baseImage,
      required this.gif1,
      required this.gif2,
      required this.type});

  factory _$HamperContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$HamperContentImplFromJson(json);

  @override
  final int orderNumber;
  @override
  final String baseImage;
  @override
  final String gif1;
  @override
  final String gif2;
  @override
  final String type;

  @override
  String toString() {
    return 'HamperContent(orderNumber: $orderNumber, baseImage: $baseImage, gif1: $gif1, gif2: $gif2, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HamperContentImpl &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.baseImage, baseImage) ||
                other.baseImage == baseImage) &&
            (identical(other.gif1, gif1) || other.gif1 == gif1) &&
            (identical(other.gif2, gif2) || other.gif2 == gif2) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, orderNumber, baseImage, gif1, gif2, type);

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HamperContentImplCopyWith<_$HamperContentImpl> get copyWith =>
      __$$HamperContentImplCopyWithImpl<_$HamperContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HamperContentImplToJson(
      this,
    );
  }
}

abstract class _HamperContent implements HamperContent {
  const factory _HamperContent(
      {required final int orderNumber,
      required final String baseImage,
      required final String gif1,
      required final String gif2,
      required final String type}) = _$HamperContentImpl;

  factory _HamperContent.fromJson(Map<String, dynamic> json) =
      _$HamperContentImpl.fromJson;

  @override
  int get orderNumber;
  @override
  String get baseImage;
  @override
  String get gif1;
  @override
  String get gif2;
  @override
  String get type;

  /// Create a copy of HamperContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HamperContentImplCopyWith<_$HamperContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
