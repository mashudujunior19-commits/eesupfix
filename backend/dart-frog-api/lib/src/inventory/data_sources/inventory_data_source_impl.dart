// ignore_for_file: inference_failure_on_function_invocation
import 'package:eesup_dart_frog/src/inventory/data_sources/inventory_data_source.dart';
import 'package:supabase/supabase.dart';

class InventoryDataSourceImpl implements InventoryDataSource {
  InventoryDataSourceImpl(this._client);
  final SupabaseClient _client;

  @override
  Future<dynamic> fetchCategories() async {
    final response = await _client
        .schema('inventory')
        .rpc('get_all_categories')
        .order('name', ascending: true);
    return response;
  }

  @override
  Future<dynamic> fetchCategoryDescendants(int parentId) async {
    final response = await _client
        .schema('inventory')
        .rpc('get_category_descendants', params: {
      'p_cat_id': parentId,
    }).order('name', ascending: true);
    return response;
  }

  @override
  Future<dynamic> fetchCategoryProducts(
    int id,
    String role,
    int limit,
  ) async {
    final response = await _client
        .schema('inventory')
        .rpc('get_products_by_category', params: {
      'cat_id': id,
      'role': role.toString(),
      'limit_to': limit
    }).order('name', ascending: true);

    return response;
  }

  @override
  Future<dynamic> searchProductsAndCategories(
      String query, String role, int limit) async {
    final response = await _client.schema('inventory').rpc(
      'search_products_and_categories',
      params: {'query_str': query, 'role': role.toString(), 'limit_to': limit},
    ).single();

    return response;
  }

  @override
  Future<dynamic> searchProducts(
    String query,
    String role,
    int limit,
  ) async {
    final response = await _client.schema('inventory').rpc('search_products',
        params: {
          'query_str': query,
          'role': role.toString(),
          'limit_to': limit
        });
    return response;
  }

  @override
  Future<dynamic> fetchRandomCategory() async {
    final schema = _client.schema('inventory');
    final response = await schema.rpc('get_random_category').single();
    return response;
  }

  @override
  Future<dynamic> fetchRandomProducts(String role, int limit) async {
    final response =
        await _client.schema('inventory').rpc('get_random_products', params: {
      'role': role.toString(),
      'limit_to': limit,
    });
    return response;
  }

  @override
  Future fetchProduct(int id) async {
    final response = await _client
        .schema('inventory')
        .rpc('get_product', params: {'_id': id}).single();
    return response;
  }
}
