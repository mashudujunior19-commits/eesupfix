part of 'basket_view_bloc.dart';

@immutable
sealed class BasketViewEvent {}

final class BasketViewFetched extends BasketViewEvent {
  final Basket basket;
  BasketViewFetched(this.basket);
}

final class BasketProductChanged extends BasketViewEvent {
  final BasketProduct product;
  BasketProductChanged(this.product);
}
