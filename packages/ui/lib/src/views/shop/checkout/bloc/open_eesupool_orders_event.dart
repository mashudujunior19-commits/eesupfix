part of 'open_eesupool_orders_bloc.dart';

@immutable
sealed class OpenEESUpoolOrdersEvent {}

final class OpenOrdersFetched extends OpenEESUpoolOrdersEvent {}
