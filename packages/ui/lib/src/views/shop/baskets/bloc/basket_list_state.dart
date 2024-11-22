part of 'basket_list_bloc.dart';

@immutable
sealed class BasketListState {}

final class BasketListLoading extends BasketListState {}

final class BasketListEmpty extends BasketListState {}

final class BasketListError extends BasketListState {
  final EESUpException exception;
  BasketListError(this.exception);
}

final class BasketListLoaded extends BasketListState {
  final List<Basket> baskets;
  BasketListLoaded(this.baskets);
}

class BasketListSuccess extends BasketListState {
  final String message;
  BasketListSuccess(this.message);
}
