import 'package:bloc/bloc.dart';
import 'package:data_sources/finance/models/transaction.dart';
import 'package:data_sources/finance/models/voucher.dart';
import 'package:data_sources/finance/models/voucher_ledger.dart';
import 'package:data_sources/finance/models/voucher_parameter.dart';
import 'package:meta/meta.dart';
import 'package:repository/finances/vourcher_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'voucher_view_event.dart';
part 'voucher_view_state.dart';

class VoucherViewBloc extends Bloc<VoucherViewEvent, VoucherViewState> {
  final VoucherRepository _voucherRepository;
  VoucherViewBloc(this._voucherRepository) : super(VoucherViewBusyState()) {
    on<FetchVoucherDetailsEvent>((event, emit) async {
      emit(VoucherViewBusyState());
      late Voucher voucher;
      late VoucherParameter parameter;
      late List<Transaction> transactions;
      late List<VoucherLedger> ledgers;

      final voucherResults = await _voucherRepository.fetchVouchers(
        event.voucherId,
      );

      voucherResults.fold((l) {
        emit(VoucherViewErrorState(l));
      }, (r) async {
        voucher = r;
        final results =
            await _voucherRepository.fetchVoucherParameter(r.parameterId);

        results.fold((l) {
          emit(VoucherViewErrorState(l));
        }, (r) {
          parameter = r;
        });
      });

      final transactionsResults = await _voucherRepository
          .fetchVoucherTransactions(event.voucherId, 10);

      transactionsResults.fold((l) {
        emit(VoucherViewErrorState(l));
      }, (r) {
        transactions = r;
      });

      final ledgersResults = await _voucherRepository.fetchVoucherLedger(
        event.voucherId,
      );

      ledgersResults.fold((l) {
        emit(VoucherViewErrorState(l));
      }, (r) {
        ledgers = r;
      });

      emit(VoucherViewDetailsLoadedState(
          voucher, transactions, ledgers, parameter));
    });
  }
}
