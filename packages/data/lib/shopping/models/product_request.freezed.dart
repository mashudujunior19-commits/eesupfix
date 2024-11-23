// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductRequest _$ProductRequestFromJson(Map<String, dynamic> json) {
  return _ProductRequest.fromJson(json);
}

/// @nodoc
mixin _$ProductRequest {
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'pack_size')
  String get packSize => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String? get variant => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductRequestCopyWith<ProductRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductRequestCopyWith<$Res> {
  factory $ProductRequestCopyWith(
          ProductRequest value, $Res Function(ProductRequest) then) =
      _$ProductRequestCopyWithImpl<$Res, ProductRequest>;
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
class _$ProductRequestCopyWithImpl<$Res, $Val extends ProductRequest>
    implements $ProductRequestCopyWith<$Res> {
  _$ProductRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      packSize: null == packSize
          ? _value.packSize
          : packSize // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductRequestImplCopyWith<$Res>
    implements $ProductRequestCopyWith<$Res> {
  factory _$$ProductRequestImplCopyWith(_$ProductRequestImpl value,
          $Res Function(_$ProductRequestImpl) then) =
      __$$ProductRequestImplCopyWithImpl<$Res>;
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
class __$$ProductRequestImplCopyWithImpl<$Res>
    extends _$ProductRequestCopyWithImpl<$Res, _$ProductRequestImpl>
    implements _$$ProductRequestImplCopyWith<$Res> {
  __$$ProductRequestImplCopyWithImpl(
      _$ProductRequestImpl _value, $Res Function(_$ProductRequestImpl) _then)
      : super(_value, _then);

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
    return _then(_$ProductRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      packSize: null == packSize
          ? _value.packSize
          : packSize // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductRequestImpl implements _ProductRequest {
  const _$ProductRequestImpl(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at', includeToJson: false) this.createdAt,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'pack_size') required this.packSize,
      required this.type,
      required this.brand,
      this.variant,
      this.quantity});

  factory _$ProductRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductRequestImplFromJson(json);

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

  @override
  String toString() {
    return 'ProductRequest(id: $id, userId: $userId, createdAt: $createdAt, productId: $productId, packSize: $packSize, type: $type, brand: $brand, variant: $variant, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductRequestImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, createdAt, productId,
      packSize, type, brand, variant, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductRequestImplCopyWith<_$ProductRequestImpl> get copyWith =>
      __$$ProductRequestImplCopyWithImpl<_$ProductRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductRequestImplToJson(
      this,
    );
  }
}

abstract class _ProductRequest implements ProductRequest {
  const factory _ProductRequest(
      {@JsonKey(includeToJson: false) required final int id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'created_at', includeToJson: false)
      final DateTime? createdAt,
      @JsonKey(name: 'product_id') final int? productId,
      @JsonKey(name: 'pack_size') required final String packSize,
      required final String type,
      required final String brand,
      final String? variant,
      final int? quantity}) = _$ProductRequestImpl;

  factory _ProductRequest.fromJson(Map<String, dynamic> json) =
      _$ProductRequestImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'pack_size')
  String get packSize;
  @override
  String get type;
  @override
  String get brand;
  @override
  String? get variant;
  @override
  int? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$ProductRequestImplCopyWith<_$ProductRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
