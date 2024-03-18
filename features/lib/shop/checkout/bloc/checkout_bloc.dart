import 'package:bloc/bloc.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:data_sources/orders/models/order_product.dart';
import 'package:meta/meta.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<CheckoutStarted>((event, emit) {
      // TODO: implement event handler
    });
  }
}
