import 'package:bloc/bloc.dart';
import 'package:data_sources/finance/models/payment_method.dart';
import 'package:data_sources/geolocation/models/address.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:data_sources/orders/models/order_product.dart';
import 'package:meta/meta.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutLoading()) {
    on<CheckoutStarted>((event, emit) {
      emit(
        CurrentCheckout(
          Order(
            customerId: '',
            value: event.totalAmount,
            paymentMethod: PaymentMethod.instapay,
            secretPin: 0000,
            status: OrderStatus.pending,
          ),
        ),
      );
    });
  }
}
