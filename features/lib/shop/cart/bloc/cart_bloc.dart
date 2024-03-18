import 'package:bloc/bloc.dart';
import 'package:data_sources/orders/models/order_product.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CurrentCart(const [])) {
    on<ProductAddedToCart>((event, emit) {
      var currentCart = [...(state as CurrentCart).products];
      var product = event.product;

      ///if product is already in the cart, increase the quantity
      ///otherwise add the product to the cart
      var index = currentCart
          .indexWhere((element) => element.productId == product.productId);

      if (index != -1) {
        currentCart[index] = currentCart[index]
            .copyWith(quantity: currentCart[index].quantity + 1);
      } else {
        currentCart.add(
          OrderProduct(
            productId: product.productId,
            name: product.name,
            price: product.price,
            quantity: 1,
          ),
        );
      }
      emit(CurrentCart(currentCart));
    });

    on<ProductRemovedFromCart>((event, emit) {
      var currentCart = [...(state as CurrentCart).products];
      var product = event.product;
      var index = currentCart
          .indexWhere((element) => element.productId == product.productId);
      if (index != -1) {
        if (currentCart[index].quantity > 1) {
          currentCart[index] = currentCart[index]
              .copyWith(quantity: currentCart[index].quantity - 1);
        } else {
          currentCart.removeAt(index);
        }
      }
      emit(CurrentCart(currentCart));
    });
  
    on<CartCleared>((event, emit) {
      emit(CurrentCart(const []));
    });
  }
}
