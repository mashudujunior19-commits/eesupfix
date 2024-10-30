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

  Future<Either<EESUpException, List<Hamper>>> fetchHampersByImageUrl(
      String imgUrl) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final hampers = await shoppingDataSrc.fetchHampersByImageUrl(imgUrl);
      return hampers;
    });
    return result.fold((ex) => Left(ex), (hampers) => Right(hampers));
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
}
