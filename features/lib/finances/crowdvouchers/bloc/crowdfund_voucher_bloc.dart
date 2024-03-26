import 'package:bloc/bloc.dart';
import 'package:data_sources/finance/models/wallet.dart';
import 'package:meta/meta.dart';
import 'package:repository/finances/wallets_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'crowdfund_voucher_event.dart';
part 'crowdfund_voucher_state.dart';

class CrowdfundVoucherBloc
    extends Bloc<CrowdfundVoucherEvent, CrowdfundVoucherState> {
  final WalletsRepository _walletRepository;
  CrowdfundVoucherBloc(this._walletRepository)
      : super(CrowdfundVoucherBusyState()) {
    on<CrowdfundVoucherLoadEvent>((event, emit) async {
      emit(CrowdfundVoucherBusyState());
      final results = await _walletRepository.fetchCrowdfundWallet();
      results.fold(
        (error) => emit(CrowdfundVoucherErrorState(error)),
        (wallet) => emit(CrowdfundVoucherLoadedState(wallet)),
      );
    });
  }
}
