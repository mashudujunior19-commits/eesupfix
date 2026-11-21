// ignore_for_file: unnecessary_null_comparison
import 'package:data/auth/models/user_role.dart';
import 'package:data/finance/models/profit_allocation.dart';
import 'package:data/shopping/data_source/shopping_data_source.dart';
import 'package:data/shopping/models/ad_banner.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/models/basket_product.dart';
import 'package:data/shopping/models/category.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/models/product_request.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/hamper_banner.dart';
import '../models/hamper_banner_details.dart';
import '../models/hamper_builder_item.dart';
import '../models/hamper_offer.dart';

class ShoppingSupabaseImp implements ShoppingDataSource {
  final SupabaseClient _client;
  ShoppingSupabaseImp(this._client);

  @override
  Future<List<Category>> fetchCategories() async {
    final response = await _client
        .schema('inventory')
        .rpc('get_all_categories')
        .order('name', ascending: true);
    return (response as List).map((e) => Category.fromJson(e)).toList();
  }

  @override
  Future<List<Category>> fetchCategoryDescendants(int parentId) async {
    final response = await _client
        .schema('inventory')
        .rpc('get_category_descendants', params: {
      'p_cat_id': parentId,
    }).order('name', ascending: true);
    return (response as List).map((e) => Category.fromJson(e)).toList();
  }

  @override
  Future<List<Product>> fetchCategoryProducts(
    int id,
    UserRole role,
    int limit,
  ) async {
    final response = await _client
        .schema('inventory')
        .rpc('get_products_by_category', params: {
      'cat_id': id,
      'role': role.toString(),
      'limit_to': limit
    }).order('name', ascending: true);
    return (response as List).map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<Map<String, dynamic>> searchProductsAndCategories(
    String query,
    UserRole role,
    int limit,
  ) async {
    final response = await _client.schema('inventory').rpc(
      'search_products_and_categories',
      params: {'query_str': query, 'role': role.toString(), 'limit_to': limit},
    ).single();

    final products =
        (response['products'] as List).map((e) => Product.fromJson(e)).toList();
    final categories = (response['categories'] as List)
        .map((e) => Category.fromJson(e))
        .toList();
    return {'products': products, 'categories': categories};
  }

  @override
  Future<Product> fetchProduct(int id) async {
    final response = await _client
        .schema('inventory')
        .rpc('get_product', params: {'_id': id}).single();
    return Product.fromJson(response);
  }

  @override
  Future<List<Product>> searchProducts(
    String query,
    UserRole role,
    int limit,
  ) async {
    final response = await _client.schema('inventory').rpc('search_products',
        params: {
          'query_str': query,
          'role': role.toString(),
          'limit_to': limit
        });
    return (response as List).map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<List<BasketProduct>> fetchBasketProducts(String basketId) async {
    final response = await _client
        .schema('public')
        .rpc('get_basket_products_v2', params: {'_basket_id': basketId});
    return (response as List).map((e) => BasketProduct.fromJson(e)).toList();
  }

  @override
  Future<List<Basket>> fetchUserBaskets(String userId) async {
    final response = await _client
        .schema('public')
        .from('basket')
        .select()
        .eq('user_id', userId);
    return response.map((e) => Basket.fromJson(e)).toList();
  }

  @override
  Future<bool> addProductToBasket(String basketId, int productId) async {
    await _client.schema('public').rpc('add_product_to_basket', params: {
      '_basket_id': basketId,
      '_product_id': productId,
    });
    return true;
  }

  @override
  Future<bool> removeProductFromBasket(
    String basketId,
    int productId,
  ) async {
    try {
      await _client.schema('public').rpc('remove_product_from_basket', params: {
        '_basket_id': basketId,
        '_product_id': productId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteProductFromBasket(
    String basketId,
    int productId,
  ) async {
    try {
      await _client
          .schema('public')
          .from('basket_product')
          .delete()
          .eq('basket_id', basketId)
          .eq('product_id', productId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateBasket(Basket basket) async {
    try {
      await _client.schema('public').from('basket').update({
        'name': basket.name,
        'type': basket.type?.name,
      }).eq('id', basket.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> createBasket(String name, String userId) async {
    // Errors propagate so the user is told the basket wasn't created,
    // instead of a "created successfully" message for a basket that
    // doesn't exist.
    await _client.schema('public').from('basket').insert({
      'name': name,
      'user_id': userId,
    });
    return true;
  }

  @override
  Future<bool> deleteBasket(String basketId) async {
    try {
      await _client.schema('public').from('basket').delete().eq('id', basketId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Category> fetchRandomCategory() async {
    final schema = _client.schema('inventory');
    final response = await schema.rpc('get_random_category').single();
    return Category.fromJson(response);
  }

  @override
  Future<List<Product>> fetchRandomProducts(UserRole role, int limit) async {
    final response =
        await _client.schema('inventory').rpc('get_random_products', params: {
      'role': role.toString(),
      'limit_to': limit,
    });
    return (response as List).map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<AdBanner> fetchAdBanner(int id) async {
    final response = await _client
        .schema('engagements')
        .from('banner')
        .select()
        .eq('id', id)
        .single();
    return AdBanner.fromJson(response);
  }

  @override
  Future<HamperBanner> fetchHamperBanner(int id) async {
    final response = await _client
        .schema('engagements')
        .from('banner')
        .select()
        .eq('id', id)
        .single();
    return HamperBanner.fromJson(response);
  }

  @override
  Future<List<HamperBannerDetail>> fetchHamperBannerDetails(int id) async {
    try {
      final response = await _client
          .schema('engagements')
          .rpc('get_hamper_banner_details', params: {'banner_id': id});

      if (response == null) return [];
      if (response is! List) {
        throw Exception('Unexpected response structure: $response');
      }
      return response
          .whereType<Map>()
          .map((e) => HamperBannerDetail.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      throw Exception('An error occurred while fetching hamper banner details');
    }
  }

  @override
  Future<bool> createProductRequest(ProductRequest request) async {
    try {
      await _client
          .schema('inventory')
          .from('product_request')
          .insert(request.toJson());
      return true;
    } catch (e) {
      if (foundation.kDebugMode) {
        // ignore: avoid_print
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<List<ProductRequest>> fetchProductRequests(String userId) async {
    final response = await _client
        .schema('inventory')
        .from('product_request')
        .select()
        .eq('user_id', userId);
    return response.map((e) => ProductRequest.fromJson(e)).toList();
  }

  @override
  Future<bool> deleteProductRequest(int id) async {
    try {
      await _client
          .schema('inventory')
          .from('product_request')
          .delete()
          .eq('id', id);
      return true;
    } catch (e) {
      if (foundation.kDebugMode) {
        // ignore: avoid_print
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<bool> updateBasketProductSubstitute(
    String basketId,
    int productId,
    bool substituteBrand,
    bool substituteVariant,
  ) async {
    try {
      await _client
          .schema('public')
          .from('basket_product')
          .update({
            'substitute_brand': substituteBrand,
            'substitute_variant': substituteVariant,
          })
          .eq('basket_id', basketId)
          .eq('product_id', productId);
      return true;
    } catch (e) {
      if (foundation.kDebugMode) {
        // ignore: avoid_print
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<bool> updateBasketProduct(BasketProduct product) async {
    try {
      await _client
          .schema('public')
          .from('basket_product')
          .update({
            'quantity': product.quantity,
            'substitute_brand': product.substituteBrand,
            'substitute_variant': product.substituteVariant,
          })
          .eq('basket_id', product.basketId)
          .eq('product_id', product.productId);
      return true;
    } catch (e) {
      if (foundation.kDebugMode) {
        // ignore: avoid_print
        print(e.toString());
      }
      return false;
    }
  }

  @override
  Future<List<HamperOffer>> fetchHamperOffers({String? hamperId}) async {
    // One call returns every hamper this user may see, with what is inside.
    // Errors are thrown so the screen can show them and offer a retry.
    final response = await _client.rpc(
      'get_hampers',
      params: {'_hamper_id': hamperId},
    );
    if (response is! List) {
      throw Exception('Unexpected hampers response');
    }
    return response
        .whereType<Map>()
        .map((e) => HamperOffer.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<List<HamperBuilderItem>> fetchHamperBuilderItems() async {
    final response = await _client.rpc('get_hamper_builder');
    if (response is! List) {
      throw Exception('Unexpected hamper builder response');
    }
    return response
        .whereType<Map>()
        .map((e) => HamperBuilderItem.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<ProfitAllocation> fetchProfitAllocationById(int id) async {
    try {
      final response = await _client
          .schema('finances')
          .from('profit_allocation')
          .select('*')
          .eq('id', id)
          .single();

      final Map<String, dynamic> data = response;

      final profitAllocation = ProfitAllocation.fromJson(data);
      return profitAllocation;
    } catch (e) {
      throw Exception('Failed to fetch profit Allocation: $e');
    }
  }
}
