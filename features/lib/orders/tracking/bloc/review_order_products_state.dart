part of 'review_order_products_bloc.dart';

@immutable
sealed class ReviewOrderProductsState {}

final class ReviewOrderProductsInitial extends ReviewOrderProductsState {}

final class ReviewOrderProductsCurrentState extends ReviewOrderProductsState {
  final Order order;
  ReviewOrderProductsCurrentState(this.order);

  bool isBalanced() {
    final products = order.products;
    for (final p in products) {
      if (p.customerAcceptedQty != p.quantity) {
        return false;
      }
      if (p.eesupreneurAcceptedQty != p.quantity) {
        return false;
      }
    }
    return true;
  }
}
