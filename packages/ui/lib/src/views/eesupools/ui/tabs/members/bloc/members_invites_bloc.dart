import 'dart:async';

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
  StreamSubscription<void>? _changesSub;

  MembersInvitesBloc(this._pooRepo) : super(MembersInvitesLoading()) {
    on<MembersInvitesFetched>((event, emit) async {
      emit(MembersInvitesLoading());
      await _fetch(event.type, event.poolId, event.limit, emit);
      // Live updates: any change to this pool's invites refetches the list.
      await _changesSub?.cancel();
      _changesSub = _pooRepo.poolRequestChanges(event.poolId).listen((_) {
        add(MembersInvitesRefreshed(event.poolId, event.limit, event.type));
      });
    });
    on<MembersInvitesRefreshed>((event, emit) async {
      await _fetch(event.type, event.poolId, event.limit, emit);
    });
  }

  Future<void> _fetch(
    String type,
    int poolId,
    int limit,
    Emitter<MembersInvitesState> emit,
  ) async {
    final results =
        await _pooRepo.fetchEESUpoolInviteAndRequests(type, poolId, limit);
    results.fold((l) {
      // A failed background refresh keeps the list that is already shown.
      if (state is! MembersInvitesLoaded) emit(MembersInvitesError(l));
    }, (r) {
      emit(MembersInvitesLoaded(r));
    });
  }

  @override
  Future<void> close() async {
    await _changesSub?.cancel();
    return super.close();
  }
}
