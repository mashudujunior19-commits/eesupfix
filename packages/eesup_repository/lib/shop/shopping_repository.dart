import 'package:dartz/dartz.dart';
import 'package:eesup_data_source/auth/models/user_role.dart';
import 'package:eesup_data_source/shopping/data_sources/shopping_data_source.dart';
import 'package:eesup_data_source/shopping/models/ad_banner.dart';
import 'package:eesup_data_source/shopping/models/category.dart';
import 'package:eesup_data_source/shopping/models/product.dart';
import 'package:eesup_data_source/shopping/models/product_request.dart';
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';

class ShoppingRepository {
  final ShoppingDataSource shoppingDataSrc;
  final AuthRepository authRepository;

  ShoppingRepository(this.shoppingDataSrc, this.authRepository);

  Future<Either<EESUpException, List<Category>>> fetchCategories() async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final cats = await shoppingDataSrc.fetchCategories();
      return cats;
    });
    return result.fold((ex) => Left(ex), (cats) => Right(cats));
  }

  Future<Either<EESUpException, List<Category>>> fetchCategoryDecendants(
    int id,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final cats = await shoppingDataSrc.fetchCategoryDescendants(id);
      return cats;
    });
    return result.fold((ex) => Left(ex), (cats) => Right(cats));
  }

  Future<Either<EESUpException, Product>> fetchProduct(int id) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final p = await shoppingDataSrc.fetchProduct(id);
      return p;
    });
    return result.fold((ex) => Left(ex), (p) => Right(p));
  }

  Future<Either<EESUpException, List<Product>>> fetchCategoryProducts(
    int id,
    UserRole role,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final products = await shoppingDataSrc.fetchCategoryProducts(
        id,
        role,
        limit,
      );
      return products;
    });
    return result.fold((ex) => Left(ex), (products) => Right(products));
  }

  Future<Either<EESUpException, List<Product>>> searchProducts(
    String query,
    UserRole role,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final products = await shoppingDataSrc.searchProducts(query, role, limit);
      return products;
    });
    return result.fold((ex) => Left(ex), (products) => Right(products));
  }

  Future<Either<EESUpException, Map<String, dynamic>>>
      searchProductsAndCategories(
    String query,
    UserRole role,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final products = await shoppingDataSrc.searchProductsAndCategories(
        query,
        role,
        limit,
      );
      return products;
    });
    return result.fold((ex) => Left(ex), (products) => Right(products));
  }

  Future<Either<EESUpException, Category>> fetchRandomCategory() async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final cats = await shoppingDataSrc.fetchRandomCategory();
      return cats;
    });
    return result.fold((ex) => Left(ex), (cats) => Right(cats));
  }

  Future<Either<EESUpException, List<Product>>> fetchRandomProducts(
    UserRole role,
    int limit,
  ) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final prods = await shoppingDataSrc.fetchRandomProducts(role, limit);
      return prods;
    });
    return result.fold((ex) => Left(ex), (prods) => Right(prods));
  }

  Future<Either<EESUpException, AdBanner>> fetchAdBanner(int id) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final ads = await shoppingDataSrc.fetchAdBanner(id);
      return ads;
    });
    return result.fold((ex) => Left(ex), (ads) => Right(ads));
  }

  Future<Either<EESUpException, bool>> createRequest(
      ProductRequest request) async {
    final result = await authRepository.executeFutureWithAuth((id) async {
      final success = await shoppingDataSrc
          .createProductRequest(request.copyWith(userId: id));
      return success;
    });
    return result.fold((ex) => Left(ex), (success) => Right(success));
  }

  Future<Either<EESUpException, List<ProductRequest>>>
      fetchProductRequests() async {
    final result = await authRepository.executeFutureWithAuth((id) async {
      final success = await shoppingDataSrc.fetchProductRequests(id);
      return success;
    });
    return result.fold((ex) => Left(ex), (success) => Right(success));
  }

  Future<Either<EESUpException, bool>> deleteRequest(int id) async {
    final result = await authRepository.executeFutureWithAuth((_) async {
      final success = await shoppingDataSrc.deleteProductRequest(id);
      return success;
    });
    return result.fold((ex) => Left(ex), (success) => Right(success));
  }
}
