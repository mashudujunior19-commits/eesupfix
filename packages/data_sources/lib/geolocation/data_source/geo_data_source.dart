import 'package:data_sources/geolocation/models/address.dart';

abstract class GeoDataSource {
  /// Fetches the user's addresses
  Future<List<Address>> fetchUserAddresses(String userId);

  ///save  address
  Future<Address?> saveAddress(Address address);

  ///update  address
  Future<Address?> updateAddress(Address address);

  Future<void> deleteAddress(int id);
}
