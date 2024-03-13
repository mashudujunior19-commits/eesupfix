import 'package:bloc/bloc.dart';
import 'package:eesup_data_source/auth/models/user_role.dart';
import 'package:eesup_data_source/shopping/models/ad_banner.dart';
import 'package:eesup_data_source/shopping/models/category.dart';
import 'package:eesup_data_source/shopping/models/product.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';
import 'package:eesup_repository/shop/shopping_repository.dart';
import 'package:meta/meta.dart';

part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final ShoppingRepository _shoppingRepository;
  OverviewBloc(this._shoppingRepository) : super(OverviewLoading()) {
    on<OvervewLoaded>((event, emit) async {
      emit(OverviewLoading());
      late List<Category> categories;
      late List<Product> forYouProducts;
      late List<Product> popularProducts;
      late List<Product> essentialProducts;

      late AdBanner topBanner;
      late AdBanner bottomBanner;

      final cats = await _shoppingRepository.fetchCategories();
      cats.fold((ex) => emit(OverviewError(ex)), (c) => categories = c);

      final forYou = await _shoppingRepository.fetchRandomProducts(
          event.role, event.limit);

      forYou.fold((ex) => emit(OverviewError(ex)), (p) => forYouProducts = p);

      final popular = await _shoppingRepository.fetchRandomProducts(
          event.role, event.limit);

      popular.fold((ex) => emit(OverviewError(ex)), (p) => popularProducts = p);

      final essential = await _shoppingRepository.fetchRandomProducts(
          event.role, event.limit);

      essential.fold(
          (ex) => emit(OverviewError(ex)), (p) => essentialProducts = p);

      final top = await _shoppingRepository.fetchAdBanner(1);

      top.fold((ex) => emit(OverviewError(ex)), (b) => topBanner = b);

      final bottom = await _shoppingRepository.fetchAdBanner(2);

      bottom.fold((ex) => emit(OverviewError(ex)), (b) => bottomBanner = b);

      emit(
        OverviewContentsLoaded(
          categories: categories,
          forYouProducts: forYouProducts,
          popularProducts: popularProducts,
          essentialProducts: essentialProducts,
          topBanner: topBanner,
          bottomBanner: bottomBanner,
        ),
      );
    });
  }
}
