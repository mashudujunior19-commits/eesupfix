import 'package:data/geolocation/data_source/geo_data_source.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GeoSupabaseImpl implements GeoDataSource {
  final SupabaseClient _client;
  final String _geoapifyApiKey;
  final Dio _dio;

  GeoSupabaseImpl(this._client, this._geoapifyApiKey, {Dio? dio})
      : _dio = dio ?? Dio();

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

  @override
  Future<({double lat, double lng})?> geocodeAddress(String address) async {
    final response = await _dio.get(
      'https://api.geoapify.com/v1/geocode/search',
      queryParameters: {
        'text': address,
        'filter': 'countrycode:za',
        'apiKey': _geoapifyApiKey,
      },
    );
    final features = (response.data['features'] as List?) ?? const [];
    if (features.isEmpty) return null;
    final properties = features.first['properties'] as Map<String, dynamic>;
    return (
      lat: (properties['lat'] as num).toDouble(),
      lng: (properties['lon'] as num).toDouble(),
    );
  }
}
