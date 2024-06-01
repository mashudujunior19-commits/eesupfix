import 'package:bloc/bloc.dart';
import 'package:data/shopping/models/basket_product.dart';

class CopyingCubit extends Cubit<List<BasketProduct>> {
  CopyingCubit() : super([]);

  void select(BasketProduct p) {
    var current = [...state];
    if (!current.contains(p)) {
      current.add(p);
      emit(current);
    }
  }

  void deselect(BasketProduct p) {
    var current = [...state];
    current.remove(p);
    emit(current);
  }

  void all(bool isSelect) {
    var current = [...state];

    for (var p in current) {
      if (isSelect) {
        if (!current.contains(p)) {
          current.add(p);
        }
      } else {
        if (current.contains(p)) {
          current.remove(p);
        }
      }
    }
    emit(current);
  }
}
