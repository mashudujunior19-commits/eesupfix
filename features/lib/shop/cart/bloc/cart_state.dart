part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CurrentCart extends CartState {
  final List<OrderProduct> products;
  CurrentCart(this.products);
}
