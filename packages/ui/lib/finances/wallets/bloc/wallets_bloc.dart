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
    on<WalletsFetched>((event, emit) async {
      final results = await _walletRepo.fetchWallets();
      results.fold((l) {
        emit(WalletsLoadingError(l));
      }, (r) {
        r.sort((a, b) => a.sortNumber.compareTo(b.sortNumber));
        emit(WalletsLoaded(r));
      });
    });
  }
}
