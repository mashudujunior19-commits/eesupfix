import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/repository/eesupool_members_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  final EESUpoolRepository _pooRepo;
  MembersBloc(this._pooRepo) : super(MembersLoading()) {
    on<MembersFetched>((event, emit) async {
      emit(MembersLoading());
      final results = await _pooRepo.fetchEESUpoolMembers(
        event.poolId,
        event.limit,
      );
      results.fold((l) {
        emit(MembersLoadingError(l));
      }, (r) {
        emit(MembersLoaded(r));
      });
    });
  }
}
