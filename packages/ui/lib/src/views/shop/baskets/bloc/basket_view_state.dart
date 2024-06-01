part of 'basket_view_bloc.dart';

@immutable
sealed class BasketViewState {}

final class BasketViewLoading extends BasketViewState {}

final class BasketViewError extends BasketViewState {
  final EESUpException error;
  BasketViewError(this.error);
}

final class BasketViewCurrentState extends BasketViewState {
  final Basket basket;
  final List<BasketProduct> products;
  BasketViewCurrentState(this.basket, this.products);
}
