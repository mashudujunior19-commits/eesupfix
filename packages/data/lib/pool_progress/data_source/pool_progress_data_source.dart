import 'package:data/pool_progress/models/pool_order_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PoolProgressDataSource {
  final SupabaseClient _client;

  PoolProgressDataSource(this._client);

  Future<PoolOrderProgress> getProgress(int eesupoolOrderId) async {
    final res = await _client.schema('communities').rpc(
      'get_pool_order_progress',
      params: {'_eesupool_order_id': eesupoolOrderId},
    );
    return PoolOrderProgress.fromJson(res, fallbackId: eesupoolOrderId);
  }

  /// Realtime channel on the timestamps-only table (never on eesupool_order,
  /// which holds the bulk PIN). The caller subscribes and removes it.
  RealtimeChannel channel(int eesupoolOrderId, void Function() onChange) {
    return _client.channel('pool-progress-$eesupoolOrderId').onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'communities',
          table: 'pool_order_progress',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'eesupool_order_id',
            value: eesupoolOrderId,
          ),
          callback: (_) => onChange(),
        );
  }

  Future<void> removeChannel(RealtimeChannel channel) async {
    await _client.removeChannel(channel);
  }
}
