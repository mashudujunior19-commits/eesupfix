import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/auth/application/auth_services.dart';
import 'package:eesup_dart_frog/src/auth/data/data_source/auth_supabase_impl.dart';
import 'package:eesup_dart_frog/src/inventory/data_sources/inventory_data_source_impl.dart';
import 'package:eesup_dart_frog/src/inventory/inventory_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final request = context.request;

    if (request.method.value != 'GET') {
      return Response.json(
        statusCode: HttpStatus.methodNotAllowed,
        body: {
          'status': 'error',
          'message': 'Method not allowed',
        },
      );
    }

    final headers = request.headers;
    final key = headers['x-api-key'];

    if (key == null) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {
          'status': 'error',
          'message': 'Not authorized to access this resource,{invalid api key}',
        },
      );
    }

    final supabase = GetIt.I.get<SupabaseClient>();
    final auth = AuthServices(AuthSupabaseImpl(supabase));
    final authrized = await auth.authorized(key: key);

    if (!authrized) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {
          'status': 'error',
          'message': 'Not authorized to access this resource,{invalid api key}',
        },
      );
    }

    final inventoryDataSource = InventoryDataSourceImpl(supabase);
    final inventoryRepository = InventoryRepository(inventoryDataSource);

    if (!GetIt.I.isRegistered<InventoryRepository>()) {
      GetIt.I.registerSingleton(inventoryRepository);
    }

    // Forward the request to the respective handler.
    final response = await handler(context);
    // Return a response.
    return response;
  };
}
