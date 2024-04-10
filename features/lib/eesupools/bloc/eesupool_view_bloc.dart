import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'eesupool_view_event.dart';
part 'eesupool_view_state.dart';

class EESUpoolViewBloc extends Bloc<EESUpoolViewEvent, EESUpoolViewState> {
  final EESUpoolRepository _eesupoolRepo;
  EESUpoolViewBloc(this._eesupoolRepo) : super(EESUpoolViewLoading()) {
    on<EESUpoolViewLoaded>((event, emit) {
      emit(EESUpoolViewLoading());
      if (event.eesupool != null) {
        emit(CurrentEESUpoolView(event.eesupool!));
      } else {
        //TODO: fetch pool by id
      }
    });

    on<EESUpoolSettingsUpdated>((event, emit) {
      emit(CurrentEESUpoolView(event.pool));
      //Use the canSave fleg to check if the changes can be saved
      if (!event.canSave) return;
      //Save changes
      _eesupoolRepo.updateEESUpool(event.pool);
    });
  }
}
