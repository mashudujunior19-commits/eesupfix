import 'package:dio/dio.dart';
import 'package:eesup_dart_frog/core/env/env.dart';
import 'package:eesup_dart_frog/src/payments/data/data_source/payment_api.dart';
import 'package:eesup_dart_frog/src/payments/data/models/instapay_status.dart';
import 'package:eesup_dart_frog/src/payments/data/models/ozow_status.dart';
import 'package:eesup_dart_frog/src/payments/data/models/ozow_transaction.dart';
import 'package:supabase/supabase.dart';

class PaymentSupabaseImpl implements PaymentApi {
  PaymentSupabaseImpl(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<OzowTransaction?> fetchOzowTransaction({
    required String reference,
    required bool isTest,
  }) async {
    try {
      final dio = Dio();

      const baseUrl = 'https://api.ozow.com/GetTransactionByReference';
      final url =
          '$baseUrl?siteCode=${Env.ozowSiteCode}&transactionReference=$reference&IsTest=$isTest';

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
  Future<bool> confirmOzowEft({
    required int orderId,
    required OzowStatus status,
    required String type,
  }) async {
    try {
      if (type == 'Order') {
        await _supabase.schema('sales').rpc('place_confirmed_order', params: {
          '_order_id': orderId,
          '_is_confirmed': status == OzowStatus.Complete,
        });
        return true;
      } else if (type == 'Voucher') {
        await _supabase.schema('finances').rpc('confirm_voucher_eft', params: {
          'reference': orderId,
          'is_confirmed': status == OzowStatus.Complete,
        });
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> confirmInstapayEft({
    required int orderId,
    required InstapayStatus status,
    required String type,
  }) async {
    try {
      if (type == 'Order') {
        await _supabase.schema('sales').rpc('place_confirmed_order', params: {
          '_order_id': orderId,
          '_is_confirmed': status == InstapayStatus.completed,
        });
        return true;
      } else if (type == 'Voucher') {
        await _supabase.schema('finances').rpc('confirm_voucher_eft', params: {
          'reference': orderId,
          'is_confirmed': status == InstapayStatus.completed,
        });
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
