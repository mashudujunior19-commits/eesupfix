// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hamper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hamper {
  String get id;
  @JsonKey(name: 'code')
  String get hamperCode;
  String get type;
  double get value;
  @JsonKey(name: 'expiry_date')
  DateTime get expiryDate;
  @JsonKey(name: 'is_final')
  bool get isFinal;
  List<int>? get productIds;
  @JsonKey(name: 'img_url')
  String? get imgUrl;
  @JsonKey(name: 'hamper_gif_url1')
  String? get gifUrl1;
  @JsonKey(name: 'profit_allocation_id')
  int? get profitAllocationId;
  @JsonKey(name: 'hamper_gif_url2')
  String? get gifUrl2;
  @JsonKey(name: 'customer_type')
  String? get customerType;
  bool? get isFree;
  Map<int, int>? get quantity;

  /// Create a copy of Hamper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HamperCopyWith<Hamper> get copyWith =>
      _$HamperCopyWithImpl<Hamper>(this as Hamper, _$identity);

  /// Serializes this Hamper to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Hamper &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hamperCode, hamperCode) ||
                other.hamperCode == hamperCode) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.isFinal, isFinal) || other.isFinal == isFinal) &&
            const DeepCollectionEquality()
                .equals(other.productIds, productIds) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl) &&
            (identical(other.gifUrl1, gifUrl1) || other.gifUrl1 == gifUrl1) &&
            (identical(other.profitAllocationId, profitAllocationId) ||
                other.profitAllocationId == profitAllocationId) &&
            (identical(other.gifUrl2, gifUrl2) || other.gifUrl2 == gifUrl2) &&
            (identical(other.customerType, customerType) ||
                other.customerType == customerType) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            const DeepCollectionEquality().equals(other.quantity, quantity));
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
      const DeepCollectionEquality().hash(productIds),
      imgUrl,
      gifUrl1,
      profitAllocationId,
      gifUrl2,
      customerType,
      isFree,
      const DeepCollectionEquality().hash(quantity));

  @override
  String toString() {
    return 'Hamper(id: $id, hamperCode: $hamperCode, type: $type, value: $value, expiryDate: $expiryDate, isFinal: $isFinal, productIds: $productIds, imgUrl: $imgUrl, gifUrl1: $gifUrl1, profitAllocationId: $profitAllocationId, gifUrl2: $gifUrl2, customerType: $customerType, isFree: $isFree, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class $HamperCopyWith<$Res> {
  factory $HamperCopyWith(Hamper value, $Res Function(Hamper) _then) =
      _$HamperCopyWithImpl;
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
      @JsonKey(name: 'profit_allocation_id') int? profitAllocationId,
      @JsonKey(name: 'hamper_gif_url2') String? gifUrl2,
      @JsonKey(name: 'customer_type') String? customerType,
      bool? isFree,
      Map<int, int>? quantity});
}

/// @nodoc
class _$HamperCopyWithImpl<$Res> implements $HamperCopyWith<$Res> {
  _$HamperCopyWithImpl(this._self, this._then);

  final Hamper _self;
  final $Res Function(Hamper) _then;

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
    Object? profitAllocationId = freezed,
    Object? gifUrl2 = freezed,
    Object? customerType = freezed,
    Object? isFree = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hamperCode: null == hamperCode
          ? _self.hamperCode
          : hamperCode // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      expiryDate: null == expiryDate
          ? _self.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFinal: null == isFinal
          ? _self.isFinal
          : isFinal // ignore: cast_nullable_to_non_nullable
              as bool,
      productIds: freezed == productIds
          ? _self.productIds
          : productIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      imgUrl: freezed == imgUrl
          ? _self.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gifUrl1: freezed == gifUrl1
          ? _self.gifUrl1
          : gifUrl1 // ignore: cast_nullable_to_non_nullable
              as String?,
      profitAllocationId: freezed == profitAllocationId
          ? _self.profitAllocationId
          : profitAllocationId // ignore: cast_nullable_to_non_nullable
              as int?,
      gifUrl2: freezed == gifUrl2
          ? _self.gifUrl2
          : gifUrl2 // ignore: cast_nullable_to_non_nullable
              as String?,
      customerType: freezed == customerType
          ? _self.customerType
          : customerType // ignore: cast_nullable_to_non_nullable
              as String?,
      isFree: freezed == isFree
          ? _self.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as Map<int, int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Hamper implements Hamper {
  _Hamper(
      {required this.id,
      @JsonKey(name: 'code') required this.hamperCode,
      required this.type,
      required this.value,
      @JsonKey(name: 'expiry_date') required this.expiryDate,
      @JsonKey(name: 'is_final') required this.isFinal,
      final List<int>? productIds,
      @JsonKey(name: 'img_url') this.imgUrl,
      @JsonKey(name: 'hamper_gif_url1') this.gifUrl1,
      @JsonKey(name: 'profit_allocation_id') this.profitAllocationId,
      @JsonKey(name: 'hamper_gif_url2') this.gifUrl2,
      @JsonKey(name: 'customer_type') this.customerType,
      this.isFree,
      final Map<int, int>? quantity})
      : _productIds = productIds,
        _quantity = quantity;
  factory _Hamper.fromJson(Map<String, dynamic> json) => _$HamperFromJson(json);

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
  @JsonKey(name: 'profit_allocation_id')
  final int? profitAllocationId;
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

  /// Create a copy of Hamper
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HamperCopyWith<_Hamper> get copyWith =>
      __$HamperCopyWithImpl<_Hamper>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HamperToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Hamper &&
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
            (identical(other.profitAllocationId, profitAllocationId) ||
                other.profitAllocationId == profitAllocationId) &&
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
      profitAllocationId,
      gifUrl2,
      customerType,
      isFree,
      const DeepCollectionEquality().hash(_quantity));

  @override
  String toString() {
    return 'Hamper(id: $id, hamperCode: $hamperCode, type: $type, value: $value, expiryDate: $expiryDate, isFinal: $isFinal, productIds: $productIds, imgUrl: $imgUrl, gifUrl1: $gifUrl1, profitAllocationId: $profitAllocationId, gifUrl2: $gifUrl2, customerType: $customerType, isFree: $isFree, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class _$HamperCopyWith<$Res> implements $HamperCopyWith<$Res> {
  factory _$HamperCopyWith(_Hamper value, $Res Function(_Hamper) _then) =
      __$HamperCopyWithImpl;
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
      @JsonKey(name: 'profit_allocation_id') int? profitAllocationId,
      @JsonKey(name: 'hamper_gif_url2') String? gifUrl2,
      @JsonKey(name: 'customer_type') String? customerType,
      bool? isFree,
      Map<int, int>? quantity});
}

/// @nodoc
class __$HamperCopyWithImpl<$Res> implements _$HamperCopyWith<$Res> {
  __$HamperCopyWithImpl(this._self, this._then);

  final _Hamper _self;
  final $Res Function(_Hamper) _then;

  /// Create a copy of Hamper
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    Object? profitAllocationId = freezed,
    Object? gifUrl2 = freezed,
    Object? customerType = freezed,
    Object? isFree = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_Hamper(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hamperCode: null == hamperCode
          ? _self.hamperCode
          : hamperCode // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      expiryDate: null == expiryDate
          ? _self.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFinal: null == isFinal
          ? _self.isFinal
          : isFinal // ignore: cast_nullable_to_non_nullable
              as bool,
      productIds: freezed == productIds
          ? _self._productIds
          : productIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      imgUrl: freezed == imgUrl
          ? _self.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gifUrl1: freezed == gifUrl1
          ? _self.gifUrl1
          : gifUrl1 // ignore: cast_nullable_to_non_nullable
              as String?,
      profitAllocationId: freezed == profitAllocationId
          ? _self.profitAllocationId
          : profitAllocationId // ignore: cast_nullable_to_non_nullable
              as int?,
      gifUrl2: freezed == gifUrl2
          ? _self.gifUrl2
          : gifUrl2 // ignore: cast_nullable_to_non_nullable
              as String?,
      customerType: freezed == customerType
          ? _self.customerType
          : customerType // ignore: cast_nullable_to_non_nullable
              as String?,
      isFree: freezed == isFree
          ? _self.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _self._quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as Map<int, int>?,
    ));
  }
}

// dart format on
