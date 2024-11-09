// import 'package:bloc/bloc.dart';
// import 'package:data/auth/models/user_role.dart';
// import 'package:data/shopping/models/ad_banner.dart';
// import 'package:data/shopping/models/category.dart';
// import 'package:data/shopping/models/product.dart';
// import 'package:data/shopping/repository/shopping_repository.dart';
// import 'package:data/utils/eesup_exception.dart';
// import 'package:meta/meta.dart';

// part 'overview_event.dart';
// part 'overview_state.dart';

// class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
//   final ShoppingRepository _shoppingRepository;
//   OverviewBloc(this._shoppingRepository) : super(OverviewLoading()) {
//     on<OvervewLoaded>((event, emit) async {
//       emit(OverviewLoading());
//       late List<Category> categories;
//       late List<Product> forYouProducts;
//       late List<Product> popularProducts;
//       late List<Product> essentialProducts;

//       late AdBanner topBanner;
//       late AdBanner bottomBanner;

//       final cats = await _shoppingRepository.fetchCategories();
//       cats.fold((ex) => emit(OverviewError(ex)), (c) => categories = c);

//       final forYou = await _shoppingRepository.fetchRandomProducts(
//           event.role, event.limit);

//       forYou.fold((ex) => emit(OverviewError(ex)), (p) => forYouProducts = p);

//       final popular = await _shoppingRepository.fetchRandomProducts(
//           event.role, event.limit);

//       popular.fold((ex) => emit(OverviewError(ex)), (p) => popularProducts = p);

//       final essential = await _shoppingRepository.fetchRandomProducts(
//           event.role, event.limit);

//       essential.fold(
//           (ex) => emit(OverviewError(ex)), (p) => essentialProducts = p);

//       final top = await _shoppingRepository.fetchAdBanner(1);

//       top.fold((ex) => emit(OverviewError(ex)), (b) => topBanner = b);

//       final bottom = await _shoppingRepository.fetchAdBanner(2);

//       bottom.fold((ex) => emit(OverviewError(ex)), (b) => bottomBanner = b);

//       emit(
//         OverviewContentsLoaded(
//           categories: categories,
//           forYouProducts: forYouProducts,
//           popularProducts: popularProducts,
//           essentialProducts: essentialProducts,
//           topBanner: topBanner,
//           bottomBanner: bottomBanner,
//         ),
//       );
//     });
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/shopping/models/category.dart';
import 'package:data/shopping/models/hamper_banner.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';
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

      late HamperBanner topBanner;
      late HamperBanner bottomBanner;

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

      final top = await _shoppingRepository.fetchHamperBanner(3);

      top.fold((ex) => emit(OverviewError(ex)), (d) => topBanner = d);

      final bottom = await _shoppingRepository.fetchHamperBanner(3);
      bottom.fold((ex) => emit(OverviewError(ex)), (d) => bottomBanner = d);

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
