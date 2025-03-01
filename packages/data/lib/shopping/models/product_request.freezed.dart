// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductRequest {
  @JsonKey(includeToJson: false)
  int get id;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;
  @JsonKey(name: 'product_id')
  int? get productId;
  @JsonKey(name: 'pack_size')
  String get packSize;
  String get type;
  String get brand;
  String? get variant;
  int? get quantity;

  /// Create a copy of ProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductRequestCopyWith<ProductRequest> get copyWith =>
      _$ProductRequestCopyWithImpl<ProductRequest>(
          this as ProductRequest, _$identity);

  /// Serializes this ProductRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.packSize, packSize) ||
                other.packSize == packSize) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, createdAt, productId,
      packSize, type, brand, variant, quantity);

  @override
  String toString() {
    return 'ProductRequest(id: $id, userId: $userId, createdAt: $createdAt, productId: $productId, packSize: $packSize, type: $type, brand: $brand, variant: $variant, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class $ProductRequestCopyWith<$Res> {
  factory $ProductRequestCopyWith(
          ProductRequest value, $Res Function(ProductRequest) _then) =
      _$ProductRequestCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'pack_size') String packSize,
      String type,
      String brand,
      String? variant,
      int? quantity});
}

/// @nodoc
class _$ProductRequestCopyWithImpl<$Res>
    implements $ProductRequestCopyWith<$Res> {
  _$ProductRequestCopyWithImpl(this._self, this._then);

  final ProductRequest _self;
  final $Res Function(ProductRequest) _then;

  /// Create a copy of ProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? createdAt = freezed,
    Object? productId = freezed,
    Object? packSize = null,
    Object? type = null,
    Object? brand = null,
    Object? variant = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      productId: freezed == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      packSize: null == packSize
          ? _self.packSize
          : packSize // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ProductRequest implements ProductRequest {
  const _ProductRequest(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at', includeToJson: false) this.createdAt,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'pack_size') required this.packSize,
      required this.type,
      required this.brand,
      this.variant,
      this.quantity});
  factory _ProductRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'pack_size')
  final String packSize;
  @override
  final String type;
  @override
  final String brand;
  @override
  final String? variant;
  @override
  final int? quantity;

  /// Create a copy of ProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductRequestCopyWith<_ProductRequest> get copyWith =>
      __$ProductRequestCopyWithImpl<_ProductRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.packSize, packSize) ||
                other.packSize == packSize) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, createdAt, productId,
      packSize, type, brand, variant, quantity);

  @override
  String toString() {
    return 'ProductRequest(id: $id, userId: $userId, createdAt: $createdAt, productId: $productId, packSize: $packSize, type: $type, brand: $brand, variant: $variant, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class _$ProductRequestCopyWith<$Res>
    implements $ProductRequestCopyWith<$Res> {
  factory _$ProductRequestCopyWith(
          _ProductRequest value, $Res Function(_ProductRequest) _then) =
      __$ProductRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'pack_size') String packSize,
      String type,
      String brand,
      String? variant,
      int? quantity});
}

/// @nodoc
class __$ProductRequestCopyWithImpl<$Res>
    implements _$ProductRequestCopyWith<$Res> {
  __$ProductRequestCopyWithImpl(this._self, this._then);

  final _ProductRequest _self;
  final $Res Function(_ProductRequest) _then;

  /// Create a copy of ProductRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? createdAt = freezed,
    Object? productId = freezed,
    Object? packSize = null,
    Object? type = null,
    Object? brand = null,
    Object? variant = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_ProductRequest(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      productId: freezed == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      packSize: null == packSize
          ? _self.packSize
          : packSize // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      variant: freezed == variant
          ? _self.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
