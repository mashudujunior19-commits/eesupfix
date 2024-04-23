import 'package:bloc/bloc.dart';
import 'package:data_sources/finance/models/transaction.dart';
import 'package:data_sources/finance/models/wallet.dart';
import 'package:meta/meta.dart';
import 'package:repository/finances/wallets_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'wallet_view_event.dart';
part 'wallet_view_state.dart';

class WalletViewBloc extends Bloc<WalletViewEvent, WalletViewState> {
  final WalletsRepository _walletsRepository;
  WalletViewBloc(this._walletsRepository) : super(WalletViewInitial()) {
    on<WalletViewFetched>((event, emit) async {
      emit(WalletViewInitial());
      late final List<Transaction> transactions;
      late final Wallet wallet;

      final walletResult = await _walletsRepository.fetchWalletById(event.id);

      walletResult.fold((l) {
        emit(WalletViewError(l));
        return;
      }, (r) {
        wallet = r;
      });

      final transResult = await _walletsRepository.fetchWalletTransactions(
        event.id,
      );

      transResult.fold((l) {
        emit(WalletViewError(l));
        return;
      }, (r) {
        transactions = r;
        transactions.sort((a, b) => a.id.compareTo(b.id));
      });
      emit(WalletViewLoaded(wallet, transactions));
    });
  }
}
