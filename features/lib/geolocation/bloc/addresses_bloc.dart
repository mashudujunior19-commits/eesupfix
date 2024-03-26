import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(AddressesInitial()) {
    on<AddressesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
