import 'package:bloc/bloc.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/models/mapped_product_hamper.dart';
import 'package:data/shopping/repository/hamper_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';

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
        (hamper) {
          if (hamper == null) {
            emit(HamperNotFound()); // New state to handle null hampers
          } else {
            emit(HamperIdLoaded(
                hamper.id)); // Proceed as normal if hamper is found
          }
        },
      );
    });

    on<ResetHamperComparison>((event, emit) {
      hasEmittedMatch = false;
      emit(HamperInitial());
    });

    on<FetchHamperProductsByImageUrl>((event, emit) async {
      emit(HamperLoading());

      final result = await _repository.fetchHampersByImageUrl(event.imageUrl);

      result.fold(
        (error) => emit(HamperError('Error fetching hamper: ${error.message}')),
        (hamper) {
          if (hamper == null) {
            emit(HamperNotFound()); // Handle the case where no hamper is found
          } else {
            add(FetchHamperProducts(
                hamper.id)); // Continue fetching products if hamper exists
          }
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
