part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CurrentCheckout extends CheckoutState {
  final Order newOrder;
  final Address? selectedAddress;
  CurrentCheckout(this.newOrder, this.selectedAddress);

  double totalToPay() {
    double paymentFee = newOrder.paymentMethod.fee() ?? 0;
    double deliveryFee = newOrder.deliveryFee ?? 0;
    double total = newOrder.value + paymentFee + deliveryFee;
    return total;
  }
}
