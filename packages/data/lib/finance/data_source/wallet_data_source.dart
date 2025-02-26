import 'package:data/auth/models/user_role.dart';
import 'package:data/finance/models/payment_gateway.dart';
import 'package:data/finance/models/payout_request.dart';
import 'package:data/finance/models/profit_allocation.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/wallet.dart';

import '../models/wallet_balance.dart';

abstract class WalletDataSource {
  Future<List<Wallet>> fetchWallets(String id);
  Future<Wallet> fetchWalletById(String userId, int id);
  Future<Wallet> fetchWalletByUserIdAndType(String userId, String type);
  Future<Wallet> fetchCrowdfundWallet(String id);
  Future<List<Transaction>> fetchWalletTransactions(int id, int limit);
  Future<List<dynamic>> searchTransferBeneficiary(String query);
  Future<int?> transferFundsWalletToWallet({
    required int fromWalletId,
    required int toWalletId,
    required double amount,
    required String toRef,
    required String fromRef,
  });
  Future<List<PaymentGateway>> fetchPaymentGateways();

  Future<ProfitAllocation> fetchProfitAllocation(UserRole role);

  Future<bool> createPayoutRequest(PayoutRequest request);

  Future<List<WalletBalance>> fetchWalletBalances(String userId);
}
