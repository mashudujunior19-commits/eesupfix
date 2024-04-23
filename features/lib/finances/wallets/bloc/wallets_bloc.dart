import 'package:bloc/bloc.dart';
import 'package:data_sources/finance/models/wallet.dart';
import 'package:meta/meta.dart';
import 'package:repository/finances/wallets_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

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
