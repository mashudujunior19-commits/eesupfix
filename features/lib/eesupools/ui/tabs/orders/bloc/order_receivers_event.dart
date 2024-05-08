part of 'order_receivers_bloc.dart';

@immutable
sealed class OrderReceiversEvent {}

final class OrderReceiversFetched extends OrderReceiversEvent {
  final List<String> receivers;
  OrderReceiversFetched(this.receivers);
}
