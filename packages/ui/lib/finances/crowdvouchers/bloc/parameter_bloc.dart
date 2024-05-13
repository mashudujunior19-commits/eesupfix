import 'package:bloc/bloc.dart';
import 'package:data/finance/models/voucher_parameter.dart';
import 'package:data/finance/repository/vourcher_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'parameter_event.dart';
part 'parameter_state.dart';

class ParameterBloc extends Bloc<ParameterEvent, ParameterState> {
  final VoucherRepository _voucherRepository;
  ParameterBloc(this._voucherRepository) : super(ParameterLoading()) {
    on<ParameterEvent>((event, emit) async {
      emit(ParameterLoading());
      final result = await _voucherRepository.getVoucherParameters();
      result.fold(
        (l) => emit(ParameterError(l)),
        (r) => emit(ParametersState(r)),
      );
    });
  }
}
