import 'package:bloc/bloc.dart';
import 'package:data_sources/auth/models/user_role.dart';
import 'package:meta/meta.dart';
import 'package:repository/shop/shopping_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'browsing_event.dart';
part 'browsing_state.dart';

class BrowsingBloc extends Bloc<BrowsingEvent, BrowsingState> {
    final ShoppingRepository _shoppingRepository;
  BrowsingBloc(this._shoppingRepository) : super(BrowsingInitial()) {
    on<ProductsSearched>((event, emit) async {
      final results = await _shoppingRepository.searchProductsAndCategories(
        event.input,
        UserRole.Ubuntunist,
        event.limit,
      );
      results.fold((l) {
        emit(BrowsingError(l));
      }, (r) {
        emit(BrowsingSearchResults(r));
      });
    });
  }
}
