part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CurrentCheckout extends CheckoutState {
  final Order newOrder;
  CurrentCheckout(this.newOrder);
  double totalToPay() {
    double paymentFee = newOrder.cardFee ?? 0.00;
    double deliveryFee = newOrder.deliveryFee ?? 0;
    double total = newOrder.value + paymentFee + deliveryFee;
    return total;
  }
}

final class OutstandingPayment extends CheckoutState {
  final OrderResponse response;
  final PaymentMethod paymentMethod;
  OutstandingPayment(this.response, this.paymentMethod);
}

final class OrderPlacedSuccess extends CheckoutState {}

final class CheckoutError extends CheckoutState {
  final EESUpException exception;
  final Order order;
  CheckoutError(this.exception,this.order);
}
