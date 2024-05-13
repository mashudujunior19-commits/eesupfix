import 'package:data/geolocation/data_source/geo_data_source.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GeoSupabaseImpl implements GeoDataSource {
  final SupabaseClient _client;

  GeoSupabaseImpl(this._client);

  @override
  Future<List<Address>> fetchUserAddresses(String userId) async {
    final result = await _client
        .schema('geolocations')
        .from('address')
        .select()
        .eq('user_id', userId);
    return result.map((e) => Address.fromJson(e)).toList();
  }

  @override
  Future<Address?> saveAddress(Address address) async {
    final newAddress = await _client
        .schema('geolocations')
        .from('address')
        .insert(address.toJson())
        .select()
        .single();
    return Address.fromJson(newAddress);
  }

  @override
  Future<Address?> updateAddress(Address address) async {
    final newAddress = await _client
        .schema('geolocations')
        .from('address')
        .update(address.toJson())
        .eq('id', address.id ?? 0)
        .select()
        .single();
    return Address.fromJson(newAddress);
  }

  @override
  Future<void> deleteAddress(int id) async {
    await _client.schema('geolocations').from('address').delete().eq('id', id);
  }
}
