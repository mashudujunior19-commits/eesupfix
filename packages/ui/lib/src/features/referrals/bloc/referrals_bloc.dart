import 'package:bloc/bloc.dart';
import 'package:data/auth/repository/referrals_repository.dart';
import 'package:data/referrals/models/referral.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'referrals_event.dart';
part 'referrals_state.dart';

class ReferralsBloc extends Bloc<ReferralsEvent, ReferralsState> {
  final ReferralsRepository _repository;
  ReferralsBloc(this._repository) : super(ReferralsLoading()) {
    on<ReferralsEvent>((event, emit) async {
      emit(ReferralsLoading());
      final results = await _repository.fetchReferrals();
      results.fold((left) {
        emit(ReferralsError(left));
      }, (right) {
        emit(ReferralsLoaded(right));
      });
    });
  }
}
