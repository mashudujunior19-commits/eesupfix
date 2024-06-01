import 'package:bloc/bloc.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';

class SearchProductsCubit extends Cubit<List<Product>> {
  final ShoppingRepository _repository;
  SearchProductsCubit(this._repository) : super([]);
  Future<void> search(String query) async {
    final results = await _repository.searchProducts(
      query,
      UserRole.Ubuntunist,
      50,
    );
    results.fold((l) {}, (r) {
      emit(r);
    });
  }
}
