import 'package:data_sources/finance/models/transaction.dart';
import 'package:data_sources/finance/models/voucher.dart';
import 'package:data_sources/finance/models/voucher_ledger.dart';
import 'package:data_sources/finance/models/voucher_parameter.dart';

abstract class VoucherDt {
  Future<List<VoucherParameter>> getVoucherParameters();
  Future<VoucherParameter> getVoucherParameter(String id);
  Future<int?> createVoucher(Voucher voucher);
  Future<List<Voucher>> fetchUserVouchers(int walletId);
  Future<Voucher> fetchVoucher(int id);
  Future<List<Transaction>> fetchVoucherTransactions(int id, int limit);
  Future<List<VoucherLedger>> fetchVoucherLedgers(int id);
}
