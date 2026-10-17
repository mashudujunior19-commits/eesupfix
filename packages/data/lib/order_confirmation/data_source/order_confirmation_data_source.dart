import 'dart:typed_data';

import 'package:data/order_confirmation/models/order_confirmation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderConfirmationDataSource {
  final SupabaseClient _client;

  OrderConfirmationDataSource(this._client);

  Future<OrderConfirmation> getConfirmation(int orderId) async {
    final res = await _client
        .schema('sales')
        .rpc('get_order_confirmation', params: {'_order_id': orderId});
    return OrderConfirmation.fromJson(Map<String, dynamic>.from(res as Map));
  }

  Future<ConfirmResult> confirm({
    required int orderId,
    required List<ConfirmationLineInput> lines,
    required String idempotencyKey,
  }) async {
    final res =
        await _client.schema('sales').rpc('confirm_member_order', params: {
      '_order_id': orderId,
      '_lines': lines.map((e) => e.toJson()).toList(),
      '_idempotency_key': idempotencyKey,
    });
    return ConfirmResult.fromJson(Map<String, dynamic>.from(res as Map));
  }

  /// Uploads a photo and returns its public URL, or null on any failure.
  Future<String?> uploadPhoto(String path, Uint8List bytes) async {
    try {
      final bucket = _client.storage.from('order_tickets');
      await bucket.uploadBinary(path, bytes);
      return bucket.getPublicUrl(path);
    } catch (_) {
      return null;
    }
  }
}
