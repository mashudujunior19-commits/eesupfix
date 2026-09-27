import 'package:data/geolocation/models/address.dart';

abstract class GeoDataSource {
  /// Fetches the user's addresses
  Future<List<Address>> fetchUserAddresses(String userId);

  ///save  address
  Future<Address?> saveAddress(Address address);

  ///update  address
  Future<Address?> updateAddress(Address address);

  Future<void> deleteAddress(int id);

  /// Geocodes a free-typed address string to lat/lng. Used on web, where
  /// the `geocoding` package has no browser implementation.
  Future<({double lat, double lng})?> geocodeAddress(String address);
}
