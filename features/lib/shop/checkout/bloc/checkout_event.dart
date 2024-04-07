part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {}

final class CheckoutStarted extends CheckoutEvent {
  final double totalAmount;
  final List<OrderProduct> products;
  CheckoutStarted(this.totalAmount, this.products);
}

final class AddresseUpdated extends CheckoutEvent {
  final Address address;
  AddresseUpdated(this.address);
}

final class CollectionPointUpdated extends CheckoutEvent {
  final String? shopId;
  final int? orderId;
  CollectionPointUpdated(this.shopId, this.orderId);
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
