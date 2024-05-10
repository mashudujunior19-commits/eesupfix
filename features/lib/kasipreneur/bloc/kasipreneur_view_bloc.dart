import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupreneur/models/eesupreneur.dart';
import 'package:meta/meta.dart';
import 'package:repository/partners/eesupreneur_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'kasipreneur_view_event.dart';
part 'kasipreneur_view_state.dart';

class KasipreneurViewBloc
    extends Bloc<KasipreneurViewEvent, KasipreneurViewState> {
  final EESUpreneurRepository _repository;
  KasipreneurViewBloc(this._repository) : super(KasipreneurViewLoading()) {
    on<KasipreneurViewInitialized>((event, emit) {
      emit(KasipreneurViewLoading());
      emit(KasipreneurViewCurrentState(event.eesupreneur));
    });
    on<KasipreneurViewUpdated>((event, emit) {
      _repository.saveChanges(event.eesupreneur);
      emit(KasipreneurViewCurrentState(event.eesupreneur));
    });
  }
}
