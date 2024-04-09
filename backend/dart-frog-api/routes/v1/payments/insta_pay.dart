// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/core/query_string_to_map.dart';
import 'package:eesup_dart_frog/src/auth/application/auth_services.dart';
import 'package:eesup_dart_frog/src/auth/data/data_source/auth_supabase_impl.dart';
import 'package:eesup_dart_frog/src/payments/data/data_source/payment_supabase_impl.dart';
import 'package:eesup_dart_frog/src/payments/services/instapay_services.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  dynamic queryParams;

  // try {
  //   queryParams = await request.json();
  // } catch (e) {
  //   print(e);
  //   print('Error parsing request json');
  //   queryParams = '';
  // }

  // if (queryParams.isEmpty) {
  queryParams = queryStringToMap(await request.body());
  //}

  final authKey = queryParams['payeeCategory3'];

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
  final auth = AuthServices(AuthSupabaseImpl(supabase));
  final authrized = await auth.authorized(key: authKey);

  if (!authrized) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'status': 'error',
        'message': 'You are not authorized to access this '
            'resource,{missing or invalid api key}',
      },
    );
  }

  final api = PaymentSupabaseImpl(supabase);
  final service = InstapayServices(api);
  final result = await service.confirmInstaPayment(queryParams);

  return result;
}
