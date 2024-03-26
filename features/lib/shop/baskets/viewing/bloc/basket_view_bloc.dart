import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'basket_view_event.dart';
part 'basket_view_state.dart';

class BasketViewBloc extends Bloc<BasketViewEvent, BasketViewState> {
  BasketViewBloc() : super(BasketViewInitial()) {
    on<BasketViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
