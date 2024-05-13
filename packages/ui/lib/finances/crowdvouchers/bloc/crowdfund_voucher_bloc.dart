import 'package:bloc/bloc.dart';
import 'package:data/finance/models/wallet.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

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
