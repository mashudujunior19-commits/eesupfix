// ignore_for_file: invalid_annotation_target
import 'package:data/eesupools/kasipool_rules.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/receiver_role.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/orders/models/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eesupool_order.freezed.dart';
part 'eesupool_order.g.dart';

@freezed
abstract class EESUpoolOrder with _$EESUpoolOrder {
  const factory EESUpoolOrder({
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'eesupool_id') required int eesupoolId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'schedule_for') required DateTime scheduleFor,
    @JsonKey(name: 'closes_at') required DateTime closesAt,
    @JsonKey(name: 'secret_pin') int? secretPin,
    @JsonKey(name: 'delivered_at') DateTime? deliveredAt,
    @JsonKey(name: 'admin_fee') double? adminFee,
    @JsonKey(name: 'packer_fee') double? packerFee,
    @JsonKey(name: 'receiver_fee') double? receiverFee,
    @JsonKey(name: 'collection_fee') double? collectionFee,
    @JsonKey(name: 'address_id') int? addressId,
    @JsonKey(name: 'receivers') List<String>? receiversId,

    /// 'Open' or 'Closed' (the database's order status). Read-only here: it is
    /// only changed by the database's close rules, never written back.
    @JsonKey(includeToJson: false) String? status,

    /// How many times the order was extended because it was below the
    /// minimum when its close date passed. Read-only.
    @JsonKey(name: 'order_extension_count', includeToJson: false)
    int? orderExtensionCount,

    /// Maps each bulk receiver's member id to the role the pool admin
    /// assigned them (Receiver / Packer / Distributor), so it's clear who
    /// does what on the order.
    @ReceiverRolesConverter()
    @JsonKey(name: 'receiver_roles')
    @Default({})
    Map<String, ReceiverRole> receiverRoles,

    ///other
    @JsonKey(name: 'eesupool_name', includeToJson: false) String? eesupoolName,
    @EESUpoolMemberConverter()
    @JsonKey(includeToJson: false, includeFromJson: false)
    List<EESUpoolMember>? receivers,
    @AddressConverter() @JsonKey(includeToJson: false) Address? address,
    @JsonKey(name: 'orders_count', includeToJson: false)
    @Default(0)
    int ordersCount,
    @JsonKey(name: 'current_amount', includeToJson: false)
    @Default(0.00)
    double currentAmount,
  }) = _EESUpoolOrder;

  factory EESUpoolOrder.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolOrderFromJson(json);
}

extension EESUpoolOrderRules on EESUpoolOrder {
  /// Closed by the database (or received). Receivers/roles can't change then.
  /// Lists that don't return a status fall back to the closing date.
  bool get isClosed =>
      status == 'Closed' ||
      deliveredAt != null ||
      (status == null && closesAt.isBefore(DateTime.now()));

  /// Whether the order has reached the KasiPool minimum, which an order needs
  /// before it can close (enforced by the database as well).
  bool get meetsMinimum => currentAmount >= minKasipoolOrder;
}

@freezed
abstract class MemberOrderAssignment with _$MemberOrderAssignment {
  const factory MemberOrderAssignment({
    @JsonKey(name: 'order_id') required int orderId,
    @JsonKey(name: 'eesupool_ord_id') required int eesupoolOrderId,
    @JsonKey(name: 'member_id') required String memberId,
    @JsonKey(name: 'full_name', includeToJson: false) String? fullName,
    @JsonKey(name: 'corp_name', includeToJson: false) String? corpName,
    @OrderEditPrivilageConverter() OrderEditPrivilage? privilage,
  }) = _MemberOrderAssignment;

  factory MemberOrderAssignment.fromJson(Map<String, dynamic> json) =>
      _$MemberOrderAssignmentFromJson(json);
}

class MemberOrderAssignmentConverter
    implements JsonConverter<MemberOrderAssignment, Map<String, dynamic>> {
  const MemberOrderAssignmentConverter();

  @override
  MemberOrderAssignment fromJson(Map<String, dynamic> json) {
    return MemberOrderAssignment.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(MemberOrderAssignment memberOrderAssignment) {
    return memberOrderAssignment.toJson();
  }
}
