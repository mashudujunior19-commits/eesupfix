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
          null,
        ),
      );
    });

    on<AddresseUpdated>((event, emit) {
      if (state is CurrentCheckout) {
        final currentOrder = (state as CurrentCheckout).newOrder;
        emit(
          CurrentCheckout(
            currentOrder.copyWith(deliveryAddressId: event.address.id),
            event.address,
          ),
        );
      }
    });

    on<CollectionPointUpdated>((event, emit) {
      if (state is CurrentCheckout) {
        final currentOrderr = (state as CurrentCheckout).newOrder;
        final currentAddress = (state as CurrentCheckout).selectedAddress;
        emit(
          CurrentCheckout(
            currentOrderr.copyWith(
              eesupreneurId: event.shopId,
              eesupoolOrderId: event.orderId,
            ),
            currentAddress,
          ),
        );
      }
    });

    on<PaymentMethodUpdated>((event, emit) {
      if (state is CurrentCheckout) {
        final currentOrderr = (state as CurrentCheckout).newOrder;
        final currentAddress = (state as CurrentCheckout).selectedAddress;
        emit(
          CurrentCheckout(
            currentOrderr.copyWith(paymentMethod: event.method),
            currentAddress,
          ),
        );
      }
    });
  }
}
