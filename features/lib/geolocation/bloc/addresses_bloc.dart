import 'package:bloc/bloc.dart';
import 'package:data_sources/geolocation/models/address.dart';
import 'package:meta/meta.dart';
import 'package:repository/geolocation/geo_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

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
  }
}
