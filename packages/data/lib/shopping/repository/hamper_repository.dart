import 'package:either_dart/either.dart';
import 'package:data/shopping/models/product.dart';
import '../models/hamper.dart';
import '../models/mapped_product_hamper.dart';
import 'shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';

extension HamperRepository on ShoppingRepository {
  Future<Either<EESUpException, List<Hamper>>> fetchHampers() async {
    final result = await authRepository.executeFutureWithAuth((id) async {
      final hampers = await shoppingDataSrc.fetchHampers(id);
      return hampers;
    });
    return result.fold((ex) => Left(ex), (hampers) => Right(hampers));
  }

  Future<Either<EESUpException, List<Product>>> fetchHamperProducts(
      String hamperId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final products = await shoppingDataSrc.fetchHamperProducts(hamperId);
      return products;
    });
    return result.fold((ex) => Left(ex), (products) => Right(products));
  }

  Future<Either<EESUpException, Hamper>> fetchHampersByImageUrl(
      String imgUrl) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final hampers = await shoppingDataSrc.fetchHampersByImageUrl(imgUrl);
      return hampers;
    });
    return result.fold((ex) => Left(ex), (hampers) => Right(hampers!));
  }

  Future<Either<EESUpException, List<HamperProductDetail>>>
      fetchHamperProductDetails(String hamperId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final products =
          await shoppingDataSrc.fetchHamperProductDetails(hamperId);
      return products;
    });
    return result.fold((ex) => Left(ex), (products) => Right(products));
  }

  Future<Either<EESUpException, Map<int, int>>> getProductQuantitiesForHamper(
      String hamperId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final quantities =
          await shoppingDataSrc.getProductQuantitiesForHamper(hamperId);
      return quantities;
    });
    return result.fold((ex) => Left(ex), (quantities) => Right(quantities));
  }

  Future<bool> compareHamperProductsWithCart(
      String hamperId, Map<int, int> cartProducts) async {
    final result = await getProductQuantitiesForHamper(hamperId);

    return result.fold((error) {
      return false;
    }, (hamperProducts) {
      return hamperProducts.keys.every((productId) =>
          cartProducts.containsKey(productId) &&
          cartProducts[productId] == hamperProducts[productId]);
    });
  }

  Future<Either<EESUpException, Product?>> fetchHamperProduct(
      String hamperId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final product = await shoppingDataSrc.fetchHamperProduct(hamperId);
      return product;
    });
    return result.fold((ex) => Left(ex), (product) => Right(product));
  }

  Future<Either<EESUpException, Hamper>> fetchHamperById(
      String hamperId) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final hamper = await shoppingDataSrc.fetchHamperById(hamperId);
      return hamper;
    });
    return result.fold((ex) => Left(ex), (hamper) => Right(hamper));
  }
}
