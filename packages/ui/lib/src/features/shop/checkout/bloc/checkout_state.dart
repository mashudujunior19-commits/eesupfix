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

  double subTotalToPay() {
    double total = newOrder.value;
    return total;
  }

  double _totalCostPrice() {
    double total = 0;
    for (final p in newOrder.products) {
      total += (p.costPrice ?? 0) * p.quantity;
    }
    return total;
  }

  double profit() {
    return subTotalToPay()- _totalCostPrice();
  }
}

final class OutstandingPayment extends CheckoutState {
  final Order order;
  final OrderResponse response;
  final PaymentMethod paymentMethod;
  OutstandingPayment(this.response, this.paymentMethod, this.order);
}

final class CheckoutCompleted extends CheckoutState {
  final int? orderId;
  final bool isSuccess;
  CheckoutCompleted(this.orderId, this.isSuccess);
}

final class CheckoutError extends CheckoutState {
  final EESUpException exception;
  final Order order;
  CheckoutError(this.exception, this.order);
}
