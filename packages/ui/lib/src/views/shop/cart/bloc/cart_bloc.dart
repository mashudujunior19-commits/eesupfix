import 'package:bloc/bloc.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper_product.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/shopping/repository/hamper_repository.dart';

import '../../hampers/ui/compare_hamper_to_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ShoppingRepository _repository;
  bool hasEmittedMatch = false;

  CartBloc(this._repository) : super(CurrentCart(const [])) {
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
            quantity: product.quantity,
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

    // on<CompareCartWithHampers>((event, emit) async {
    //   emit(HamperComparisonLoading());

    //   final hampersResult = await _repository.fetchHampers();
    //   hampersResult.fold(
    //     (error) {
    //       emit(HamperComparisonError(
    //           'Error fetching hampers: ${error.message}'));
    //     },
    //     (hampers) async {
    //       final comparer = HamperComparer(
    //         cartProducts: event.cartProducts,
    //         hampers: hampers,
    //       );

    //       if (!hasEmittedMatch) {
    //         final matchingHamper = comparer.findMatchingHamper();

    //         if (matchingHamper != null) {
    //           final hamperProductResult =
    //               await _repository.fetchHamperProduct(matchingHamper.id);

    //           hamperProductResult.fold(
    //             (error) {
    //               emit(HamperComparisonError(
    //                   'Error fetching hamper product: ${error.message}'));
    //             },
    //             (product) {
    //               if (product != null) {
    //                 emit(HamperComparisonResultState(hamperProduct: product));
    //                 hasEmittedMatch = true;
    //               } else {
    //                 emit(
    //                     HamperComparisonError('Error fetching hamper product'));
    //               }
    //             },
    //           );
    //         } else {
    //           emit(HamperComparisonError('Error fetching hamper product'));
    //         }
    //       }
    //     },
    //   );
    // });
    on<CompareCartWithHampers>((event, emit) async {
      // Start loading state immediately
      emit(HamperComparisonLoading());

      // Fetch hampers from repository
      final hampersResult = await _repository.fetchHampers();

      hampersResult.fold(
        (error) => emit(HamperComparisonError('Error: ${error.message}')),
        (hampers) async {
          final comparer = HamperComparer(
            cartProducts: event.cartProducts,
            hampers: hampers,
          );

          // Find matching hamper
          final matchingHamper = comparer.findMatchingHamper();

          if (matchingHamper != null) {
            // Fetch the matching hamper product
            final hamperProductResult =
                await _repository.fetchHamperProduct(matchingHamper.id);

            hamperProductResult.fold(
              (error) => emit(HamperComparisonError('Error: ${error.message}')),
              (product) {
                if (product != null) {
                  // Emit the hamper comparison result if found
                  emit(HamperComparisonResultState(hamperProduct: product));
                } else {
                  // Emit error if no hamper product is found
                  emit(HamperComparisonError('Error fetching hamper product'));
                }
              },
            );
          } else {
            // Emit error if no matching hamper is found
            emit(HamperComparisonError('No matching hampers found.'));
          }
        },
      );
    });
  }
}
