import 'package:dartz/dartz.dart';
import 'package:data_sources/finance/models/transaction.dart';
import 'package:data_sources/finance/models/wallet.dart';
import 'package:data_sources/finance/data_source/wallet_data_source.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

class WalletsRepository {
  final AuthRepository _authRepo;
  final WalletDataSource _dataSource;

  WalletsRepository(this._dataSource, this._authRepo);

  Future<Either<EESUpException, List<Wallet>>> fetchWallets() async {
    final results = await _authRepo.executeFutureWithAuth((id) async {
      final wallets = await _dataSource.fetchWallets(id);
      return wallets;
    });
    return results;
  }

  Future<Either<EESUpException, Wallet>> fetchCrowdfundWallet() async {
    final results = await _authRepo.executeFutureWithAuth((id) async {
      final wallets = await _dataSource.fetchCrowdfundWallet(id);
      return wallets;
    });
    return results;
  }

  Future<Either<EESUpException, List<Transaction>>> fetchWalletTransactions(
    int id,
  ) async {
    final results = await _authRepo.executeFutureWithAuth((_) async {
      final transactions = await _dataSource.fetchWalletTransactions(id, 100);
      return transactions;
    });
    return results;
  }

  Future<Either<EESUpException, List<dynamic>>> searchTransferBeneficiary(
    String query,
  ) async {
    final results = await _authRepo.executeFutureWithAuth((_) async {
      final transactions = await _dataSource.searchTransferBeneficiary(query);
      return transactions;
    });
    return results;
  }

  Future<Either<EESUpException, int?>> transferFundsWalletToWallet({
    required int fromWalletId,
    required int toWalletId,
    required double amount,
    required String toRef,
    required String fromRef,
  }) async {
    final results = await _authRepo.executeFutureWithAuth((_) async {
      final id = await _dataSource.transferFundsWalletToWallet(
        fromWalletId: fromWalletId,
        toWalletId: toWalletId,
        amount: amount,
        toRef: toRef,
        fromRef: fromRef,
      );
      return id;
    });
    return results;
  }
}
