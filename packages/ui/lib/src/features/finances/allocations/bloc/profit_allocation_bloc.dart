import 'package:bloc/bloc.dart';
import 'package:data/auth/models/profile.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/finance/models/profit_allocation.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'profit_allocation_event.dart';
part 'profit_allocation_state.dart';

class ProfitAllocationBloc
    extends Bloc<ProfitAllocationEvent, ProfitAllocationState> {
  final ProfileRepository _profileRepository;
  final WalletsRepository _walletsRepository;
  ProfitAllocationBloc(this._profileRepository, this._walletsRepository)
      : super(ProfitAllocationInitial()) {
    on<ProfitAllocationEvent>((event, emit) async {
      Profile? profile;
      final pRes = await _profileRepository.fetchSessionProfile();
      pRes.fold((l) {}, (r) {
        profile = r;
      });

      final alRes = await _walletsRepository.fetchProfitAllocations(
        profile?.role,
      );

      alRes.fold((l) {
        emit(ProfitAllocationError(l));
      }, (r) {
        emit(ProfitAllocationLoaded(r));
      });
    });
  }
}
