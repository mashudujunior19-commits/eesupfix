part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class ProductAddedToCart extends CartEvent {
  final OrderProduct product;
  ProductAddedToCart(this.product);
}

final class ProductRemovedFromCart extends CartEvent {
  final OrderProduct product;
  ProductRemovedFromCart(this.product);
}

final class CartCleared extends CartEvent {
  CartCleared();
}
