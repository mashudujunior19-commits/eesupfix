import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'baskets_event.dart';
part 'baskets_state.dart';

class BasketsBloc extends Bloc<BasketsEvent, BasketsState> {
  BasketsBloc() : super(BasketsInitial()) {
    on<BasketsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
