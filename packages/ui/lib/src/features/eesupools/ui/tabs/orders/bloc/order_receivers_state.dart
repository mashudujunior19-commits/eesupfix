part of 'order_receivers_bloc.dart';

@immutable
sealed class OrderReceiversState {}

final class OrderReceiversLoading extends OrderReceiversState {}

final class OrderReceiversError extends OrderReceiversState {
  final EESUpException error;
  OrderReceiversError(this.error);
}

final class OrderReceiversLoaded extends OrderReceiversState {
  final List<EESUpoolMember> receivers;
  OrderReceiversLoaded(this.receivers);
}
