import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:data/finance/data_source/wallet_data_source.dart';

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

  Future<Either<EESUpException, Wallet>> fetchWalletById(int walletId) async {
    final result = await _authRepo.executeFutureWithAuth((id) async {
      final wallet = await _dataSource.fetchWalletById(id, walletId);
      return wallet;
    });
    return result;
  }

  Future<Either<EESUpException, Wallet>> fetchWalletByUserIdAndType(
      String type) async {
    final result = await _authRepo.executeFutureWithAuth((id) async {
      final wallet = await _dataSource.fetchWalletByUserIdAndType(id, type);
      return wallet;
    });
    return result;
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
    if (query.isEmpty) {
      return Left(EESUpException(message: 'Type to search for beneficiary'));
    }
    final results = await _authRepo.executeFutureWithAuth((id) async {
      final found = await _dataSource.searchTransferBeneficiary(query);
      return found.where((e) => e['user_id'] != id).toList();
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
