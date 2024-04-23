import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/auth/data/providers/auth_supabase_impl.dart';
import 'package:eesup_dart_frog/src/auth/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart' as supa_dupa;

Handler middleware(Handler handler) {
  return (context) async {
    final request = context.request;

    if (request.method != HttpMethod.post) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {
          'status': 'error',
          'message': 'Mehtod not allowed',
        },
      );
    }

    final params = request.uri.queryParameters;
    final authKey = params['api_key'];

    if (authKey == null) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {
          'status': 'error',
          'message': 'Not authorized to access this resource,{invalid api key}',
        },
      );
    }

    final supabase = GetIt.I.get<supa_dupa.SupabaseClient>();
    final auth = AuthRepository(AuthSupabaseProvider(supabase));

    final isAuthorized = await auth.isAuthorized(key: authKey);

    if (!isAuthorized) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {
          'status': 'error',
          'message': 'Not authorized to access this resource,{invalid api key}',
        },
      );
    }

    // Forward the request to the respective handler.
    final response = await handler(context);

    // Return a response.
    return response;
  };
}
