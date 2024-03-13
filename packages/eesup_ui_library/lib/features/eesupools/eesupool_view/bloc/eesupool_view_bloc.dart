import 'package:bloc/bloc.dart';
import 'package:eesup_data_source/eesupools/models/eesupool.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'eesupool_view_event.dart';
part 'eesupool_view_state.dart';

class EESUpoolViewBloc extends Bloc<EESUpoolViewEvent, EESUpoolViewState> {
  EESUpoolViewBloc() : super(EESUpoolViewLoading()) {
    on<EESUpoolViewLoaded>((event, emit) {
      
    });
  }
}
