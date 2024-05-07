import 'package:bloc/bloc.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:features/eesupools/ui/tabs/orders/bloc/orders_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository/orders/order_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'member_orders_event.dart';
part 'member_orders_state.dart';

class MemberOrdersBloc extends Bloc<MemberOrdersEvent, MemberOrdersState> {
  final OrderRepository _repository;
  MemberOrdersBloc(this._repository) : super(OrdersLoading()) {
    on<MemberOrdersFetched>((event, emit) async {
      // emit(OrdersLoading());
      ///get the orders stream
      final stream = _repository.streamPoolOrders(
        orderId: event.orderId,
        statuses: event.initStatuses,
        limit: event.initLimit,
      );

      //using the forEach event method to emit the appropriate state
      await emit.forEach(
        stream,
        onData: (data) {
          return data.fold((l) {
            return OrdersError(l);
          }, (r) {
            return OrdersLoaded(r);
          });
        },
      );
    });
  }
}
