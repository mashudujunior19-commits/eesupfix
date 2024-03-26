import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wallets_event.dart';
part 'wallets_state.dart';

class WalletsBloc extends Bloc<WalletsEvent, WalletsState> {
  WalletsBloc() : super(WalletsInitial()) {
    on<WalletsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
