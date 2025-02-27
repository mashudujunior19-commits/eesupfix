import 'package:bloc/bloc.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'wallets_event.dart';
part 'wallets_state.dart';

class WalletsBloc extends Bloc<WalletsEvent, WalletsState> {
  final WalletsRepository _walletRepo;
  WalletsBloc(this._walletRepo) : super(WalletsLoading()) {
    // on<WalletsFetched>((event, emit) async {
    //   final results = await _walletRepo.fetchWallets();
    //   results.fold((l) {
    //     emit(WalletsLoadingError(l));
    //   }, (r) {
    //     r.sort((a, b) => a.sortNumber.compareTo(b.sortNumber));
    //     emit(WalletsLoaded(r));
    //   });
    // });
    on<WalletsFetched>((event, emit) async {
      try {
        final walletResults = await _walletRepo.fetchWallets();
        await walletResults.fold(
          (failure) async {
            emit(WalletsLoadingError(failure));
          },
          (wallets) async {
            final updatedWallets =
                await Future.wait(wallets.map((wallet) async {
              final balanceResult =
                  await _walletRepo.fetchWalletBalances(wallet.typeId);
              return balanceResult.fold(
                (failure) {
                  return wallet;
                },
                (walletBalance) {
                  return wallet.copyWith(
                      balance: walletBalance.availableBalance ?? 0.0);
                },
              );
            }));

            updatedWallets.sort((a, b) => a.sortNumber.compareTo(b.sortNumber));

            if (!emit.isDone) {
              emit(WalletsLoaded(updatedWallets));
            }
          },
        );
      } catch (e) {
        if (!emit.isDone) {
          emit(WalletsLoadingError(EESUpException(
              message: "Failed to fetch wallets and balances: $e")));
        }
      }
    });
  }
}
