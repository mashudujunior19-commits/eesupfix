import 'package:data/eesupreneur/data_source/eesupreneur_data_source.dart';
import 'package:data/eesupreneur/models/eesupreneur.dart';
import 'package:data/orders/models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EESUpreneurSupabaseDataSource implements EESUpreneurDataSource {
  final SupabaseClient _client;

  EESUpreneurSupabaseDataSource(this._client);

  @override
  Future<List<EESUpreneur>> getClosestEESUpreneurs(
    double lat,
    double lng,
    int limit,
  ) async {
    final response = await _client
        .schema('services')
        .rpc('get_closest_eesupreneurs', params: {
      'lat': lat,
      'lng': lng,
      'limit_to': limit,
    });

    return (response as List).map((e) => EESUpreneur.fromJson(e)).toList();
  }

  @override
  Future<List<EESUpreneur>> getUserEESUpreneurs(String userId) async {
    final response = await _client
        .schema('services')
        .rpc('get_all_user_eesupreneurs', params: {'_user_id': userId});

    return (response as List).map((e) => EESUpreneur.fromJson(e)).toList();
  }

  @override
  Future<List<Order>> fetchEESUpreneurOrders(
    String eesupreneurId,
    List<OrderStatus> statuses,
  ) async {
    final response =
        await _client.schema('sales').rpc('get_customer_orders', params: {
      '_user_id': null,
      '_eesupreneur_id': eesupreneurId,
      '_eesupool_ord_id': null,
      '_status': statuses.map((e) => e.toString()).toList(),
    });
    return (response as List).map((e) => Order.fromJson(e)).toList();
  }

  @override
  Future<bool> saveChanges(EESUpreneur eesupreneur) async {
    try {
      await _client.schema('services').from('eesupreneur').update({
        'name': eesupreneur.name,
        'description': eesupreneur.description,
        'delivery_fee': eesupreneur.deliveryFee,
        'address_id': eesupreneur.address?.id,
        'is_hidden': eesupreneur.isHidden,
      }).eq('id', eesupreneur.id);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
