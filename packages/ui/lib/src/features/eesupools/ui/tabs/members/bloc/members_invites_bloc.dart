import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_request.dart';
import 'package:data/eesupools/repository/eesupool_members_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'members_invites_event.dart';
part 'members_invites_state.dart';

class MembersInvitesBloc
    extends Bloc<MembersInvitesEvent, MembersInvitesState> {
  final EESUpoolRepository _pooRepo;
  MembersInvitesBloc(this._pooRepo) : super(MembersInvitesLoading()) {
    on<MembersInvitesFetched>((event, emit) async {
      emit(MembersInvitesLoading());
      final results = await _pooRepo.fetchEESUpoolInviteAndRequests(
          event.type, event.poolId, event.limit);
      results.fold((l) {
        emit(MembersInvitesError(l));
      }, (r) {
        emit(MembersInvitesLoaded(r));
      });
    });
  }
}
