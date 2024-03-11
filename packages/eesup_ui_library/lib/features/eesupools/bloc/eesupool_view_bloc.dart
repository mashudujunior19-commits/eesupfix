import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:eesup_data_source/eesupools/models/eesupool.dart';

part 'eesupool_view_event.dart';
part 'eesupool_view_state.dart';


class EESUpoolViewBloc extends Bloc<EESUpoolViewEvent, EESUpoolViewState> {
  EESUpoolViewBloc() : super(EESUpoolViewLoading()) {
    on<EESUpoolViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
