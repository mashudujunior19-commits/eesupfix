// ignore_for_file: avoid_print
import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/core/utils/query_string_to_map.dart';
import 'package:eesup_dart_frog/src/payments/data/providers/payment_supabase_provider.dart';
import 'package:eesup_dart_frog/src/payments/repositories/instapay_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final queryParams = queryStringToMap(await request.body());

  print(queryParams);

  final supabase = GetIt.I.get<SupabaseClient>();
  final provider = PaymentSupabaseProvider(supabase);
  final repository = InstapayRepository(provider);

  final result = await repository.confirmInstaPayment(queryParams);

  return result;
}
