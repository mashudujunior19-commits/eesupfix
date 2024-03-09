// ignore_for_file: invalid_annotation_target
import 'package:eesup_data_source/eesupools/models/eesupool_member.dart';
import 'package:eesup_data_source/geolocation/models/address.dart';
import 'package:eesup_data_source/orders/models/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eesupool_order.freezed.dart';
part 'eesupool_order.g.dart';

@freezed
class EESUpoolOrder with _$EESUpoolOrder {
  const factory EESUpoolOrder({
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'eesupool_id') required int eesupoolId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'schedule_for') required DateTime scheduleFor,
    @JsonKey(name: 'closes_at') required DateTime closesAt,
    @JsonKey(name: 'secret_pin')  int? secretPin,
    @JsonKey(name: 'receiver_id') String? receiverId,
    @JsonKey(name: 'delivered_at') DateTime? deliveredAt,
    @JsonKey(name: 'admin_fee') double? adminFee,
    @JsonKey(name: 'packer_fee') double? packerFee,
    @JsonKey(name: 'receiver_fee') double? receiverFee,
    @JsonKey(name: 'collection_fee') double? collectionFee,
    @JsonKey(name: 'address_id') int? addressId,

    ///other
    @JsonKey(name: 'eesupool_name', includeToJson: false) String? eesupoolName,
    @EESUpoolMemberConverter()
    @JsonKey(name: 'receiver', includeToJson: false)
    EESUpoolMember? receiver,
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

@freezed
class MemberOrderAssignment with _$MemberOrderAssignment {
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
