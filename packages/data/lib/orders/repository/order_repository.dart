import 'dart:io';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/orders/models/order_ticket.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/orders/models/order.dart';
import 'package:data/orders/data_source/orders_data_source.dart';

import '../models/order_product.dart';

class OrderRepository {
  final OrdersDataSource _ordersDataSource;
  final AuthRepository _authRepository;

  OrderRepository(this._ordersDataSource, this._authRepository);

  Future<Either<EESUpException, OrderResponse>> createOrder(Order order) async {
    final result = await _authRepository.executeFutureWithAuth((id) async {
      final response =
          await _ordersDataSource.createOrder(order.copyWith(customerId: id));
      return response;
    });
    return result;
  }

  Stream<Either<EESUpException, List<Order>>> streamCustomerOrders(
    List<OrderStatus> statuses,
    int limit,
  ) async* {
    final stream = _authRepository.executeStreamWithAuth((id) async* {
      final response = _ordersDataSource.streamCustomerOrders(
        statuses: statuses,
        userId: id,
        limit: limit,
      );
      yield* response;
    });
    yield* stream;
  }

  Stream<Either<EESUpException, Order>> streamOrderById(
    int orderId,
  ) async* {
    final stream = _authRepository.executeStreamWithAuth((id) async* {
      final response = _ordersDataSource.streamOrderChanges(
        orderId: orderId,
      );
      yield* response;
    });
    yield* stream;
  }

  Stream<Either<EESUpException, List<Order>>> streamShopOrders({
    required String shopId,
    required List<OrderStatus> statuses,
    required int limit,
  }) async* {
    final result = _authRepository.executeStreamWithAuth((_) async* {
      final response = _ordersDataSource.streamEESUpreneurOrders(
        statuses: statuses,
        shopId: shopId,
        limit: limit,
      );
      yield* response;
    });
    yield* result;
  }

  Stream<Either<EESUpException, List<Order>>> streamPoolOrders({
    required int orderId,
    required List<OrderStatus> statuses,
    required int limit,
  }) async* {
    final result = _authRepository.executeStreamWithAuth((_) async* {
      final response = _ordersDataSource.streamEESUpoolMemberOrders(
        statuses: statuses,
        poolOrderId: orderId,
        limit: limit,
      );
      yield* response;
    });
    yield* result;
  }

  Future<Either<EESUpException, bool>> saveStatusChanges(Order order) async {
    final result = await _authRepository.executeFutureWithAuth((_) async {
      final response = await _ordersDataSource.saveOrderStatus(order);
      return response;
    });
    return result;
  }

  Future<Either<EESUpException, String?>> uploadTicketImage(
    String name,
    File file,
  ) async {
    final result = await _authRepository.executeFutureWithAuth((_) async {
      final response = await _ordersDataSource.uploadTicketImage(name, file);
      return response;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> saveTicket(
    OrderTicket ticket,
  ) async {
    final result = await _authRepository.executeFutureWithAuth((_) async {
      final response = await _ordersDataSource.saveOrderTicket(ticket);
      return response;
    });
    return result;
  }

  Future<Either<EESUpException, List<OrderTicket>>> fetchOrderTickets(
    int orderId,
  ) async {
    final result = await _authRepository.executeFutureWithAuth((_) async {
      final response = await _ordersDataSource.fetchOrderTickets(orderId);
      return response;
    });
    return result;
  }

  Future<Either<EESUpException, List<OrderProduct>>> fetchOrderProducts(
    int orderId,
  ) async {
    final result = await _authRepository.executeFutureWithAuth((_) async {
      final response = await _ordersDataSource.fetchOrderProducts(orderId);
      return response;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> updateOrderStatus(
    int orderId,
    OrderStatus status,
  ) async {
    final result = await _authRepository.executeFutureWithAuth((_) async {
      final response =
          await _ordersDataSource.updateOrderStatus(orderId, status);
      return response;
    });
    return result;
  }
}
