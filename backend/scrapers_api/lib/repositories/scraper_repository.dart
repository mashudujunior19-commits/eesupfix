import 'package:dart_frog/dart_frog.dart';
import 'package:scrapers_api/data/models/checkers_product.dart';
import 'package:scrapers_api/data/models/kit_kat_product.dart';
import 'package:scrapers_api/data/models/makro_product.dart';
import 'package:scrapers_api/data/models/pnp_product.dart';
import 'package:scrapers_api/data/models/product_reference.dart';
import 'package:scrapers_api/data/providers/scraper_provider.dart';

class ScraperRepository {
  ///remove the ZAR from the string
  double _removeZar(String input) {
    final newString = input.replaceAll('ZAR', '');
    final newString2 = newString.trim();
    return double.tryParse(newString2) ?? 0.00;
  }

  ///remove the R from the string
  double _removeRand(String input) {
    final newString = input.replaceAll('R', '');
    final newString2 = newString.trim();
    return double.tryParse(newString2) ?? 0.00;
  }

  ///get the amount from the string
  double _getAmount(String input) {
    if (input.contains('ZAR')) {
      return _removeZar(input);
    } else if (input.contains('R')) {
      return _removeRand(input);
    } else {
      return double.tryParse(input) ?? 0.00;
    }
  }

  Future<Response> uploadProduct(Map<String, dynamic> product) async {
    try {
      final source = product['source'].toString();

      switch (source) {
        case 'Checkers':
          //map the product to a checkers product
          final newProduct = CheckersProduct.fromJson(product);
          final originalPrice = _getAmount(newProduct.originalPrice ?? '0.00');
          if (originalPrice > 0.00) {
            final productRef = ScraperProduct(
              source: source,
              scrapeDate: DateTime.now(),
              barCode: newProduct.barcode,
              brand: newProduct.brand,
              description: newProduct.description,
              priceCategory: 'SP',
              additional1: newProduct.productSpecs,
              offerPrice: newProduct.offerPrice,
              category: newProduct.category,
              name: newProduct.productTitle,
              ingredients: newProduct.productSpecs,
              originalPrice: originalPrice,
              keyword: newProduct.keyword,
            );
            final res = await _upload('checkers', productRef);
            return res;
          }
        case 'Shoprite':

          //map the product to a checkers product
          final newProduct = CheckersProduct.fromJson(product);
          final originalPrice = _getAmount(newProduct.originalPrice ?? '0.00');
          if (originalPrice > 0.00) {
            final productRef = ScraperProduct(
              source: source,
              scrapeDate: DateTime.now(),
              barCode: newProduct.barcode,
              brand: newProduct.brand,
              description: newProduct.description,
              priceCategory: 'SP',
              additional1: newProduct.productSpecs,
              offerPrice: newProduct.offerPrice,
              category: newProduct.category,
              name: newProduct.productTitle,
              ingredients: newProduct.productSpecs,
              originalPrice: originalPrice,
              keyword: newProduct.keyword,
            );
            final res = await _upload('checkers', productRef);
            return res;
          }
        case 'Pick n Pay':
          //map the product to a pick n pay product
          final newProduct = PnPProduct.fromJson(product);
          final originalPrice = _getAmount(newProduct.originalPrice ?? '0.00');
          if (originalPrice > 0.00) {
            final productRef = ScraperProduct(
              source: 'Pick n Pay',
              scrapeDate: DateTime.now(),
              region: newProduct.region,
              description: newProduct.description,
              barCode: newProduct.barcode,
              priceCategory: 'SP',
              offerPrice: newProduct.offerPrice,
              name: newProduct.productTitle,
              originalPrice: originalPrice,
              usage: newProduct.description,
              keyword: newProduct.keyword,
            );
            final res = await _upload('pnp', productRef);
            return res;
          }
        case 'Makro':
          //map the product to a wMakrooolworths product
          final newProduct = MakroProduct.fromJson(product);
          final originalPrice = _getAmount(newProduct.originalPrice ?? '0.00');
          if (originalPrice > 0.00) {
            // ignore: unused_local_variable
            final productRef = ScraperProduct(
              source: 'Makro',
              scrapeDate: DateTime.now(),
              barCode: newProduct.gtin,
              brand: newProduct.brand,
              affiliation: newProduct.affiliation,
              region: newProduct.store,
              priceCategory: 'CP',
              offerPrice: newProduct.offerPrice,
              name: newProduct.productName,
              originalPrice: originalPrice,
              url: newProduct.productPageUrl,
              promotion: newProduct.promotion,
              sourceCode: newProduct.sku,
              additional1: newProduct.productAndPackaging,
              category: newProduct.categories,
              keyword: newProduct.keyword,
            );
            final res = await _upload('makro', productRef);
            return res;
          }
        case 'Kit Kat':
          //map the product to a woolworths product
          final newProduct = KitKatProduct.fromJson(product);
          final originalPrice = _getAmount(newProduct.originalPrice ?? '0.00');
          if (originalPrice > 0.00) {
            final productRef = ScraperProduct(
              source: 'Kit Kat',
              scrapeDate: DateTime.now(),
              kitKatRef: newProduct.code,
              description: newProduct.description,
              priceCategory: 'CP',
              offerPrice: newProduct.offer,
              name: newProduct.productName,
              originalPrice: originalPrice,
              usage: newProduct.description,
              keyword: newProduct.keyword,
            );
            final res = await _upload('kit_kat', productRef);
            return res;
          }
      }
    } catch (e) {
      return Response.json(body: {'error': e.toString()}, statusCode: 500);
    }

    return Response.json(
      body: {'error': 'Unsupported Source'},
      statusCode: 500,
    );
  }

  Future<Response> _upload(String table, ScraperProduct product) async {
    final dt = ScraperDataProvider();
    final success = await dt.submitProduct(table, product);
    if (success) {
      return Response.json(
        body: {'message': 'Product uploaded and verified'},
      );
    }
    return Response.json(
      body: {'message': 'Failed to upload product'},
      statusCode: 500,
    );
  }
}
