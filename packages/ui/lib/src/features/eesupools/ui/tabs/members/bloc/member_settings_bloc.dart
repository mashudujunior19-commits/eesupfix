import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:meta/meta.dart';

part 'member_settings_event.dart';
part 'member_settings_state.dart';

class MemberSettingsBloc
    extends Bloc<MemberSettingsEvent, MemberSettingsState> {
  MemberSettingsBloc() : super(MemberSettingsLoading()) {
    on<MemberSettingsInitialized>((event, emit) {
      emit(MemberSettingsLoaded(event.member));
    });
  }
}
