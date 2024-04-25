import 'package:bloc/bloc.dart';
import 'package:data_sources/finance/models/payment_gateway.dart';
import 'package:data_sources/finance/models/payment_method.dart';
import 'package:data_sources/geolocation/models/address.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:data_sources/orders/models/order_product.dart';
import 'package:meta/meta.dart';
import 'package:repository/orders/order_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final OrderRepository _orderRepo;
  CheckoutBloc(this._orderRepo) : super(CheckoutLoading()) {
    on<CheckoutStarted>((event, emit) {
      emit(
        CurrentCheckout(
          Order(
            customerId: '',
            value: event.subTotal(),
            paymentMethod: PaymentMethod.instapay,
            secretPin: 0000,
            status: OrderStatus.pending,
            products: event.products,
          ),
        ),
      );
    });

    on<AddresseUpdated>((event, emit) {
      if (state is CurrentCheckout) {
        final currentOrder = (state as CurrentCheckout).newOrder;
        emit(
          CurrentCheckout(
            currentOrder.copyWith(
              deliveryAddressId: event.address.id,
              address: event.address,
            ),
          ),
        );
      }
    });

    on<CollectionPointUpdated>((event, emit) {
      if (state is CurrentCheckout) {
        final currentOrder = (state as CurrentCheckout).newOrder;
        emit(
          CurrentCheckout(
            currentOrder.copyWith(
              eesupreneurId: event.shopId,
              eesupoolOrderId: event.orderId,
              deliveryFee: event.deliveryFee,
            ),
          ),
        );
      }
    });

    on<PaymentMethodUpdated>((event, emit) {
      if (state is CurrentCheckout) {
        final currentOrder = (state as CurrentCheckout).newOrder;
        final fee = (state as CurrentCheckout).subTotalToPay() *
            ((event.gateway?.fee ?? 0.00) / 100);
        emit(
          CurrentCheckout(
            currentOrder.copyWith(
              paymentMethod: event.method,
              cardFee: fee,
            ),
          ),
        );
      }
    });

    on<WalletIdUpdated>((event, emit) {
      if (state is CurrentCheckout) {
        final currentOrder = (state as CurrentCheckout).newOrder;
        emit(CurrentCheckout(currentOrder.copyWith(walletId: event.walletId)));
      }
    });

    on<PayFeesWithWalletUpdated>((event, emit) {
      if (state is CurrentCheckout) {
        final currentOrder = (state as CurrentCheckout).newOrder;
        emit(
          CurrentCheckout(
            currentOrder.copyWith(payFeesWithRetailWallet: event.value),
          ),
        );
      }
    });

    on<OrderPlaced>((event, emit) async {
      if (state is CurrentCheckout) {
        final order = (state as CurrentCheckout).newOrder;

        emit(CheckoutLoading());

        final results = await _orderRepo.createOrder(order);

        results.fold((l) {
          emit(CheckoutError(l, order));
        }, (outcome) {
          if (outcome.outstandingAmount > 0) {
            emit(
              OutstandingPayment(outcome, order.paymentMethod, order),
            );
          } else {
            emit(CurrentCheckout(order));
          }
        });
      }
    });

    on<CheckoutFinished>((event, emit) {
      emit(CheckoutCompleted(event.orderId, event.isPlaced));
    });
  }
}
