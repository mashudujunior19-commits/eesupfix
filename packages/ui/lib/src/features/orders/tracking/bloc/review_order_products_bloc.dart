import 'package:bloc/bloc.dart';
import 'package:data/orders/models/order.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:meta/meta.dart';

part 'review_order_products_event.dart';
part 'review_order_products_state.dart';

class ReviewOrderProductsBloc
    extends Bloc<ReviewOrderProductsEvent, ReviewOrderProductsState> {
  ReviewOrderProductsBloc() : super(ReviewOrderProductsInitial()) {
    on<ReviewOrderProductsInitialized>((event, emit) {
      emit(ReviewOrderProductsCurrentState(event.order));
    });

    on<OrderProductReviewEdited>((event, emit) {
      if (state is ReviewOrderProductsCurrentState) {
        final order = (state as ReviewOrderProductsCurrentState).order;
        List<OrderProduct> products = [...order.products];
        final index = products.indexWhere(
          (e) => e.productId == event.product.productId,
        );
        if (index != -1) {
          products[index] = products[index].copyWith(
            customerAcceptedQty: event.product.customerAcceptedQty,
            eesupreneurAcceptedQty: event.product.eesupreneurAcceptedQty,
          );
          emit(
            ReviewOrderProductsCurrentState(order.copyWith(products: products)),
          );
        }
      }
    });
  }
}
