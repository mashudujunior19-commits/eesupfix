import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_kasi_tree_event.dart';
part 'my_kasi_tree_state.dart';

class MyKasiTreeBloc extends Bloc<MyKasiTreeEvent, MyKasiTreeState> {
  MyKasiTreeBloc() : super(MyKasiTreeInitial()) {
    on<MyKasiTreeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
