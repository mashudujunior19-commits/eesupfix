// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderTicket {
  @JsonKey(includeToJson: false)
  int? get id;
  @JsonKey(name: 'order_id')
  int get orderId;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'customer_comment')
  String? get customerComment;
  @JsonKey(name: 'eesupreneur_comment')
  String? get eesupreneurComment;
  @JsonKey(name: 'items_missing')
  bool get itemsMissing;
  @OrderProductConverter()
  List<OrderProduct> get products;
  @MediaFileConverter()
  List<MediaFile> get attachments;
  @JsonKey(name: 'eesupreneur_confirmed_at')
  DateTime? get eesupreneurConfirmedAt;
  @JsonKey(name: 'customer_confirmed_at')
  DateTime? get customerConfirmedAt;
  @JsonKey(name: 'eesup_confirmed_at')
  DateTime? get eesupConfirmedAt;
  @TicketResolutionTypeConverter()
  TicketResolutionType get resolution;

  /// Create a copy of OrderTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderTicketCopyWith<OrderTicket> get copyWith =>
      _$OrderTicketCopyWithImpl<OrderTicket>(this as OrderTicket, _$identity);

  /// Serializes this OrderTicket to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderTicket &&
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
            const DeepCollectionEquality().equals(other.products, products) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments) &&
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
      const DeepCollectionEquality().hash(products),
      const DeepCollectionEquality().hash(attachments),
      eesupreneurConfirmedAt,
      customerConfirmedAt,
      eesupConfirmedAt,
      resolution);

  @override
  String toString() {
    return 'OrderTicket(id: $id, orderId: $orderId, createdAt: $createdAt, customerComment: $customerComment, eesupreneurComment: $eesupreneurComment, itemsMissing: $itemsMissing, products: $products, attachments: $attachments, eesupreneurConfirmedAt: $eesupreneurConfirmedAt, customerConfirmedAt: $customerConfirmedAt, eesupConfirmedAt: $eesupConfirmedAt, resolution: $resolution)';
  }
}

/// @nodoc
abstract mixin class $OrderTicketCopyWith<$Res> {
  factory $OrderTicketCopyWith(
          OrderTicket value, $Res Function(OrderTicket) _then) =
      _$OrderTicketCopyWithImpl;
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
class _$OrderTicketCopyWithImpl<$Res> implements $OrderTicketCopyWith<$Res> {
  _$OrderTicketCopyWithImpl(this._self, this._then);

  final OrderTicket _self;
  final $Res Function(OrderTicket) _then;

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
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customerComment: freezed == customerComment
          ? _self.customerComment
          : customerComment // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupreneurComment: freezed == eesupreneurComment
          ? _self.eesupreneurComment
          : eesupreneurComment // ignore: cast_nullable_to_non_nullable
              as String?,
      itemsMissing: null == itemsMissing
          ? _self.itemsMissing
          : itemsMissing // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _self.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderProduct>,
      attachments: null == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>,
      eesupreneurConfirmedAt: freezed == eesupreneurConfirmedAt
          ? _self.eesupreneurConfirmedAt
          : eesupreneurConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customerConfirmedAt: freezed == customerConfirmedAt
          ? _self.customerConfirmedAt
          : customerConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eesupConfirmedAt: freezed == eesupConfirmedAt
          ? _self.eesupConfirmedAt
          : eesupConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as TicketResolutionType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OrderTicket implements OrderTicket {
  const _OrderTicket(
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
  factory _OrderTicket.fromJson(Map<String, dynamic> json) =>
      _$OrderTicketFromJson(json);

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

  /// Create a copy of OrderTicket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderTicketCopyWith<_OrderTicket> get copyWith =>
      __$OrderTicketCopyWithImpl<_OrderTicket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrderTicketToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderTicket &&
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

  @override
  String toString() {
    return 'OrderTicket(id: $id, orderId: $orderId, createdAt: $createdAt, customerComment: $customerComment, eesupreneurComment: $eesupreneurComment, itemsMissing: $itemsMissing, products: $products, attachments: $attachments, eesupreneurConfirmedAt: $eesupreneurConfirmedAt, customerConfirmedAt: $customerConfirmedAt, eesupConfirmedAt: $eesupConfirmedAt, resolution: $resolution)';
  }
}

/// @nodoc
abstract mixin class _$OrderTicketCopyWith<$Res>
    implements $OrderTicketCopyWith<$Res> {
  factory _$OrderTicketCopyWith(
          _OrderTicket value, $Res Function(_OrderTicket) _then) =
      __$OrderTicketCopyWithImpl;
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
class __$OrderTicketCopyWithImpl<$Res> implements _$OrderTicketCopyWith<$Res> {
  __$OrderTicketCopyWithImpl(this._self, this._then);

  final _OrderTicket _self;
  final $Res Function(_OrderTicket) _then;

  /// Create a copy of OrderTicket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_OrderTicket(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customerComment: freezed == customerComment
          ? _self.customerComment
          : customerComment // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupreneurComment: freezed == eesupreneurComment
          ? _self.eesupreneurComment
          : eesupreneurComment // ignore: cast_nullable_to_non_nullable
              as String?,
      itemsMissing: null == itemsMissing
          ? _self.itemsMissing
          : itemsMissing // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _self._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<OrderProduct>,
      attachments: null == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>,
      eesupreneurConfirmedAt: freezed == eesupreneurConfirmedAt
          ? _self.eesupreneurConfirmedAt
          : eesupreneurConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customerConfirmedAt: freezed == customerConfirmedAt
          ? _self.customerConfirmedAt
          : customerConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eesupConfirmedAt: freezed == eesupConfirmedAt
          ? _self.eesupConfirmedAt
          : eesupConfirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as TicketResolutionType,
    ));
  }
}

// dart format on
