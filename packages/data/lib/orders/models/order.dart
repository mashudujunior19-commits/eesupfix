// ignore_for_file: invalid_annotation_target

import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/finance/models/payment_method.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    int? id,
    @JsonKey(name: 'customer_id') required String customerId,
    @JsonKey(name: 'eesupreneur_id') String? eesupreneurId,
    @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,
    @JsonKey(name: 'wallet_id', includeFromJson: false, includeToJson: false)
    int? walletId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'placed_at', includeToJson: false) DateTime? placedAt,
    @JsonKey(name: 'packaged_at') DateTime? packagedAt,
    @JsonKey(name: 'ready_at') DateTime? readyAt,
    @JsonKey(name: 'collected_at') DateTime? collectedAt,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
    required double value,
    @PaymentMethodConverter()
    @JsonKey(name: 'payment_method')
    required PaymentMethod paymentMethod,
    @JsonKey(name: 'secret_pin') required int secretPin,
    @JsonKey(name: 'delivery_address_id') int? deliveryAddressId,
    @JsonKey(name: 'delivery_fee') double? deliveryFee,
    @JsonKey(name: 'card_fee') double? cardFee,
    @JsonKey(name: 'pay_fees_with_retail_wallet')
    @Default(false)
    payFeesWithRetailWallet,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'corp_name') String? corpName,
    @MemberOrderAssignmentConverter()
    @Default([])
    List<MemberOrderAssignment> assignments,
    @OrderStatusConverter()
    @JsonKey(includeToJson: false)
    required OrderStatus status,
    // @EESUpreneurConverter() @JsonKey(includeToJson: false) EESUpreneur? eesupreneur,
    // @EESUpoolConverter() @JsonKey(includeToJson: false) EESUpool? eesupool,
    // @ProfileConverter() @JsonKey(includeToJson: false) Profile? customer,
    @OrderProductConverter() @Default([]) List<OrderProduct> products,
    @AddressConverter() @JsonKey(includeToJson: false) Address? address,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

class OrderStatusConverter implements JsonConverter<OrderStatus, String> {
  const OrderStatusConverter();

  @override
  OrderStatus fromJson(String status) {
    return OrderStatus.fromJson(status);
  }

  @override
  String toJson(OrderStatus status) {
    return status.toString();
  }
}

enum OrderEditPrivilage {
  none,
  packer,
  collector,
  owner,
  all;

  factory OrderEditPrivilage.fromJson(String status) {
    switch (status) {
      case 'Packer':
        return OrderEditPrivilage.packer;
      case 'Collector':
        return OrderEditPrivilage.collector;
      case 'Owner':
        return OrderEditPrivilage.owner;
      case 'All':
        return OrderEditPrivilage.all;
      default:
        return OrderEditPrivilage.none;
    }
  }

  @override
  String toString() {
    switch (this) {
      case OrderEditPrivilage.packer:
        return 'Packer';
      case OrderEditPrivilage.collector:
        return 'Collector';
      case OrderEditPrivilage.owner:
        return 'Owner';
      case OrderEditPrivilage.all:
        return 'All';
      default:
        return 'None';
    }
  }
}

class OrderEditPrivilageConverter
    implements JsonConverter<OrderEditPrivilage, String> {
  const OrderEditPrivilageConverter();

  @override
  OrderEditPrivilage fromJson(String status) {
    return OrderEditPrivilage.fromJson(status);
  }

  @override
  String toJson(OrderEditPrivilage status) {
    return status.toString();
  }
}

enum OrderStatus {
  pending,
  placed,
  packaged,
  ready,
  dispatched,
  cancelled;

  factory OrderStatus.fromJson(String status) {
    switch (status) {
      case 'Pending':
        return OrderStatus.pending;
      case 'Placed':
        return OrderStatus.placed;
      case 'Packaged':
        return OrderStatus.packaged;
      case 'Ready':
        return OrderStatus.ready;
      case 'Dispatched':
        return OrderStatus.dispatched;
      case 'Cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  @override
  String toString() {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.placed:
        return 'Placed';
      case OrderStatus.packaged:
        return 'Packaged';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.dispatched:
        return 'Dispatched';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Pending';
    }
  }
}

typedef OrderResponse = ({
  int? orderId,
  double outstandingAmount,
  String? paymentId,
  String? secondaryId
});
