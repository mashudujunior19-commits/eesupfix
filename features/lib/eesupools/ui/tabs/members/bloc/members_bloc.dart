import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool_member.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_members_repo.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';

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
