import 'package:eesup_data_source/finance/models/transaction.dart';
import 'package:eesup_data_source/finance/models/wallet.dart';

abstract class WalletDataSource {
  Future<List<Wallet>> fetchWallets(String id);
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
}
