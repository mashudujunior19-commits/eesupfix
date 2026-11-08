import 'package:data/auth/models/user_role.dart';
import 'package:data/finance/models/investment_project.dart';
import 'package:data/finance/models/kasilift_organisation.dart';
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

  Future<WalletBalance?> fetchWalletBalances(String userId, String walletType);

  /// Approved KasiLift Organisations a Social wallet may send to.
  Future<List<KasiliftOrganisation>> fetchKasiliftOrganisations();

  /// Approved investment projects that are open for funding.
  Future<List<InvestmentProject>> fetchFundableProjects();

  /// Commits [amount] from a Wealth wallet to a project; returns the commitment id.
  Future<int> commitToProject({
    required int fromWalletId,
    required int projectId,
    required double amount,
  });
}
