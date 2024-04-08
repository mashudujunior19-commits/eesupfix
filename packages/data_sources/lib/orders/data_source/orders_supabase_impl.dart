// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:data_sources/orders/data_source/orders_data_source.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:data_sources/orders/models/order_ticket.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersSupabaseImpl implements OrdersDataSource {
  final SupabaseClient _client;

  OrdersSupabaseImpl(this._client);
  @override
  Future<OrderResponse> createOrder(Order order) async {
    final params = {
      '_customer_id': order.customerId,
      '_eesupreneur_id': order.eesupreneurId,
      '_eesupool_order_id': order.eesupoolOrderId,
      '_wallet_id': order.walletId,
      '_total_amount': order.value,
      '_payment_method': order.paymentMethod.toString(),
      '_address_id': order.deliveryAddressId,
      '_delivery_fee': order.deliveryFee,
      '_card_fee': order.cardFee,
      '_pay_fees_with_retail': order.payFeesWithRetailWallet,
      '_products': order.products
          .map((e) => {
                'product_id': e.productId,
                'quantity': e.quantity,
                'price': e.price,
                'substitute_brand': e.substituteBrand,
                'substitute_variant': e.substituteVariant,
              })
          .toList(),
    };

    final result = await _client
        .schema('sales')
        .rpc('create_order', params: params)
        .single();

    final orderId = int.tryParse(result['f1'].toString());
    final outstandingAmount = double.parse(result['f2'].toString());
    final paymentId = result['f3']?.toString();
    final secondaryId = result['f4']?.toString();

    return (
      orderId: orderId,
      outstandingAmount: outstandingAmount,
      paymentId: paymentId,
      secondaryId: secondaryId
    );
  }

  @override
  Future<List<Order>> fetchOrders({
    String? userId,
    String? shopId,
    int? poolOrderId,
    required List<OrderStatus> statuses,
    required int limit,
  }) async {
    final response =
        await _client.schema('sales').rpc('get_customer_orders', params: {
      '_user_id': userId,
      '_eesupreneur_id': shopId,
      '_eesupool_ord_id': poolOrderId,
      '_limit': limit,
      '_status': statuses.map((e) => e.toString()).toList(),
    }).order('id', ascending: false);

    final orders = (response as List).map((e) => Order.fromJson(e)).toList();
    return orders;
  }

  @override
  Future<bool> saveOrderStatus(Order order) async {
    try {
      await _client.schema('sales').from('order').update({
        'status': order.status.toString(),
        'packaged_at': order.packagedAt?.toIso8601String(),
        'ready_at': order.readyAt?.toIso8601String(),
        'collected_at': order.collectedAt?.toIso8601String(),
      }).eq('id', order.id!);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Stream<List<Order>> streamCustomerOrders(
      {required String userId,
      required List<OrderStatus> statuses,
      required int limit}) async* {
    final stream = _client
        .schema('sales')
        .from('order')
        .stream(primaryKey: ['id']).eq('customer_id', userId);

    await for (final event in stream) {
      final orders = await fetchOrders(
        userId: userId,
        statuses: statuses,
        limit: limit,
      );
      yield orders;
    }
  }

  @override
  Stream<List<Order>> streamEESUpoolMemberOrders(
      {required int poolOrderId,
      required List<OrderStatus> statuses,
      required int limit}) async* {
    final stream = _client
        .schema('sales')
        .from('order')
        .stream(primaryKey: ['id']).eq('eesupool_order_id', poolOrderId);

    await for (final event in stream) {
      final orders = await fetchOrders(
        poolOrderId: poolOrderId,
        statuses: statuses,
        limit: limit,
      );
      yield orders;
    }
  }

  @override
  Stream<List<Order>> streamEESUpreneurOrders(
      {required String shopId,
      required List<OrderStatus> statuses,
      required int limit}) async* {
    final stream = _client
        .schema('sales')
        .from('order')
        .stream(primaryKey: ['id']).eq('eesupreneur_id', shopId);

    await for (final event in stream) {
      final orders = await fetchOrders(
        shopId: shopId,
        statuses: statuses,
        limit: limit,
      );
      yield orders;
    }
  }

  @override
  Future<String?> uploadTicketImage(String name, File file) async {
    try {
      await _client.storage.from('order_tickets').upload(name, file);
      String url = _client.storage.from('order_tickets').getPublicUrl(name);
      return url;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  @override
  Future<bool> saveOrderTicket(OrderTicket ticket) async {
    try {
      await _client
          .schema('sales')
          .from('order_ticket')
          .insert(ticket.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<List<OrderTicket>> fetchOrderTickets(int orderId) async {
    final results = await _client
        .schema('sales')
        .from('order_ticket')
        .select()
        .eq('order_id', orderId);
    final tickets = results.map((e) => OrderTicket.fromJson(e)).toList();
    return tickets;
  }
}
