import 'package:data/auth/models/user_role.dart';
import 'package:data/finance/data_source/wallet_data_source.dart';
import 'package:data/finance/models/payment_gateway.dart';
import 'package:data/finance/models/payout_request.dart';
import 'package:data/finance/models/profit_allocation.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletSupabaseImpl implements WalletDataSource {
  final SupabaseClient _client;

  WalletSupabaseImpl(this._client);

  /// Fetches all wallets for a given user
  @override
  Future<List<Wallet>> fetchWallets(String id) async {
    final results = await _client.schema('finances').rpc('get_user_wallets',
        params: {'_user_id': id}).not('type_id', 'eq', 'crowdfund');
    return (results as List).map((e) => Wallet.fromJson(e)).toList();
  }

  @override
  Future<Wallet> fetchWalletByUserIdAndType(String userId, String type) async {
    final results = await _client
        .schema('finances')
        .rpc('get_user_wallets', params: {'_user_id': userId})
        .eq('type_id', type)
        .single();
    return Wallet.fromJson(results);
  }

  @override
  Future<Wallet> fetchWalletById(String userId, int id) async {
    final results = await _client
        .schema('finances')
        .rpc('get_user_wallets', params: {'_user_id': userId})
        .eq('id', id)
        .single();
    return Wallet.fromJson(results);
  }

  @override
  Future<List<Transaction>> fetchWalletTransactions(int id, int limit) async {
    final results = await _client
        .schema('finances')
        .rpc('get_wallet_transactions', params: {
      '_wallet_id': id,
      'limit_to': limit
    }).order('created_at', ascending: false);
    return (results as List).map((e) => Transaction.fromJson(e)).toList();
  }

  @override
  Future<List> searchTransferBeneficiary(String query) async {
    final results = await _client.schema('finances').rpc(
        'search_transfer_beneficiary',
        params: {'query_str': query, 'wallet_type': 'retail'});
    return results as List;
  }

  @override
  Future<int?> transferFundsWalletToWallet({
    required int fromWalletId,
    required int toWalletId,
    required double amount,
    required String toRef,
    required String fromRef,
  }) async {
    try {
      final id = await _client
          .schema('finances')
          .rpc('transfer_funds_wallet_to_wallet', params: {
        'from_wallet_id': fromWalletId,
        'to_wallet_id': toWalletId,
        'amount': amount,
        'to_ref': toRef,
        'from_ref': fromRef
      });
      return id;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Wallet> fetchCrowdfundWallet(String id) async {
    final results = await _client
        .schema('finances')
        .rpc('get_user_wallets', params: {'_user_id': id})
        .eq('type_id', 'crowdfund')
        .single();
    return Wallet.fromJson(results);
  }

  @override
  Future<List<PaymentGateway>> fetchPaymentGateways() async {
    final results = await _client
        .schema('finances')
        .from('payment_gateway')
        .select()
        .eq('is_active', true);
    return results.map((e) => PaymentGateway.fromJson(e)).toList();
  }

  @override
  Future<ProfitAllocation> fetchProfitAllocation(UserRole role) async {
    final results = await _client.schema('finances').rpc(
      'get_profit_allocation_by_role',
      params: {'role': role.toString()},
    ).single();
    return ProfitAllocation.fromJson(results);
  }

  @override
  Future<bool> createPayoutRequest(PayoutRequest request) async {
    try {
      await _client.schema('finances').from('payout_request').insert(
            request.toJson(),
          );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
