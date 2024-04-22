import 'package:bloc/bloc.dart';
import 'package:data_sources/auth/models/user_role.dart';
import 'package:meta/meta.dart';
import 'package:repository/shop/shopping_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'product_searching_event.dart';
part 'product_searching_state.dart';

class ProductSearchingBloc
    extends Bloc<ProductSearchingEvent, ProductSearchingState> {
  final ShoppingRepository _shoppingRepository;
  ProductSearchingBloc(this._shoppingRepository)
      : super(ProductSearchingInitial()) {
    on<ProductsSearched>((event, emit) async {
      final results = await _shoppingRepository.searchProductsAndCategories(
        event.input,
        UserRole.Ubuntunist,
        event.limit,
      );
      results.fold((l) {
        emit(ProductSearchingError(l));
      }, (r) {
        emit(ProductSearchingResults(r));
      });
    });
  }
}
