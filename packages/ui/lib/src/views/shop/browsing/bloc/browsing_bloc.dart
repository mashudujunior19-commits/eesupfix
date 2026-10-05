import 'package:bloc/bloc.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'browsing_event.dart';
part 'browsing_state.dart';

class BrowsingBloc extends Bloc<BrowsingEvent, BrowsingState> {
  final ShoppingRepository _shoppingRepository;
  /// The most recent query. Searches run as the user types, so a slow
  /// response for an earlier query must not replace newer results.
  String? _latestQuery;

  BrowsingBloc(this._shoppingRepository) : super(BrowsingInitial()) {
    on<SearchCleared>((event, emit) {
      _latestQuery = null;
      emit(BrowsingInitial());
    });

    on<ProductsSearched>((event, emit) async {
      final query = event.input.trim();
      _latestQuery = query;
      emit(BrowsingSearching());
      final results = await _shoppingRepository.searchProductsAndCategories(
        query,
        UserRole.Ubuntunist,
        event.limit,
      );
      if (query != _latestQuery) return;
      results.fold((l) {
        emit(BrowsingError(l));
      }, (r) {
        emit(BrowsingSearchResults(r));
      });
    });
  }
}
