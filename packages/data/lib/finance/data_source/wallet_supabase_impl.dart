import 'package:data/auth/models/user_role.dart';
import 'package:data/finance/data_source/wallet_data_source.dart';
import 'package:data/finance/models/investment_project.dart';
import 'package:data/finance/models/kasilift_organisation.dart';
import 'package:data/finance/models/payment_gateway.dart';
import 'package:data/finance/models/payout_request.dart';
import 'package:data/finance/models/profit_allocation.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/wallet_balance.dart';

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
    // Errors are not swallowed: the database explains why a transfer is refused
    // (wrong recipient for the wallet, insufficient funds, ...).
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
  }

  @override
  Future<List<KasiliftOrganisation>> fetchKasiliftOrganisations() async {
    final results =
        await _client.schema('finances').rpc('get_kasilift_organisations');
    return (results as List)
        .map((e) => KasiliftOrganisation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<InvestmentProject>> fetchFundableProjects() async {
    // Row-level security already limits this to approved projects accepting funds.
    final results = await _client
        .schema('finances')
        .from('investment_project')
        .select('id, name, description')
        .eq('status', 'approved')
        .eq('accepts_funds', true)
        .order('name');
    return (results as List)
        .map((e) => InvestmentProject.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<int> commitToProject({
    required int fromWalletId,
    required int projectId,
    required double amount,
  }) async {
    final id = await _client.schema('finances').rpc('commit_to_project', params: {
      '_from_wallet_id': fromWalletId,
      '_project_id': projectId,
      '_amount': amount,
    });
    return id as int;
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
    // Not caught: payouts from Social/Wealth wallets are refused by the database
    // with an explanation that should reach the user.
    await _client.schema('finances').from('payout_request').insert(
          request.toJson(),
        );
    return true;
  }

  @override
  Future<WalletBalance?> fetchWalletBalances(
      String userId, String walletType) async {
    try {
      final expectedWalletType = walletType.toLowerCase();
      final results = await _client.schema('finances').rpc(
        'get_wallet_balance_by_type',
        params: {'user_uuid': userId, 'wallet_type_param': expectedWalletType},
      );
      if (results.isNotEmpty) {
        return WalletBalance.fromJson(results.first);
      } else {
        return null; // No balance found
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching wallet balance: $e");
      }
      return null; // Return null instead of an empty list
    }
  }
}
