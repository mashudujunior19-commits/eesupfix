part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CurrentCheckout extends CheckoutState {
  final Order newOrder;
  CurrentCheckout(this.newOrder);
}
