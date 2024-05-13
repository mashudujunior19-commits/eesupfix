import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/finance/data_source/voucher_dt.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/voucher_ledger.dart';
import 'package:data/finance/models/voucher_parameter.dart';
import 'package:data/finance/models/voucher.dart';

class VoucherRepository {
  final AuthRepository _authRepository;
  final VoucherDt _voucherDt;

  VoucherRepository(this._authRepository, this._voucherDt);

  Future<Either<EESUpException, List<VoucherParameter>>>
      getVoucherParameters() async {
    final results = await _authRepository.executeFutureWithAuth((_) {
      return _voucherDt.getVoucherParameters();
    });
    return results;
  }

  Future<Either<EESUpException, int?>> createVoucher(Voucher voucher) async {
    final results = await _authRepository.executeFutureWithAuth((id) {
      return _voucherDt.createVoucher(voucher.copyWith(userId: id));
    });
    return results;
  }

  Future<Either<EESUpException, List<Voucher>>> fetchUserVouchers(
      int walletId) async {
    final results = await _authRepository.executeFutureWithAuth((_) {
      return _voucherDt.fetchUserVouchers(walletId);
    });
    return results;
  }

  Future<Either<EESUpException, List<Transaction>>> fetchVoucherTransactions(
    int voucherId,
    int limit,
  ) async {
    final results = await _authRepository.executeFutureWithAuth((_) {
      return _voucherDt.fetchVoucherTransactions(voucherId, limit);
    });
    return results;
  }

  Future<Either<EESUpException, List<VoucherLedger>>> fetchVoucherLedger(
    int voucherId,
  ) async {
    final results = await _authRepository.executeFutureWithAuth((_) {
      return _voucherDt.fetchVoucherLedgers(voucherId);
    });
    return results;
  }

  Future<Either<EESUpException, Voucher>> fetchVouchers(int voucherId) async {
    final results = await _authRepository.executeFutureWithAuth((_) {
      return _voucherDt.fetchVoucher(voucherId);
    });
    return results;
  }

  Future<Either<EESUpException, VoucherParameter>> fetchVoucherParameter(
      String id) async {
    final results = await _authRepository.executeFutureWithAuth((_) {
      return _voucherDt.getVoucherParameter(id);
    });
    return results;
  }
}
