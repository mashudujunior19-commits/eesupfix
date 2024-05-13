import 'package:bloc/bloc.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/models/basket_product.dart';
import 'package:data/shopping/repository/basket_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';


part 'basket_view_event.dart';
part 'basket_view_state.dart';

class BasketViewBloc extends Bloc<BasketViewEvent, BasketViewState> {
  final ShoppingRepository _repository;
  BasketViewBloc(this._repository) : super(BasketViewLoading()) {
    on<BasketViewFetched>((event, emit) async {
      emit(BasketViewLoading());
      final products = await _repository.fetchBasketProducts(event.basket.id);
      products.fold((left) {
        emit(BasketViewError(left));
      }, (right) {
        emit(BasketViewCurrentState(event.basket, right));
      });
    });

    on<BasketProductChanged>((event, emit) {
      if (state is BasketViewCurrentState) {
        final basket = (state as BasketViewCurrentState).basket;
        List<BasketProduct> products =
            (state as BasketViewCurrentState).products;
        int index = products.indexWhere(
          (e) => e.productId == event.product.productId,
        );
        if (index != -1) {
          products[index] = products[index].copyWith(
            quantity: event.product.quantity,
            substituteBrand: event.product.substituteBrand,
            substituteVariant: event.product.substituteVariant,
          );
          _repository.updateBasketProduct(event.product);
          emit(BasketViewCurrentState(basket, products));
        }
      }
    });
  }
}
