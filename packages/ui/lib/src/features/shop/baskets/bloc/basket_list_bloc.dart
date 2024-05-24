import 'package:bloc/bloc.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/repository/basket_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'basket_list_event.dart';
part 'basket_list_state.dart';

class BasketListBloc extends Bloc<BasketListEvent, BasketListState> {
  final ShoppingRepository _repository;
  BasketListBloc(this._repository) : super(BasketListLoading()) {
    on<BasketListsFetched>((event, emit) async {
      emit(BasketListLoading());
      final results = await _repository.fetchUserBaskets();
      results.fold((left) {
        emit(BasketListError(left));
      }, (right) {
        if (right.isEmpty) {
          emit(BasketListEmpty());
        } else {
          emit(BasketListLoaded(right));
        }
      });
    });

    on<BasketDeleted>((event, emit) {
      _repository.deleteBasket(event.basket.id);
    });
  }
}
