import 'package:bloc/bloc.dart';
import 'package:data/orders/models/order_product.dart';
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
            quantity: 1,
            productClass: product.productClass,
            price: product.price,
            name: product.name,
            imageUrl: product.imageUrl,
            category: product.category,
            size: product.size,
            costPrice: product.costPrice,
          ),
        );
      }
      emit(CurrentCart(currentCart));
    });

    on<ProductDecrementedFromCart>((event, emit) {
      var currentCart = [...(state as CurrentCart).products];

      var index =
          currentCart.indexWhere((element) => element.productId == event.id);
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

    on<ProductRemovedFromCart>((event, emit) {
      var currentCart = [...(state as CurrentCart).products];

      var index =
          currentCart.indexWhere((element) => element.productId == event.id);
      if (index != -1) {
        currentCart.removeAt(index);
      }
      emit(CurrentCart(currentCart));
    });

    on<ProductSubsitutesUpdated>((event, emit) {
      var currentCart = [...(state as CurrentCart).products];

      var index = currentCart.indexWhere(
        (e) => e.productId == event.id,
      );

      if (index != -1) {
        currentCart[index] = currentCart[index].copyWith(
          substituteBrand: event.substituteBrand,
          substituteVariant: event.substituteVariant,
        );
      }
      emit(CurrentCart(currentCart));
    });

    on<ProductSettingsExpanded>((event, emit) {
      var currentCart = [...(state as CurrentCart).products];

      var index = currentCart.indexWhere(
        (element) => element.productId == event.id,
      );
      if (index != -1) {
        currentCart[index] = currentCart[index].copyWith(
          isExpanded: event.isExpanded,
        );
      }
      emit(CurrentCart(currentCart));
    });

    on<CartCleared>((event, emit) {
      emit(CurrentCart(const []));
    });
  }
}
