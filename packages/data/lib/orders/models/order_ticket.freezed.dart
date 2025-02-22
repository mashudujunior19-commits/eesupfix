// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderTicket _$OrderTicketFromJson(Map<String, dynamic> json) {
  return _OrderTicket.fromJson(json);
}

/// @nodoc
mixin _$OrderTicket {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id')
  int get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_comment')
  String? get customerComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupreneur_comment')
  String? get eesupreneurComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_missing')
  bool get itemsMissing => throw _privateConstructorUsedError;
  @OrderProductConverter()
  List<OrderProduct> get products => throw _privateConstructorUsedError;
  @MediaFileConverter()
  List<MediaFile> get attachments => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupreneur_confirmed_at')
  DateTime? get eesupreneurConfirmedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_confirmed_at')
  DateTime? get customerConfirmedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesup_confirmed_at')
  DateTime? get eesupConfirmedAt => throw _privateConstructorUsedError;
  @TicketResolutionTypeConverter()
  TicketResolutionType get resolution => throw _privateConstructorUsedError;

  /// Serializes this OrderTicket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderTicketCopyWith<OrderTicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTicketCopyWith<$Res> {
  factory $OrderTicketCopyWith(
          OrderTicket value, $Res Function(OrderTicket) then) =
      _$OrderTicketCopyWithImpl<$Res, OrderTicket>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: 'order_id') int orderId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'customer_comment') String? customerComment,
      @JsonKey(name: 'eesupreneur_comment') String? eesupreneurComment,
      @JsonKey(name: 'items_missing') bool itemsMissing,
      @OrderProductConverter() List<OrderProduct> products,
      @MediaFileConverter() List<MediaFile> attachments,
      @JsonKey(name: 'eesupreneur_confirmed_at')
      DateTime? eesupreneurConfirmedAt,
      @JsonKey(name: 'customer_confirmed_at') DateTime? customerConfirmedAt,
      @JsonKey(name: 'eesup_confirmed_at') DateTime? eesupConfirmedAt,
      @TicketResolutionTypeConverter() TicketResolutionType resolution});
}

/// @nodoc
class _$OrderTicketCopyWithImpl<$Res, $Val extends OrderTicket>
    implements $OrderTicketCopyWith<$Res> {
  _$OrderTicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderTicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orderId = null,
    Object? createdAt = null,
    Object? customerComment = freezed,
    Object? eesupreneurComment = freezed,
    Object? itemsMissing = null,
    Object? products = null,
    Object? attachments = null,
    Object? eesupreneurConfirmedAt = freezed,
    Object? customerConfirmedAt = freezed,
    Object? eesupConfirmedAt = freezed,
    Object? resolution = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customerComment: freezed == customerComment
          ? _value.customerComment
          : customerComment // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupreneurComment: freezed == eesupreneurComment
          ? _value.eesupreneurComment
          : eesupreneurComment // ignore: cast_nullable_to_non_nullable
              as String?,
      itemsMissing: null == itemsMissing
          ? _value.itemsMissing
          : itemsMissing // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderProduct>,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>,
      eesupreneurConfirmedAt: freezed == eesupreneurConfirmedAt
          ? _value.eesupreneurConfirmedAt
          : eesupreneurConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customerConfirmedAt: freezed == customerConfirmedAt
          ? _value.customerConfirmedAt
          : customerConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eesupConfirmedAt: freezed == eesupConfirmedAt
          ? _value.eesupConfirmedAt
          : eesupConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as TicketResolutionType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderTicketImplCopyWith<$Res>
    implements $OrderTicketCopyWith<$Res> {
  factory _$$OrderTicketImplCopyWith(
          _$OrderTicketImpl value, $Res Function(_$OrderTicketImpl) then) =
      __$$OrderTicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: 'order_id') int orderId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'customer_comment') String? customerComment,
      @JsonKey(name: 'eesupreneur_comment') String? eesupreneurComment,
      @JsonKey(name: 'items_missing') bool itemsMissing,
      @OrderProductConverter() List<OrderProduct> products,
      @MediaFileConverter() List<MediaFile> attachments,
      @JsonKey(name: 'eesupreneur_confirmed_at')
      DateTime? eesupreneurConfirmedAt,
      @JsonKey(name: 'customer_confirmed_at') DateTime? customerConfirmedAt,
      @JsonKey(name: 'eesup_confirmed_at') DateTime? eesupConfirmedAt,
      @TicketResolutionTypeConverter() TicketResolutionType resolution});
}

/// @nodoc
class __$$OrderTicketImplCopyWithImpl<$Res>
    extends _$OrderTicketCopyWithImpl<$Res, _$OrderTicketImpl>
    implements _$$OrderTicketImplCopyWith<$Res> {
  __$$OrderTicketImplCopyWithImpl(
      _$OrderTicketImpl _value, $Res Function(_$OrderTicketImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderTicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orderId = null,
    Object? createdAt = null,
    Object? customerComment = freezed,
    Object? eesupreneurComment = freezed,
    Object? itemsMissing = null,
    Object? products = null,
    Object? attachments = null,
    Object? eesupreneurConfirmedAt = freezed,
    Object? customerConfirmedAt = freezed,
    Object? eesupConfirmedAt = freezed,
    Object? resolution = null,
  }) {
    return _then(_$OrderTicketImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customerComment: freezed == customerComment
          ? _value.customerComment
          : customerComment // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupreneurComment: freezed == eesupreneurComment
          ? _value.eesupreneurComment
          : eesupreneurComment // ignore: cast_nullable_to_non_nullable
              as String?,
      itemsMissing: null == itemsMissing
          ? _value.itemsMissing
          : itemsMissing // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderProduct>,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>,
      eesupreneurConfirmedAt: freezed == eesupreneurConfirmedAt
          ? _value.eesupreneurConfirmedAt
          : eesupreneurConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customerConfirmedAt: freezed == customerConfirmedAt
          ? _value.customerConfirmedAt
          : customerConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eesupConfirmedAt: freezed == eesupConfirmedAt
          ? _value.eesupConfirmedAt
          : eesupConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as TicketResolutionType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderTicketImpl implements _OrderTicket {
  const _$OrderTicketImpl(
      {@JsonKey(includeToJson: false) this.id,
      @JsonKey(name: 'order_id') required this.orderId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'customer_comment') this.customerComment,
      @JsonKey(name: 'eesupreneur_comment') this.eesupreneurComment,
      @JsonKey(name: 'items_missing') required this.itemsMissing,
      @OrderProductConverter() required final List<OrderProduct> products,
      @MediaFileConverter() final List<MediaFile> attachments = const [],
      @JsonKey(name: 'eesupreneur_confirmed_at') this.eesupreneurConfirmedAt,
      @JsonKey(name: 'customer_confirmed_at') this.customerConfirmedAt,
      @JsonKey(name: 'eesup_confirmed_at') this.eesupConfirmedAt,
      @TicketResolutionTypeConverter() required this.resolution})
      : _products = products,
        _attachments = attachments;

  factory _$OrderTicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderTicketImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: 'order_id')
  final int orderId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'customer_comment')
  final String? customerComment;
  @override
  @JsonKey(name: 'eesupreneur_comment')
  final String? eesupreneurComment;
  @override
  @JsonKey(name: 'items_missing')
  final bool itemsMissing;
  final List<OrderProduct> _products;
  @override
  @OrderProductConverter()
  List<OrderProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<MediaFile> _attachments;
  @override
  @JsonKey()
  @MediaFileConverter()
  List<MediaFile> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  @JsonKey(name: 'eesupreneur_confirmed_at')
  final DateTime? eesupreneurConfirmedAt;
  @override
  @JsonKey(name: 'customer_confirmed_at')
  final DateTime? customerConfirmedAt;
  @override
  @JsonKey(name: 'eesup_confirmed_at')
  final DateTime? eesupConfirmedAt;
  @override
  @TicketResolutionTypeConverter()
  final TicketResolutionType resolution;

  @override
  String toString() {
    return 'OrderTicket(id: $id, orderId: $orderId, createdAt: $createdAt, customerComment: $customerComment, eesupreneurComment: $eesupreneurComment, itemsMissing: $itemsMissing, products: $products, attachments: $attachments, eesupreneurConfirmedAt: $eesupreneurConfirmedAt, customerConfirmedAt: $customerConfirmedAt, eesupConfirmedAt: $eesupConfirmedAt, resolution: $resolution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderTicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.customerComment, customerComment) ||
                other.customerComment == customerComment) &&
            (identical(other.eesupreneurComment, eesupreneurComment) ||
                other.eesupreneurComment == eesupreneurComment) &&
            (identical(other.itemsMissing, itemsMissing) ||
                other.itemsMissing == itemsMissing) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.eesupreneurConfirmedAt, eesupreneurConfirmedAt) ||
                other.eesupreneurConfirmedAt == eesupreneurConfirmedAt) &&
            (identical(other.customerConfirmedAt, customerConfirmedAt) ||
                other.customerConfirmedAt == customerConfirmedAt) &&
            (identical(other.eesupConfirmedAt, eesupConfirmedAt) ||
                other.eesupConfirmedAt == eesupConfirmedAt) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderId,
      createdAt,
      customerComment,
      eesupreneurComment,
      itemsMissing,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_attachments),
      eesupreneurConfirmedAt,
      customerConfirmedAt,
      eesupConfirmedAt,
      resolution);

  /// Create a copy of OrderTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderTicketImplCopyWith<_$OrderTicketImpl> get copyWith =>
      __$$OrderTicketImplCopyWithImpl<_$OrderTicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderTicketImplToJson(
      this,
    );
  }
}

abstract class _OrderTicket implements OrderTicket {
  const factory _OrderTicket(
      {@JsonKey(includeToJson: false) final int? id,
      @JsonKey(name: 'order_id') required final int orderId,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'customer_comment') final String? customerComment,
      @JsonKey(name: 'eesupreneur_comment') final String? eesupreneurComment,
      @JsonKey(name: 'items_missing') required final bool itemsMissing,
      @OrderProductConverter() required final List<OrderProduct> products,
      @MediaFileConverter() final List<MediaFile> attachments,
      @JsonKey(name: 'eesupreneur_confirmed_at')
      final DateTime? eesupreneurConfirmedAt,
      @JsonKey(name: 'customer_confirmed_at')
      final DateTime? customerConfirmedAt,
      @JsonKey(name: 'eesup_confirmed_at') final DateTime? eesupConfirmedAt,
      @TicketResolutionTypeConverter()
      required final TicketResolutionType resolution}) = _$OrderTicketImpl;

  factory _OrderTicket.fromJson(Map<String, dynamic> json) =
      _$OrderTicketImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: 'order_id')
  int get orderId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'customer_comment')
  String? get customerComment;
  @override
  @JsonKey(name: 'eesupreneur_comment')
  String? get eesupreneurComment;
  @override
  @JsonKey(name: 'items_missing')
  bool get itemsMissing;
  @override
  @OrderProductConverter()
  List<OrderProduct> get products;
  @override
  @MediaFileConverter()
  List<MediaFile> get attachments;
  @override
  @JsonKey(name: 'eesupreneur_confirmed_at')
  DateTime? get eesupreneurConfirmedAt;
  @override
  @JsonKey(name: 'customer_confirmed_at')
  DateTime? get customerConfirmedAt;
  @override
  @JsonKey(name: 'eesup_confirmed_at')
  DateTime? get eesupConfirmedAt;
  @override
  @TicketResolutionTypeConverter()
  TicketResolutionType get resolution;

  /// Create a copy of OrderTicket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderTicketImplCopyWith<_$OrderTicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
