part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {}

final class CheckoutStarted extends CheckoutEvent {
  final List<OrderProduct> products;
  CheckoutStarted(this.products);
}