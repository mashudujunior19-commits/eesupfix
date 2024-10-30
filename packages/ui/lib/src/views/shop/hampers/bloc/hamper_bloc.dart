import 'package:bloc/bloc.dart';
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
  HamperBloc(this._repository) : super(HamperInitial()) {
    on<FetchHampers>((event, emit) async {
      emit(HamperLoading());
      final result = await _repository.fetchHampers();
      result.fold(
        (error) =>
            emit(HamperError('Error fetching hampers: ${error.message}')),
        (hampers) => emit(HamperLoaded(hampers)),
      );
    });
    // on<FetchHamperProducts>((event, emit) async {
    //   emit(HamperLoading());

    //   final result =
    //       await _repository.fetchHamperProductDetails(event.hamperId);
    //   print('hamper product: $result');
    //   result.fold(
    //     (error) =>
    //         emit(HamperError('Error fetching products: ${error.message}')),
    //     (hamperProductDetails) =>
    //         emit(HamperProductLoaded(hamperProductDetails)),
    //   );
    // });
    on<FetchHamperProducts>((event, emit) async {
      emit(HamperLoading());
      print('Fetching products for hamper ID: ${event.hamperId}');

      final result =
          await _repository.fetchHamperProductDetails(event.hamperId);
      print('Hamper product result: $result');

      result.fold(
        (error) {
          print('Error fetching products: ${error.message}');
          emit(HamperError('Error fetching products: ${error.message}'));
        },
        (hamperProductDetails) {
          print(
              'Successfully fetched products: ${hamperProductDetails.length}');
          emit(HamperProductLoaded(hamperProductDetails));
        },
      );
    });

    on<FetchHampersByImageUrl>((event, emit) async {
      emit(HamperLoading());
      final result = await _repository.fetchHampersByImageUrl(event.imageUrl);
      result.fold(
        (error) => emit(HamperError(
            'Error fetching hampers by image URL: ${error.message}')),
        (hampers) => emit(HamperLoaded(hampers)),
      );
    });
  }
}
