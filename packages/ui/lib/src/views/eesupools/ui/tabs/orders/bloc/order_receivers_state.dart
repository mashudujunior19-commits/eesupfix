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
  final Map<String, ReceiverRole> roles;

  /// Set when the last change couldn't be saved; the state itself is the
  /// last saved one, so the screen shows what's actually stored.
  final String? saveError;
  OrderReceiversLoaded(this.receivers, [this.roles = const {}, this.saveError]);

  OrderReceiversLoaded withError(String error) =>
      OrderReceiversLoaded(receivers, roles, error);
}
