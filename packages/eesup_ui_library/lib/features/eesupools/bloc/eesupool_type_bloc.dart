import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eesupool_type_event.dart';
part 'eesupool_type_state.dart';

class EESUpoolTypeBloc extends Bloc<EESUpoolTypeEvent, EesUpoolTypeState> {
  EESUpoolTypeBloc() : super(EesUpoolTypeInitial()) {
    on<EESUpoolTypeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
