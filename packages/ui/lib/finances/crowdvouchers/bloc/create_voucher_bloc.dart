import 'package:bloc/bloc.dart';
import 'package:data/finance/models/voucher_cycle.dart';
import 'package:data/finance/repository/vourcher_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/finance/models/voucher.dart';
import 'package:data/utils/eesup_exception.dart';

part 'create_voucher_event.dart';
part 'create_voucher_state.dart';

class CreateVoucherBloc extends Bloc<CreateVoucherEvent, CreateVoucherState> {
  final VoucherRepository _voucherRepository;
  CreateVoucherBloc(this._voucherRepository)
      : super(
          CreateVoucherCurrentState(
            Voucher(
              parameterId: 'default-id',
              createdAt: DateTime.now(),
              balance: 0,
              value: 0,
              cycle: VoucherCycle.weekly,
              period: 0,
              endDate: DateTime.now(),
            ),
          ),
        ) {
    on<CreateVoucherUpdatedEvent>((event, emit) {
      emit(CreateVoucherCurrentState(event.voucher));
    });

    on<SubmitVoucherEvent>((event, emit) async {
      emit(CreateVoucherBusyState());
      final results = await _voucherRepository.createVoucher(event.voucher);
      results.fold((l) {
        emit(CreateVoucherErrorState(l));
      }, (r) {
        if (r == null) {
          emit(
            CreateVoucherErrorState(
              EESUpException(
                message: 'Failed to create the voucher',
              ),
            ),
          );
          return;
        } else {
          emit(CreateVoucherSuccessState(r));
        }
      });
    });
  }
}
