import 'package:data/auth/models/user_role.dart';
import 'package:data/shopping/data_source/shopping_data_source.dart';
import 'package:data/shopping/models/ad_banner.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/models/basket_product.dart';
import 'package:data/shopping/models/category.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/models/product_request.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/hamper.dart';
import '../models/hamper_banner.dart';
import '../models/hamper_product.dart';
import '../models/mapped_product_hamper.dart';

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
    try {
      await _client.schema('public').rpc('add_product_to_basket', params: {
        '_basket_id': basketId,
        '_product_id': productId,
      });
      return true;
    } catch (e) {
      return false;
    }
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
    try {
      await _client.schema('public').from('basket').insert({
        'name': name,
        'user_id': userId,
      });
      return true;
    } catch (e) {
      return false;
    }
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
  Future<List<Hamper>> fetchHampers(String userId) async {
    try {
      final response = await _client
          .schema('inventory')
          .from('hamper')
          .select('*')
          .eq('is_final', true)
          .gte('expiry_date', DateTime.now().toIso8601String())
          .order('created_at', ascending: false);

      final List data = response as List;

      final List<Hamper> hampers =
          data.map((json) => Hamper.fromJson(json)).toList();

      for (int i = 0; i < hampers.length; i++) {
        final productIds = await getProductIdsForHamper(hampers[i].id);
        final quantities = await getProductQuantitiesForHamper(hampers[i].id);

        hampers[i] = hampers[i].copyWith(
          productIds: productIds,
          quantity: quantities,
        );
      }
      return hampers;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Hamper> fetchHamperById(String hamperId) async {
    try {
      final response = await _client
          .schema('inventory')
          .from('hamper')
          .select('*')
          .eq('id', hamperId)
          .single();

      final Map<String, dynamic> data = response;

      final hamper = Hamper.fromJson(data);
      return hamper;
    } catch (e) {
      throw Exception('Failed to fetch hamper: $e');
    }
  }

  Future<List<int>> getProductIdsForHamper(String hamperId) async {
    try {
      final response = await _client
          .schema('inventory')
          .from('hamper_product')
          .select('product_id')
          .eq('hamper_id', hamperId);
      final List data = response as List;
      return data.map((json) => json['product_id'] as int).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Product>> fetchHamperProducts(String hamperId) async {
    try {
      final response = await _client
          .schema('inventory')
          .from('hamper_product')
          .select('product_id')
          .eq('hamper_id', hamperId);

      final List productIds =
          (response as List).map((json) => json['product_id'] as int).toList();

      final productResponse =
          await _client.from('products').select('*').eq('id', productIds);

      return (productResponse as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<HamperProductDetail>> fetchHamperProductDetails(
      String hamperId) async {
    try {
      final response = await _client
          .schema('inventory')
          .from('hamper_product')
          .select('*')
          .eq('hamper_id', hamperId);
      final hamperProducts = (response as List).map((json) {
        return HamperProduct(
          hamperId: hamperId,
          productId: json['product_id'],
          quantity: json['quantity'],
          isFree: json['is_free'],
        );
      }).toList();

      List<HamperProductDetail> hamperProductDetails = [];

      for (var hamperProduct in hamperProducts) {
        final productResponse = await _client
            .schema('inventory')
            .from('product')
            .select('*')
            .eq('id', hamperProduct.productId);

        if (productResponse.isNotEmpty) {
          final product = Product.fromJson(productResponse.first);

          hamperProductDetails.add(HamperProductDetail(
            hamperId: hamperProduct.hamperId,
            productId: hamperProduct.productId,
            quantity: hamperProduct.quantity,
            isFree: hamperProduct.isFree,
            name: product.name,
            brand: product.brand ?? '',
            type: product.type ?? '',
            imageUrl: product.imageUrl ?? '',
            salePrice: product.salePrice,
            costPrice: product.costPrice!,
            product: product,
          ));
        }
      }
      return hamperProductDetails;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Hamper?> fetchHampersByImageUrl(String imgUrl) async {
    try {
      final response = await _client
          .schema('inventory')
          .from('hamper')
          .select()
          .eq('img_url', imgUrl)
          .limit(1)
          .order('created_at', ascending: true)
          .maybeSingle();

      if (response == null || response.isEmpty) {
        return null;
      }

      Hamper hamper = Hamper.fromJson(response);

      final productIds = await getProductIdsForHamper(hamper.id);
      final quantities = await getProductQuantitiesForHamper(hamper.id);
      hamper = hamper.copyWith(
        productIds: productIds,
        quantity: quantities,
      );

      return hamper;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<int, int>> getProductQuantitiesForHamper(String hamperId) async {
    try {
      final response = await _client
          .schema('inventory')
          .from('hamper_product')
          .select('product_id, quantity')
          .eq('hamper_id', hamperId);
      final List data = response as List;

      return {
        for (var json in data)
          json['product_id'] as int: json['quantity'] as int
      };
    } catch (e) {
      return {};
    }
  }

  @override
  Future<Product?> fetchHamperProduct(String hamperId) async {
    try {
      final response = await _client
          .schema('inventory')
          .from('product')
          .select()
          .eq('hamper_id', hamperId);
      if (response.isNotEmpty) {
        final json = response.first;
        return Product.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
