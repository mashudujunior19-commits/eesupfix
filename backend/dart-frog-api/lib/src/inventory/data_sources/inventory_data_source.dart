abstract class InventoryDataSource {
  ///Fetches all parent categories
  ///Those that have no parent
  Future<dynamic> fetchCategories();

  /// Fetches the descendants of a category, those that are children of the category
  /// And their children and so on
  /// @param parentId The id of the parent category
  Future<dynamic> fetchCategoryDescendants(int parentId);

  /// Fetches the products of a category
  /// @param id The id of the category
  Future<dynamic> fetchCategoryProducts(int id, String role, int limit);

  ///Searches for categories
  Future<dynamic> searchProductsAndCategories(
      String query, String role, int limit);

  ///Searches for products
  Future<dynamic> searchProducts(String query, String role, int limit);

  Future<dynamic> fetchRandomCategory();

  Future<dynamic> fetchRandomProducts(String role, int limit);

  Future<dynamic> fetchProduct(int id);
}
