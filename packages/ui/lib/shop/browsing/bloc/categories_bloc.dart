import 'package:bloc/bloc.dart';
import 'package:data/shopping/models/category.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ShoppingRepository _shoppingRepository;
  CategoriesBloc(this._shoppingRepository) : super(CategoriesInitial()) {
    on<CategoriesFetched>((event, emit) async {
      final results = await _shoppingRepository.fetchCategories();
      results.fold((l) {}, (r) {
        emit(CategoriesLoaded(r));
      });
    });
  }
}
