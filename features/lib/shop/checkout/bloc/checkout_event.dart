part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {}

final class CheckoutStarted extends CheckoutEvent {
  final List<OrderProduct> products;
  CheckoutStarted(this.products);

  double subTotal() {
    double total = 0.00;
    for (var element in products) {
      total += (element.price * element.quantity);
    }
    return total;
  }
}

final class AddresseUpdated extends CheckoutEvent {
  final Address address;
  AddresseUpdated(this.address);
}

final class CollectionPointUpdated extends CheckoutEvent {
  final String? shopId;
  final int? orderId;
  final double? deliveryFee;
  CollectionPointUpdated(this.shopId, this.orderId, this.deliveryFee);
}

final class PaymentMethodUpdated extends CheckoutEvent {
  final PaymentMethod method;
  final PaymentGateway? gateway;
  PaymentMethodUpdated(this.method, this.gateway);
}

final class OrderPlaced extends CheckoutEvent {}

final class WalletIdUpdated extends CheckoutEvent {
  final int walletId;
  WalletIdUpdated(this.walletId);
}

final class PayFeesWithWalletUpdated extends CheckoutEvent {
  final bool value;
  PayFeesWithWalletUpdated(this.value);
}

final class CheckoutFinished extends CheckoutEvent {
  final int orderId;
  final bool isPlaced;
  CheckoutFinished(this.orderId,this.isPlaced);
}
