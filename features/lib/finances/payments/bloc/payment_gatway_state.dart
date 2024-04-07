part of 'payment_gatway_bloc.dart';

@immutable
sealed class PaymentGatwayState {}

final class PaymentGaywayLoading extends PaymentGatwayState {}

final class PaymentGatwaysLoaded extends PaymentGatwayState {
  final List<PaymentGateway> gateways;
  PaymentGatwaysLoaded(this.gateways);

  PaymentGateway? gateway(PaymentMethod method) {
    try {
      return gateways.firstWhere((e) => e.id == method);
    } catch (_) {
      return null;
    }
  }
}

final class PaymentGatwaysError extends PaymentGatwayState {
  final EESUpException error;
  PaymentGatwaysError(this.error);
}
