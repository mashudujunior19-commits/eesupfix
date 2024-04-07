part of 'payment_gatway_bloc.dart';

@immutable
sealed class PaymentGatwayEvent {}

final class PaymentGatewaysFetched extends PaymentGatwayEvent {}
