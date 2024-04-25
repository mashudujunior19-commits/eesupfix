import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/core/utils/query_string_to_map.dart';
import 'package:eesup_dart_frog/src/auth/data/providers/auth_supabase_impl.dart';
import 'package:eesup_dart_frog/src/auth/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final request = context.request;
    final queryParams = queryStringToMap(await request.body());
    final authKey = queryParams['payeeCategory3'];

    print(authKey);

    if (authKey == null) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {
          'status': 'error',
          'message': 'You are not authorized to access this'
              ' resource,{missing or invalid api key}',
        },
      );
    }

    final supabase = GetIt.I.get<SupabaseClient>();
    final auth = AuthRepository(AuthSupabaseProvider(supabase));
    final isAuthorized = await auth.isAuthorized(key: authKey);
    
    print('Is authorized $isAuthorized');
    if (!isAuthorized) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {
          'status': 'error',
          'message': 'You are not authorized to access this '
              'resource,{missing or invalid api key}',
        },
      );
    }

    // Forward the request to the respective handler.
    final response = await handler(context);
    // Return a response.
    return response;
  };
}
