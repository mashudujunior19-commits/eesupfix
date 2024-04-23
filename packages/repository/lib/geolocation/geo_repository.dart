import 'package:either_dart/either.dart';
import 'package:data_sources/geolocation/data_source/geo_data_source.dart';
import 'package:data_sources/geolocation/models/address.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/utils/eesup_exception.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class GeoRepository {
  final GeoDataSource _dataSource;
  final AuthRepository _authRepo;

  GeoRepository(this._dataSource, this._authRepo);

  Future<Either<EESUpException, List<Address>>> fetchUserAddresses() async {
    final result = _authRepo.executeFutureWithAuth((id) {
      return _dataSource.fetchUserAddresses(id);
    });
    return result;
  }

  Future<Either<EESUpException, Address?>> saveAddress(
    Address address,
    bool isPersonal,
  ) async {
    // if address has no lat/lng, try to get it from the address string
    if (address.latitude == null || address.longitude == null) {
      final geoCoder = await _getGeoCoordinates(address.streetAddress);
      if (address.id != null) {
        return _updateAddress(
          address.copyWith(
            latitude: geoCoder?.lat,
            longitude: geoCoder?.lng,
          ),
        );
      } else {
        return _addAddress(
          address.copyWith(
            latitude: geoCoder?.lat,
            longitude: geoCoder?.lng,
          ),
          isPersonal,
        );
      }
    } else {
      // if address has lat/lng, just save it
      if (address.id != null) {
        return _updateAddress(address);
      } else {
        return _addAddress(address, isPersonal);
      }
    }
  }

  Future<Either<EESUpException, Address?>> _addAddress(
      Address address, bool isPersonal) async {
    final result = _authRepo.executeFutureWithAuth((id) {
      if (isPersonal) {
        return _dataSource.saveAddress(address.copyWith(userId: id));
      } else {
        return _dataSource.saveAddress(address);
      }
    });
    return result;
  }

  Future<Either<EESUpException, Address?>> _updateAddress(
      Address address) async {
    final result = _authRepo.executeFutureWithAuth((id) {
      return _dataSource.updateAddress(address);
    });
    return result;
  }

  Future<Either<EESUpException, void>> deleteAddress(int id) async {
    final result = _authRepo.executeFutureWithAuth((_) {
      return _dataSource.deleteAddress(id);
    });
    return result;
  }

  Future<({double lat, double lng})?> _getGeoCoordinates(
      String strAddress) async {
    final result = await EESUpException.guardFuture(action: () {
      return geocoding.locationFromAddress(strAddress);
    });
    return result.fold((l) {
      return null;
    }, (r) {
      if (r.isEmpty) {
        return null;
      } else {
        return (lat: r.first.latitude, lng: r.first.longitude);
      }
    });
  }
}
