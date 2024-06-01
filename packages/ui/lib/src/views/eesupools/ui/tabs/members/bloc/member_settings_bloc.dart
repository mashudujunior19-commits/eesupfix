import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/repository/eesupool_members_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:meta/meta.dart';

part 'member_settings_event.dart';
part 'member_settings_state.dart';

class MemberSettingsBloc
    extends Bloc<MemberSettingsEvent, MemberSettingsState> {
  final EESUpoolRepository _repository;
  MemberSettingsBloc(this._repository) : super(MemberSettingsLoading()) {
    on<MemberSettingsInitialized>((event, emit) {
      emit(MemberSettingsLoaded(event.member));
    });

    on<MemberSettingsUpdated>((event, emit) {
      emit(MemberSettingsLoaded(event.member));
      _repository.updateEESUpoolMember(event.member);
    });
  }
}
