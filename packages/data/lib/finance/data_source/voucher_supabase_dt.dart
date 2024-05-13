import 'package:data/finance/data_source/voucher_dt.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/voucher.dart';
import 'package:data/finance/models/voucher_ledger.dart';
import 'package:data/finance/models/voucher_parameter.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VoucherSupabaseDt implements VoucherDt {
  final SupabaseClient _client;

  VoucherSupabaseDt(this._client);

  @override
  Future<List<VoucherParameter>> getVoucherParameters() async {
    final schema = _client.schema('finances');
    final res = await schema.from('voucher_parameter').select();
    return res.map((e) => VoucherParameter.fromJson(e)).toList();
  }

  @override
  Future<int?> createVoucher(Voucher voucher) async {
    try {
      final schema = _client.schema('finances');
      final res = await schema.rpc('create_crowdfunding_voucher', params: {
        '_user_id': voucher.userId,
        '_parameter_id': voucher.parameterId,
        '_value': voucher.value,
        '_cycle': voucher.cycle.toString(),
        '_period': voucher.period,
        '_end_date': voucher.endDate.toIso8601String(),
      });
      return res;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  @override
  Future<List<Voucher>> fetchUserVouchers(int walletId) async {
    final results = await _client
        .schema('finances')
        .from('voucher')
        .select()
        .eq('wallet_id', walletId);
    return results.map((e) => Voucher.fromJson(e)).toList();
  }

  @override
  Future<Voucher> fetchVoucher(int id) async {
    final results = await _client
        .schema('finances')
        .from('voucher')
        .select()
        .eq('id', id)
        .single();
    return Voucher.fromJson(results);
  }

  @override
  Future<List<VoucherLedger>> fetchVoucherLedgers(int id) async {
    final results = await _client
        .schema('finances')
        .from('voucher_ledger')
        .select()
        .eq('voucher_id', id);
    return results.map((e) => VoucherLedger.fromJson(e)).toList();
  }

  @override
  Future<List<Transaction>> fetchVoucherTransactions(int id, int limit) async {
    final results = await _client.schema('finances').rpc(
        'get_voucher_transactions',
        params: {'_voucher_id': id, 'limit_to': limit});
    return (results as List).map((e) => Transaction.fromJson(e)).toList();
  }

  @override
  Future<VoucherParameter> getVoucherParameter(String id) async {
    final results = await _client
        .schema('finances')
        .from('voucher_parameter')
        .select()
        .eq('id', id)
        .single();
    return VoucherParameter.fromJson(results);
  }
}
