import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/core/query_string_to_map.dart';
import 'package:eesup_dart_frog/src/auth/application/auth_services.dart';
import 'package:eesup_dart_frog/src/auth/data/data_source/auth_supabase_impl.dart';
import 'package:eesup_dart_frog/src/payments/services/ozow_service.dart';
import 'package:eesup_dart_frog/src/payments/data/data_source/payment_supabase_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

Future<Response> onRequest(RequestContext context) async {
  //get query parameters
  //Access the incoming request.
  final request = context.request;

  var queryParams = queryStringToMap(await request.body());

  if (queryParams.isEmpty) {
    queryParams = request.url.queryParameters;
  }

  final authKey = queryParams['Optional2'];

  if (authKey == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'status': 'error',
        'message':
            'You are not authorized to access this resource,{missing or invalid api key}',
      },
    );
  }

  final supabase = GetIt.I.get<SupabaseClient>();
  final auth = AuthServices(AuthSupabaseImpl(supabase));
  final authrized = await auth.authorized(key: authKey);

  if (!authrized) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'status': 'error',
        'message':
            'You are not authorized to access this resource,{missing or invalid api key}',
      },
    );
  }

  final transRef = int.tryParse(queryParams['TransactionReference'] ?? '');
  final amount = double.tryParse(queryParams['Amount'] ?? '');
  final hash = queryParams['Hash'];
  final isTest = queryParams['IsTest'] == 'True';
  final type = queryParams['Optional3'];

  final api = PaymentSupabaseImpl(supabase);
  final service = OzowService(api);

  final result = await service.confirmOzowPayment(
    transRef: transRef,
    amount: amount,
    hash: hash,
    isTest: isTest,
    type: type,
  );

  return result;
}
