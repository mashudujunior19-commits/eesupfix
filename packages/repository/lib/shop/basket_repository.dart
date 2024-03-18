import 'package:dartz/dartz.dart';
import 'package:data_sources/shopping/models/basket.dart';
import 'package:data_sources/shopping/models/basket_product.dart';
import 'package:repository/shop/shopping_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

extension BasketRepository on ShoppingRepository {
  Future<Either<EESUpException, List<Basket>>> fetchUserBaskets() async {
    final result = await authRepository.executeFutureWithAuth((id) async {
      final baskets = await shoppingDataSrc.fetchUserBaskets(id);
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) {
      final nonNullBaskets =
          baskets.where((element) => element.type != null).toList();
      final nullBaskets =
          baskets.where((element) => element.type == null).toList();

      final newList = [...nonNullBaskets, ...nullBaskets];

      return Right(newList);
    });
  }

  Future<Either<EESUpException, List<BasketProduct>>> fetchBasketProducts(
      String basketId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final baskets = await shoppingDataSrc.fetchBasketProducts(basketId);
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) => Right(baskets));
  }

  Future<Either<EESUpException, bool>> addProductToBasket(
      String basketId, int productId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final baskets = await shoppingDataSrc.addProductToBasket(
        basketId,
        productId,
      );
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) => Right(baskets));
  }

  Future<Either<EESUpException, bool>> removeProductFromBasket(
      String basketId, int productId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final baskets = await shoppingDataSrc.removeProductFromBasket(
        basketId,
        productId,
      );
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) => Right(baskets));
  }

  Future<Either<EESUpException, bool>> deleteProductFromBasket(
      String basketId, int productId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final baskets = await shoppingDataSrc.deleteProductFromBasket(
        basketId,
        productId,
      );
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) => Right(baskets));
  }

  Future<Either<EESUpException, bool>> updateBasket(Basket basket) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final baskets = await shoppingDataSrc.updateBasket(basket);
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) => Right(baskets));
  }

  Future<Either<EESUpException, bool>> deleteBasket(String basketId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final baskets = await shoppingDataSrc.deleteBasket(basketId);
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) => Right(baskets));
  }

  Future<Either<EESUpException, bool>> createBasket(String name) async {
    final result = await authRepository.executeFutureWithAuth((id) async {
      final baskets = await shoppingDataSrc.createBasket(name, id);
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) => Right(baskets));
  }

  Future<Either<EESUpException, bool>> updateBasketProductSubstitute(
    String basketId,
    int productId,
    bool brand,
    bool variant,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final baskets = await shoppingDataSrc.updateBasketProductSubstitute(
        basketId,
        productId,
        brand,
        variant,
      );
      return baskets;
    });
    return result.fold((ex) => Left(ex), (baskets) => Right(baskets));
  }
}
