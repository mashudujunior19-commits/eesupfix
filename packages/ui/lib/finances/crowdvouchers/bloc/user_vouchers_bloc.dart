import 'package:bloc/bloc.dart';
import 'package:data/finance/models/voucher.dart';
import 'package:data/finance/repository/vourcher_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'user_vouchers_event.dart';
part 'user_vouchers_state.dart';

class UserVouchersBloc extends Bloc<UserVouchersEvent, UserVouchersState> {
  final int _walletId;
  final VoucherRepository _voucherRepository;
  UserVouchersBloc(this._voucherRepository, this._walletId)
      : super(UserVouchersBusyState()) {
    on<FetchUserVouchersEvent>(
      (event, emit) async {
        emit(UserVouchersBusyState());
        final results = await _voucherRepository.fetchUserVouchers(_walletId);
        results.fold(
          (l) => emit(UserVouchersErrorState(l)),
          (r) => emit(UserVouchersLoadedState(r)),
        );
      },
    );
  }
}
