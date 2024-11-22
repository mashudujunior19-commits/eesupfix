part of 'basket_list_bloc.dart';

@immutable
sealed class BasketListEvent {}

final class BasketListsFetched extends BasketListEvent {}

final class BasketDeleted extends BasketListEvent {
  final Basket basket;
  BasketDeleted(this.basket);
}

class AddProductsToBasket extends BasketListEvent {
  final String basketId;
  final List<Product> products;

  AddProductsToBasket(this.basketId, this.products);
}
