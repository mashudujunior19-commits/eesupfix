import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'kasipreneur_view_event.dart';
part 'kasipreneur_view_state.dart';

class KasipreneurViewBloc extends Bloc<KasipreneurViewEvent, KasipreneurViewState> {
  KasipreneurViewBloc() : super(KasipreneurViewInitial()) {
    on<KasipreneurViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
