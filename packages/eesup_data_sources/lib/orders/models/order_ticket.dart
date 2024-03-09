// ignore_for_file: invalid_annotation_target


import 'package:eesup_data_source/eesupools/models/media_file.dart';
import 'package:eesup_data_source/orders/models/order_product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order_ticket.freezed.dart';
part 'order_ticket.g.dart';

@freezed
class OrderTicket with _$OrderTicket {
  const factory OrderTicket({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'order_id') required int orderId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'customer_comment') String? customerComment,
    @JsonKey(name: 'eesupreneur_comment') String? eesupreneurComment,
    @JsonKey(name: 'items_missing') required bool itemsMissing,
    @OrderProductConverter() required List<OrderProduct> products,
    @MediaFileConverter() @Default([]) List<MediaFile> attachments,
    @JsonKey(name: 'eesupreneur_confirmed_at') DateTime? eesupreneurConfirmedAt,
    @JsonKey(name: 'customer_confirmed_at') DateTime? customerConfirmedAt,
    @JsonKey(name: 'eesup_confirmed_at') DateTime? eesupConfirmedAt,
    @TicketResolutionTypeConverter() required TicketResolutionType resolution,
  }) = _OrderTicket;

  factory OrderTicket.fromJson(Map<String, dynamic> json) =>
      _$OrderTicketFromJson(json);
}

class TicketResolutionTypeConverter
    implements JsonConverter<TicketResolutionType, String> {
  const TicketResolutionTypeConverter();

  @override
  TicketResolutionType fromJson(String json) {
    return TicketResolutionType.fromString(json);
  }

  @override
  String toJson(TicketResolutionType object) {
    return object.toString();
  }
}

enum TicketResolutionType {
  refund,
  reorder;

  factory TicketResolutionType.fromString(String value) {
    switch (value) {
      case 'Refund':
        return TicketResolutionType.refund;
      case 'Reorder':
        return TicketResolutionType.reorder;
      default:
        throw Exception('Unknown TicketResolutionType: $value');
    }
  }

  String get description {
    switch (this) {
      case TicketResolutionType.refund:
        return 'We will refund the money for these products, into your retail wallet.';
      case TicketResolutionType.reorder:
        return 'We will reorder the products for you. and a new order will be created.';
      default:
        return 'Unknown';
    }
  }

  @override
  String toString() {
    switch (this) {
      case TicketResolutionType.refund:
        return 'Refund';
      case TicketResolutionType.reorder:
        return 'Reorder';
      default:
        return 'Unknown';
    }
  }
}
