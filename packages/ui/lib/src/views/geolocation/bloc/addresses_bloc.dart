import 'package:bloc/bloc.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/geolocation/repository/geo_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  final GeoRepository _geoRepo;
  AddressesBloc(this._geoRepo) : super(AddressesLoading()) {
    on<AddressesFetched>((event, emit) async {
      emit(AddressesLoading());
      final results = await _geoRepo.fetchUserAddresses();
      results.fold((l) {
        emit(AddressesError(l));
      }, (r) {
        emit(AddressesLoaded(r));
      });
    });

    on<AddressDeleted>((event, emit) async {
      //Get the current state so we can set it back to it, in case of an error
      final currentAddresses = (state as AddressesLoaded).addresses;

      emit(AddressesLoading());
      final results = await _geoRepo.deleteAddress(event.id);

      results.fold((l) {
        emit(AddressesError(l));
        //For error we emit with the current list
        emit(AddressesLoaded(currentAddresses));
      }, (r) {
        //Otherwise refresh the list
        add(AddressesFetched());
      });
    });
  }
}
