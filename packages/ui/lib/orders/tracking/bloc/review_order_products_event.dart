part of 'review_order_products_bloc.dart';

@immutable
sealed class ReviewOrderProductsEvent {}

final class ReviewOrderProductsInitialized extends ReviewOrderProductsEvent {
  final Order order;
  ReviewOrderProductsInitialized(this.order);
}


final class OrderProductReviewEdited extends ReviewOrderProductsEvent {
  final OrderProduct product;
  OrderProductReviewEdited(this.product);
}