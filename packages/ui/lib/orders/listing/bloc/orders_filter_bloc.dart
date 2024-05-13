import 'package:bloc/bloc.dart';
import 'package:data/orders/models/order.dart';
import 'package:meta/meta.dart';

part 'orders_filter_event.dart';
part 'orders_filter_state.dart';

class OrdersFilterBloc extends Bloc<OrdersFilterEvent, OrdersFilterState> {
  OrdersFilterBloc() : super(OrdersFilter(OrderStatus.values, 10)) {
    on<OrdersFiltersChanged>((event, emit) {
      emit(OrdersFilter(event.statuses, event.limit));
    });
  }
}
