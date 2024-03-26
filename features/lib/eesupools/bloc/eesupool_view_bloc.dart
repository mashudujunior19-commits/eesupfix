import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:repository/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'eesupool_view_event.dart';
part 'eesupool_view_state.dart';

class EESUpoolViewBloc extends Bloc<EESUpoolViewEvent, EESUpoolViewState> {
  EESUpoolViewBloc() : super(EESUpoolViewLoading()) {
    on<EESUpoolViewLoaded>((event, emit) {
      emit(EESUpoolViewLoading());
      if (event.eesupool != null) {
        emit(CurrentEESUpoolView(event.eesupool!));
      } else {
        //TODO: fetch pool by id
      }
    });
  }
}
