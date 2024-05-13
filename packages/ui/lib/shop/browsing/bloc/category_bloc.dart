import 'package:bloc/bloc.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/shopping/models/category.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ShoppingRepository _repository;
  CategoryBloc(this._repository) : super(CategoryInitial()) {
    on<CategoryProductAndDescendentsFetched>((event, emit) async {
      emit(CategoryInitial());
      late final List<Product> products;
      late final List<Category> descendents;

      final p = await _repository.fetchCategoryProducts(
          event.id, UserRole.Ubuntunist, 50);
      final c = await _repository.fetchCategoryDecendants(event.id);

      p.fold((left) {}, (right) {
        products = right;
      });
      c.fold((left) {}, (right) {
        descendents = right;
      });
      emit(CategoryLoaded(products, descendents));
    });
  }
}
