// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductFilter {
  int get limit => throw _privateConstructorUsedError;
  ProductSortEnums get sort => throw _privateConstructorUsedError;

  /// Create a copy of ProductFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductFilterCopyWith<ProductFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductFilterCopyWith<$Res> {
  factory $ProductFilterCopyWith(
          ProductFilter value, $Res Function(ProductFilter) then) =
      _$ProductFilterCopyWithImpl<$Res, ProductFilter>;
  @useResult
  $Res call({int limit, ProductSortEnums sort});
}

/// @nodoc
class _$ProductFilterCopyWithImpl<$Res, $Val extends ProductFilter>
    implements $ProductFilterCopyWith<$Res> {
  _$ProductFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? sort = null,
  }) {
    return _then(_value.copyWith(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as ProductSortEnums,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductFilterImplCopyWith<$Res>
    implements $ProductFilterCopyWith<$Res> {
  factory _$$ProductFilterImplCopyWith(
          _$ProductFilterImpl value, $Res Function(_$ProductFilterImpl) then) =
      __$$ProductFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int limit, ProductSortEnums sort});
}

/// @nodoc
class __$$ProductFilterImplCopyWithImpl<$Res>
    extends _$ProductFilterCopyWithImpl<$Res, _$ProductFilterImpl>
    implements _$$ProductFilterImplCopyWith<$Res> {
  __$$ProductFilterImplCopyWithImpl(
      _$ProductFilterImpl _value, $Res Function(_$ProductFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? sort = null,
  }) {
    return _then(_$ProductFilterImpl(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as ProductSortEnums,
    ));
  }
}

/// @nodoc

class _$ProductFilterImpl implements _ProductFilter {
  const _$ProductFilterImpl({required this.limit, required this.sort});

  @override
  final int limit;
  @override
  final ProductSortEnums sort;

  @override
  String toString() {
    return 'ProductFilter(limit: $limit, sort: $sort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductFilterImpl &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.sort, sort) || other.sort == sort));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit, sort);

  /// Create a copy of ProductFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductFilterImplCopyWith<_$ProductFilterImpl> get copyWith =>
      __$$ProductFilterImplCopyWithImpl<_$ProductFilterImpl>(this, _$identity);
}

abstract class _ProductFilter implements ProductFilter {
  const factory _ProductFilter(
      {required final int limit,
      required final ProductSortEnums sort}) = _$ProductFilterImpl;

  @override
  int get limit;
  @override
  ProductSortEnums get sort;

  /// Create a copy of ProductFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductFilterImplCopyWith<_$ProductFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
