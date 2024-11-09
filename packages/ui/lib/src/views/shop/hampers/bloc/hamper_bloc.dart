import 'package:bloc/bloc.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/models/mapped_product_hamper.dart';
import 'package:data/shopping/repository/hamper_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';
import 'package:ui/src/views/shop/hampers/ui/compare_hamper_to_cart.dart';

part 'hamper_event.dart';
part 'hamper_state.dart';

class HamperBloc extends Bloc<HamperEvent, HamperState> {
  final ShoppingRepository _repository;
  bool hasEmittedMatch = false;
  HamperBloc(this._repository) : super(HamperInitial()) {
    on<FetchHampers>((event, emit) async {
      emit(HamperLoading());
      final result = await _repository.fetchHampers();
      result.fold(
        (error) =>
            emit(HamperError('Error fetching hampers: ${error.message}')),
        (hampers) => emit(HampersLoaded(hampers)),
      );
    });
    on<FetchHamper>((event, emit) async {
      emit(HamperLoading());
      final result = await _repository.fetchHamperById(event.hamperId);
      result.fold(
        (error) =>
            emit(HamperError('Error fetching hampers: ${error.message}')),
        (hampers) => emit(HamperLoaded(hampers)),
      );
    });

    on<FetchHamperProducts>((event, emit) async {
      emit(HamperLoading());
      final result =
          await _repository.fetchHamperProductDetails(event.hamperId);

      result.fold(
        (error) {
          emit(HamperError('Error fetching products: ${error.message}'));
        },
        (hamperProductDetails) {
          emit(HamperProductLoaded(hamperProductDetails));
        },
      );
    });
    on<FetchHampersByImageUrl>((event, emit) async {
      emit(HamperLoading());
      final result = await _repository.fetchHampersByImageUrl(event.imageUrl);
      result.fold(
        (error) {
          emit(HamperError(
              'Error fetching hampers by image URL: ${error.message}'));
        },
        (hamper) async {
          emit(HamperIdLoaded(hamper.id));
        },
      );
    });

    on<CompareCartWithHampers>((event, emit) async {
      emit(HamperLoading());

      try {
        final hampersResult = await _repository.fetchHampers();
        await hampersResult.fold(
          (error) async {
            if (!emit.isDone) {
              emit(HamperError('Error fetching hampers: ${error.message}'));
            }
          },
          (hampers) async {
            final comparer = HamperComparer(
                cartProducts: event.cartProducts, hampers: hampers);

            if (!hasEmittedMatch) {
              final matchingHamper = comparer.findMatchingHamper();
              print('matching hamper : $matchingHamper');

              if (matchingHamper != null) {
                final hamperProductResult =
                    await _repository.fetchHamperProduct(matchingHamper.id);

                await hamperProductResult.fold(
                  (error) async {
                    if (!emit.isDone) {
                      emit(HamperError(
                          'Error fetching hamper product: ${error.message}'));
                    }
                  },
                  (product) async {
                    // If the product is not null, emit the comparison result state
                    if (product != null) {
                      if (!emit.isDone) {
                        emit(HamperComparisonResultState(
                          hamperProduct: product,
                          matchingHamper: matchingHamper,
                        ));
                      }
                      hasEmittedMatch = true;
                    } else {
                      // If no product is found, emit the failure state
                      if (!emit.isDone) {
                        emit(HamperComparisonFailure());
                      }
                    }
                  },
                );
              } else {
                // If no matching hamper is found, emit the failure state
                if (!emit.isDone) {
                  emit(HamperComparisonFailure());
                }
              }
            }
          },
        );
      } catch (e) {
        // Catch any unexpected errors and emit an error state
        if (!emit.isDone) {
          emit(HamperError('Unexpected error: $e'));
        }
      }
    });

    // on<CompareCartWithHampers>((event, emit) async {
    //   emit(HamperLoading());

    //   final hampersResult = await _repository.fetchHampers();
    //   hampersResult.fold((error) {
    //     emit(HamperError('Error fetching hampers: ${error.message}'));
    //   }, (hampers) async {
    //     final comparer = HamperComparer(
    //       cartProducts: event.cartProducts,
    //       hampers: hampers,
    //     );
    //     if (!hasEmittedMatch) {
    //       final matchingHamper = comparer.findMatchingHamper();
    //       print('matching hamper : $matchingHamper');

    //       if (matchingHamper != null) {
    //         final hamperProductResult =
    //             await _repository.fetchHamperProduct(matchingHamper.id);

    //         hamperProductResult.fold(
    //           (error) {
    //             emit(HamperError(
    //                 'Error fetching hamper product: ${error.message}'));
    //           },
    //           (product) async {
    //             if (product != null) {
    //               print("Emitting HamperComparisonResultState");
    //               emit(HamperComparisonResultState(
    //                   hamperProduct: product, matchingHamper: matchingHamper));
    //               hasEmittedMatch = true;
    //             } else {
    //               emit(HamperComparisonFailure());
    //             }
    //           },
    //         );
    //       } else {
    //         emit(HamperComparisonFailure());
    //       }
    //     }
    //   });
    // });
    on<ResetHamperComparison>((event, emit) {
      hasEmittedMatch = false;
      emit(HamperInitial());
    });
    on<FetchHamperProductsByImageUrl>((event, emit) async {
      emit(HamperLoading());
      final result = await _repository.fetchHampersByImageUrl(event.imageUrl);

      result.fold(
        (error) => emit(HamperError('Error fetching hamper: ${error.message}')),
        (hampers) {
          add(FetchHamperProducts(hampers.id));
        },
      );
    });
    on<FetchHamperAsProduct>((event, emit) async {
      emit(HamperLoading());
      try {
        final result = await _repository.fetchHamperProduct(event.hamperId);
        result.fold(
          (error) =>
              emit(HamperError('Failed to fetch products: ${error.message}')),
          (product) {
            if (product != null) {
              emit(HamperAsProductLoaded(product));
            } else {
              emit(HamperError('No product found for this hamper'));
            }
          },
        );
      } catch (e) {
        emit(HamperError('Failed to fetch products: $e'));
      }
    });
  }
}
