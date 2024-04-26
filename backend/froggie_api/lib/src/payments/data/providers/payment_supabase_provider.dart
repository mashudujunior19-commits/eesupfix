import 'package:dio/dio.dart';
import 'package:eesup_dart_frog/core/env/env.dart';
import 'package:eesup_dart_frog/src/payments/data/models/ozow_transaction.dart';
import 'package:supabase/supabase.dart';
import 'payment_provider.dart';

class PaymentSupabaseProvider implements PaymentGatewayProvider {
  PaymentSupabaseProvider(this._supabase);
  final SupabaseClient _supabase;

  @override
  Future<OzowTransaction?> fetchOzowTransaction({
    required String reference,
    required bool isTest,
  }) async {
    try {
      final dio = Dio();
      const baseUrl = 'https://api.ozow.com/GetTransactionByReference';
      final url = '$baseUrl?siteCode=${Env.ozowSiteCode}'
          '&transactionReference=$reference&IsTest=$isTest';
      dio.options.headers['ApiKey'] = Env.ozowApiKey;
      // ignore: inference_failure_on_function_invocation
      final res = await dio.get(url);
      final data = (res.data as List).first;
      final trans = OzowTransaction.fromJson(data as Map<String, dynamic>);
      return trans;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> confirmOnlinePayment({
    required int reference,
    required bool isConfirmed,
  }) async {
    try {
      await _supabase.schema('finances').from('online_payment').update({
        'confirmed_at': DateTime.now().toIso8601String(),
        'status': isConfirmed ? 'Complete' : 'Cancelled'
      }).eq('reference_id', reference);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
