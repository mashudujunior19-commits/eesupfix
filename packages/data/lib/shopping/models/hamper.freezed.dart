// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hamper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Hamper _$HamperFromJson(Map<String, dynamic> json) {
  return _Hamper.fromJson(json);
}

/// @nodoc
mixin _$Hamper {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'code')
  String get hamperCode => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  DateTime get expiryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_final')
  bool get isFinal => throw _privateConstructorUsedError;
  List<int>? get productIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'img_url')
  String? get imgUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'hamper_gif_url1')
  String? get gifUrl1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'hamper_gif_url2')
  String? get gifUrl2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_type')
  String? get customerType => throw _privateConstructorUsedError;
  bool? get isFree => throw _privateConstructorUsedError;
  Map<int, int>? get quantity => throw _privateConstructorUsedError;

  /// Serializes this Hamper to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Hamper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HamperCopyWith<Hamper> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HamperCopyWith<$Res> {
  factory $HamperCopyWith(Hamper value, $Res Function(Hamper) then) =
      _$HamperCopyWithImpl<$Res, Hamper>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'code') String hamperCode,
      String type,
      double value,
      @JsonKey(name: 'expiry_date') DateTime expiryDate,
      @JsonKey(name: 'is_final') bool isFinal,
      List<int>? productIds,
      @JsonKey(name: 'img_url') String? imgUrl,
      @JsonKey(name: 'hamper_gif_url1') String? gifUrl1,
      @JsonKey(name: 'hamper_gif_url2') String? gifUrl2,
      @JsonKey(name: 'customer_type') String? customerType,
      bool? isFree,
      Map<int, int>? quantity});
}

/// @nodoc
class _$HamperCopyWithImpl<$Res, $Val extends Hamper>
    implements $HamperCopyWith<$Res> {
  _$HamperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Hamper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hamperCode = null,
    Object? type = null,
    Object? value = null,
    Object? expiryDate = null,
    Object? isFinal = null,
    Object? productIds = freezed,
    Object? imgUrl = freezed,
    Object? gifUrl1 = freezed,
    Object? gifUrl2 = freezed,
    Object? customerType = freezed,
    Object? isFree = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hamperCode: null == hamperCode
          ? _value.hamperCode
          : hamperCode // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFinal: null == isFinal
          ? _value.isFinal
          : isFinal // ignore: cast_nullable_to_non_nullable
              as bool,
      productIds: freezed == productIds
          ? _value.productIds
          : productIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gifUrl1: freezed == gifUrl1
          ? _value.gifUrl1
          : gifUrl1 // ignore: cast_nullable_to_non_nullable
              as String?,
      gifUrl2: freezed == gifUrl2
          ? _value.gifUrl2
          : gifUrl2 // ignore: cast_nullable_to_non_nullable
              as String?,
      customerType: freezed == customerType
          ? _value.customerType
          : customerType // ignore: cast_nullable_to_non_nullable
              as String?,
      isFree: freezed == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as Map<int, int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HamperImplCopyWith<$Res> implements $HamperCopyWith<$Res> {
  factory _$$HamperImplCopyWith(
          _$HamperImpl value, $Res Function(_$HamperImpl) then) =
      __$$HamperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'code') String hamperCode,
      String type,
      double value,
      @JsonKey(name: 'expiry_date') DateTime expiryDate,
      @JsonKey(name: 'is_final') bool isFinal,
      List<int>? productIds,
      @JsonKey(name: 'img_url') String? imgUrl,
      @JsonKey(name: 'hamper_gif_url1') String? gifUrl1,
      @JsonKey(name: 'hamper_gif_url2') String? gifUrl2,
      @JsonKey(name: 'customer_type') String? customerType,
      bool? isFree,
      Map<int, int>? quantity});
}

/// @nodoc
class __$$HamperImplCopyWithImpl<$Res>
    extends _$HamperCopyWithImpl<$Res, _$HamperImpl>
    implements _$$HamperImplCopyWith<$Res> {
  __$$HamperImplCopyWithImpl(
      _$HamperImpl _value, $Res Function(_$HamperImpl) _then)
      : super(_value, _then);

  /// Create a copy of Hamper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hamperCode = null,
    Object? type = null,
    Object? value = null,
    Object? expiryDate = null,
    Object? isFinal = null,
    Object? productIds = freezed,
    Object? imgUrl = freezed,
    Object? gifUrl1 = freezed,
    Object? gifUrl2 = freezed,
    Object? customerType = freezed,
    Object? isFree = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$HamperImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hamperCode: null == hamperCode
          ? _value.hamperCode
          : hamperCode // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFinal: null == isFinal
          ? _value.isFinal
          : isFinal // ignore: cast_nullable_to_non_nullable
              as bool,
      productIds: freezed == productIds
          ? _value._productIds
          : productIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gifUrl1: freezed == gifUrl1
          ? _value.gifUrl1
          : gifUrl1 // ignore: cast_nullable_to_non_nullable
              as String?,
      gifUrl2: freezed == gifUrl2
          ? _value.gifUrl2
          : gifUrl2 // ignore: cast_nullable_to_non_nullable
              as String?,
      customerType: freezed == customerType
          ? _value.customerType
          : customerType // ignore: cast_nullable_to_non_nullable
              as String?,
      isFree: freezed == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _value._quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as Map<int, int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HamperImpl implements _Hamper {
  _$HamperImpl(
      {required this.id,
      @JsonKey(name: 'code') required this.hamperCode,
      required this.type,
      required this.value,
      @JsonKey(name: 'expiry_date') required this.expiryDate,
      @JsonKey(name: 'is_final') required this.isFinal,
      final List<int>? productIds,
      @JsonKey(name: 'img_url') this.imgUrl,
      @JsonKey(name: 'hamper_gif_url1') this.gifUrl1,
      @JsonKey(name: 'hamper_gif_url2') this.gifUrl2,
      @JsonKey(name: 'customer_type') this.customerType,
      this.isFree,
      final Map<int, int>? quantity})
      : _productIds = productIds,
        _quantity = quantity;

  factory _$HamperImpl.fromJson(Map<String, dynamic> json) =>
      _$$HamperImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'code')
  final String hamperCode;
  @override
  final String type;
  @override
  final double value;
  @override
  @JsonKey(name: 'expiry_date')
  final DateTime expiryDate;
  @override
  @JsonKey(name: 'is_final')
  final bool isFinal;
  final List<int>? _productIds;
  @override
  List<int>? get productIds {
    final value = _productIds;
    if (value == null) return null;
    if (_productIds is EqualUnmodifiableListView) return _productIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'img_url')
  final String? imgUrl;
  @override
  @JsonKey(name: 'hamper_gif_url1')
  final String? gifUrl1;
  @override
  @JsonKey(name: 'hamper_gif_url2')
  final String? gifUrl2;
  @override
  @JsonKey(name: 'customer_type')
  final String? customerType;
  @override
  final bool? isFree;
  final Map<int, int>? _quantity;
  @override
  Map<int, int>? get quantity {
    final value = _quantity;
    if (value == null) return null;
    if (_quantity is EqualUnmodifiableMapView) return _quantity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Hamper(id: $id, hamperCode: $hamperCode, type: $type, value: $value, expiryDate: $expiryDate, isFinal: $isFinal, productIds: $productIds, imgUrl: $imgUrl, gifUrl1: $gifUrl1, gifUrl2: $gifUrl2, customerType: $customerType, isFree: $isFree, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HamperImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hamperCode, hamperCode) ||
                other.hamperCode == hamperCode) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.isFinal, isFinal) || other.isFinal == isFinal) &&
            const DeepCollectionEquality()
                .equals(other._productIds, _productIds) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl) &&
            (identical(other.gifUrl1, gifUrl1) || other.gifUrl1 == gifUrl1) &&
            (identical(other.gifUrl2, gifUrl2) || other.gifUrl2 == gifUrl2) &&
            (identical(other.customerType, customerType) ||
                other.customerType == customerType) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            const DeepCollectionEquality().equals(other._quantity, _quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hamperCode,
      type,
      value,
      expiryDate,
      isFinal,
      const DeepCollectionEquality().hash(_productIds),
      imgUrl,
      gifUrl1,
      gifUrl2,
      customerType,
      isFree,
      const DeepCollectionEquality().hash(_quantity));

  /// Create a copy of Hamper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HamperImplCopyWith<_$HamperImpl> get copyWith =>
      __$$HamperImplCopyWithImpl<_$HamperImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HamperImplToJson(
      this,
    );
  }
}

abstract class _Hamper implements Hamper {
  factory _Hamper(
      {required final String id,
      @JsonKey(name: 'code') required final String hamperCode,
      required final String type,
      required final double value,
      @JsonKey(name: 'expiry_date') required final DateTime expiryDate,
      @JsonKey(name: 'is_final') required final bool isFinal,
      final List<int>? productIds,
      @JsonKey(name: 'img_url') final String? imgUrl,
      @JsonKey(name: 'hamper_gif_url1') final String? gifUrl1,
      @JsonKey(name: 'hamper_gif_url2') final String? gifUrl2,
      @JsonKey(name: 'customer_type') final String? customerType,
      final bool? isFree,
      final Map<int, int>? quantity}) = _$HamperImpl;

  factory _Hamper.fromJson(Map<String, dynamic> json) = _$HamperImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'code')
  String get hamperCode;
  @override
  String get type;
  @override
  double get value;
  @override
  @JsonKey(name: 'expiry_date')
  DateTime get expiryDate;
  @override
  @JsonKey(name: 'is_final')
  bool get isFinal;
  @override
  List<int>? get productIds;
  @override
  @JsonKey(name: 'img_url')
  String? get imgUrl;
  @override
  @JsonKey(name: 'hamper_gif_url1')
  String? get gifUrl1;
  @override
  @JsonKey(name: 'hamper_gif_url2')
  String? get gifUrl2;
  @override
  @JsonKey(name: 'customer_type')
  String? get customerType;
  @override
  bool? get isFree;
  @override
  Map<int, int>? get quantity;

  /// Create a copy of Hamper
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HamperImplCopyWith<_$HamperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
