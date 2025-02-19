import 'package:data/auth/models/user_role.dart';
import 'package:data/shopping/models/ad_banner.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/models/basket_product.dart';
import 'package:data/shopping/models/category.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/models/product_request.dart';

import '../../finance/models/profit_allocation.dart';
import '../models/hamper.dart';
import '../models/hamper_banner.dart';
import '../models/hamper_banner_details.dart';
import '../models/mapped_product_hamper.dart';

abstract class ShoppingDataSource {
  ///Fetches all parent categories
  ///Those that have no parent
  Future<List<Category>> fetchCategories();

  /// Fetches the descendants of a category, those that are children of the category
  /// And their children and so on
  /// @param parentId The id of the parent category
  Future<List<Category>> fetchCategoryDescendants(int parentId);

  /// Fetches the products of a category
  /// @param id The id of the category
  Future<List<Product>> fetchCategoryProducts(int id, UserRole role, int limit);

  Future<Product> fetchProduct(int id);

  ///Searches for categories
  Future<Map<String, dynamic>> searchProductsAndCategories(
      String query, UserRole role, int limit);

  ///Searches for products
  Future<List<Product>> searchProducts(String query, UserRole role, int limit);

  ///Get user baskets
  Future<List<Basket>> fetchUserBaskets(String userId);

  ///Get basket products
  Future<List<BasketProduct>> fetchBasketProducts(String basketId);

  ///Add product to basket
  Future<bool> addProductToBasket(String basketId, int productId);

  ///Remove product from basket
  Future<bool> removeProductFromBasket(String basketId, int productId);

  Future<bool> deleteProductFromBasket(String basketId, int productId);

  Future<bool> updateBasket(Basket basket);

  Future<bool> deleteBasket(String basketId);

  Future<bool> createBasket(String name, String userId);

  Future<Category> fetchRandomCategory();

  Future<List<Product>> fetchRandomProducts(UserRole role, int limit);

  Future<AdBanner> fetchAdBanner(int id);

  Future<List<ProductRequest>> fetchProductRequests(String userId);
  Future<bool> createProductRequest(ProductRequest request);
  Future<bool> deleteProductRequest(int id);
  Future<bool> updateBasketProduct(BasketProduct product);

  Future<bool> updateBasketProductSubstitute(
    String basketId,
    int productId,
    bool substituteBrand,
    bool substituteVariant,
  );
//hamper functions
  Future<List<Hamper>> fetchHampers(String userId);
  Future<List<Product>> fetchHamperProducts(String hamperId);
  Future<List<HamperProductDetail>> fetchHamperProductDetails(String hamperId);
  Future<Hamper?> fetchHampersByImageUrl(String imgUrl);
  Future<Map<int, int>> getProductQuantitiesForHamper(String hamperId);
  Future<HamperBanner> fetchHamperBanner(int id);
  Future<Product?> fetchHamperProduct(String hamperId);
  Future<Hamper> fetchHamperById(String hamperId);
  Future<List<HamperBannerDetail>> fetchHamperBannerDetails(int id);
  Future<ProfitAllocation> fetchProfitAllocationById(int id);
}
