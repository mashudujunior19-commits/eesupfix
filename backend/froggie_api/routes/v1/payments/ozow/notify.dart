import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/core/utils/query_string_to_map.dart';
import 'package:eesup_dart_frog/src/payments/repositories/ozow_repository.dart';
import 'package:eesup_dart_frog/src/payments/data/providers/payment_supabase_provider.dart';
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

  final transRef = int.tryParse(queryParams['TransactionReference'] ?? '');
  final amount = double.tryParse(queryParams['Amount'] ?? '');
  final hash = queryParams['Hash'];
  final isTest = queryParams['IsTest'] == 'True';
  final type = queryParams['Optional3'];

  final provider = PaymentSupabaseProvider(GetIt.I.get<SupabaseClient>());
  final repository = OzowRepository(provider);

  final result = await repository.confirmOzowPayment(
    transRef: transRef,
    amount: amount,
    hash: hash,
    isTest: isTest,
    type: type,
  );

  return result;
}
