import 'dart:io';

import 'package:data_sources/orders/models/order.dart';
import 'package:data_sources/orders/models/order_ticket.dart';

abstract class OrdersDataSource {
  ///Create an order and returns the order id and the outstanding amount
  ///if any
  ///Outstanding amount is used to pay with eft while the other amount is settled
  ///with the retail wallet
  Future<OrderResponse> createOrder(Order order);

  Stream<List<Order>> streamCustomerOrders({
    required String userId,
    required List<OrderStatus> statuses,
    required int limit,
  });

  Stream<List<Order>> streamEESUpreneurOrders({
    required String shopId,
    required List<OrderStatus> statuses,
    required int limit,
  });

  Stream<List<Order>> streamEESUpoolMemberOrders({
    required int poolOrderId,
    required List<OrderStatus> statuses,
    required int limit,
  });

  Future<List<Order>> fetchOrders({
    String? userId,
    String? shopId,
    int? poolOrderId,
    required List<OrderStatus> statuses,
    required int limit,
  });

  Future<bool> saveOrderStatus(Order order);

  Future<String?> uploadTicketImage(String name, File file);

  Future<bool> saveOrderTicket(OrderTicket ticket);

  Future<List<OrderTicket>> fetchOrderTickets(int orderId);
}
