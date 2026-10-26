import 'package:bloc/bloc.dart';
import 'package:data/finance/models/transaction.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:data/finance/models/wallet_balance.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'wallet_view_event.dart';
part 'wallet_view_state.dart';

class WalletViewBloc extends Bloc<WalletViewEvent, WalletViewState> {
  final WalletsRepository _walletsRepository;
  WalletViewBloc(this._walletsRepository) : super(WalletViewInitial()) {
    //   on<WalletViewFetched>((event, emit) async {
    //     emit(WalletViewInitial());
    //     late final List<Transaction> transactions;
    //     late final Wallet wallet;

    //     final walletResult = await _walletsRepository.fetchWalletById(event.id);

    //     walletResult.fold((l) {
    //       emit(WalletViewError(l));
    //       return;
    //     }, (r) {
    //       wallet = r;
    //     });

    //     final transResult = await _walletsRepository.fetchWalletTransactions(
    //       event.id,
    //     );

    //     transResult.fold((l) {
    //       emit(WalletViewError(l));
    //       return;
    //     }, (r) {
    //       transactions = r;
    //       //transactions.sort((a, b) => a.id.compareTo(b.id));
    //     });
    //     emit(WalletViewLoaded(wallet, transactions));
    //   });

    on<WalletViewFetched>((event, emit) async {
      emit(WalletViewInitial());

      final walletResult = await _walletsRepository.fetchWalletById(event.id);
      if (walletResult.isLeft) {
        if (!emit.isDone) emit(WalletViewError(walletResult.left));
        return;
      }
      final wallet = walletResult.right;

      final transResult =
          await _walletsRepository.fetchWalletTransactions(event.id);
      if (transResult.isLeft) {
        if (!emit.isDone) emit(WalletViewError(transResult.left));
        return;
      }
      final transactions = transResult.right;

      // Must match the wallet's type_id (not its display description) --
      // that's what finances.get_wallet_balance_by_type filters on.
      final balanceResult =
          await _walletsRepository.fetchWalletBalances(wallet.typeId);
      if (balanceResult.isLeft) {
        if (!emit.isDone) emit(WalletViewError(balanceResult.left));
        return;
      }
      final balance = balanceResult.right;

      if (!emit.isDone) {
        emit(WalletViewLoaded(wallet, transactions, balance));
      }
    });

    // on<WalletBalancesFetched>((event, emit) async {
    //   emit(WalletViewInitial());

    //   final balanceResult = await _walletsRepository.fetchWalletBalances();

    //   balanceResult.fold((l) {
    //     emit(WalletViewError(l));
    //     return;
    //   }, (balances) {
    //     emit(WalletBalancesLoaded(balances));
    //   });
    // });
  }
}
