import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/inventory/inventory_repository.dart';
import 'package:get_it/get_it.dart';

Future<Response> onRequest(RequestContext context) async {
  final params = context.request.uri.queryParameters;
  final id = int.tryParse(params['id'] ?? '');
  final role = params['role'];
  final limit = int.tryParse(params['limit'] ?? '');

  if (role == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'status': 'error',
        'message': 'Invalid role',
      },
    );
  }

  if (limit == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'status': 'error',
        'message': 'Invalid limit',
      },
    );
  }

  if (id == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'status': 'error',
        'message': 'Invalid category id',
      },
    );
  }

  final inventoryRepository = GetIt.I.get<InventoryRepository>();
  return await inventoryRepository.fetchCategoryProducts(id, role, limit);
}
