import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/inventory/data_sources/inventory_data_source.dart';

class InventoryRepository {
  late final InventoryDataSource _inventoryDataSource;
  InventoryRepository(this._inventoryDataSource);

  Future<Response> fetchCategories() async {
    try {
      final results = await _inventoryDataSource.fetchCategories();
      return Response.json(
        statusCode: HttpStatus.ok,
        body: results,
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {
          'error': e.toString(),
        },
      );
    }
  }

  Future<Response> fetchCategoryDescendants(int id) async {
    try {
      final results = await _inventoryDataSource.fetchCategoryDescendants(id);
      return Response.json(
        statusCode: HttpStatus.ok,
        body: results,
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {
          'error': e.toString(),
        },
      );
    }
  }

  Future<Response> fetchCategoryProducts(
    int id,
    String role,
    int limit,
  ) async {
    try {
      final results = await _inventoryDataSource.fetchCategoryProducts(
        id,
        role,
        limit,
      );
      return Response.json(
        statusCode: HttpStatus.ok,
        body: results,
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {
          'error': e.toString(),
        },
      );
    }
  }

  Future<Response> searchProductsAndCategories(
    String query,
    String role,
    int limit,
  ) async {
    try {
      final results = await _inventoryDataSource.searchProductsAndCategories(
        query,
        role,
        limit,
      );
      return Response.json(
        statusCode: HttpStatus.ok,
        body: results,
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {
          'error': e.toString(),
        },
      );
    }
  }

    Future<Response> searchProducts(
    String query,
    String role,
    int limit,
  ) async {
    try {
      final results = await _inventoryDataSource.searchProducts(
        query,
        role,
        limit,
      );
      return Response.json(
        statusCode: HttpStatus.ok,
        body: results,
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {
          'error': e.toString(),
        },
      );
    }
  }

  Future<Response> fetchRandomCategory() async {
    try {
      final results = await _inventoryDataSource.fetchRandomCategory();
      return Response.json(
        statusCode: HttpStatus.ok,
        body: results,
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {
          'error': e.toString(),
        },
      );
    }
  }

  Future<Response> fetchRandomProducts(
    String role,
    int limit,
  ) async {
    try {
      final results =
          await _inventoryDataSource.fetchRandomProducts(role, limit);
      return Response.json(
        statusCode: HttpStatus.ok,
        body: results,
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {
          'error': e.toString(),
        },
      );
    }
  }

  Future<Response> fetchProduct(int id) async {
    try {
      final results = await _inventoryDataSource.fetchProduct(id);
      return Response.json(
        statusCode: HttpStatus.ok,
        body: results,
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {
          'error': e.toString(),
        },
      );
    }
  }
}
