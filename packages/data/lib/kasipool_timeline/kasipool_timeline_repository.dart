import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/kasipool_timeline/models/kasipool_timeline.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Reads the KasiPool order timeline and listens for new steps.
///
/// Realtime pattern 2: `communities.pool_order_event` changes are only a
/// signal; the timeline itself is always refetched through the RPC, which
/// applies who-may-see-what.
class KasiPoolTimelineRepository {
  KasiPoolTimelineRepository(this._auth, this._client);

  final AuthRepository _auth;
  final SupabaseClient _client;

  Future<Either<EESUpException, KasiPoolTimeline>> getTimeline(
    int eesupoolOrderId,
  ) {
    return _auth.executeFutureWithAuth((_) async {
      final res = await _client.schema('communities').rpc(
        'get_pool_order_timeline',
        params: {'_eesupool_order_id': eesupoolOrderId},
      );
      return KasiPoolTimeline.fromJson(Map<String, dynamic>.from(res as Map));
    });
  }

  /// [onChange] fires when a step is added or updated for this KasiPool
  /// order, or when the pool order or one of its member orders changes.
  /// Returns null if the channel could not be created.
  RealtimeChannel? subscribe(int eesupoolOrderId, void Function() onChange) {
    try {
      return _client
          .channel(
              'kasipool-timeline-$eesupoolOrderId-${DateTime.now().microsecondsSinceEpoch}')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'communities',
            table: 'pool_order_event',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'eesupool_order_id',
              value: eesupoolOrderId,
            ),
            callback: (_) => onChange(),
          )
          .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'sales',
            table: 'order',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'eesupool_order_id',
              value: eesupoolOrderId,
            ),
            callback: (_) => onChange(),
          )
          .subscribe();
    } catch (_) {
      return null;
    }
  }

  Future<void> unsubscribe(RealtimeChannel channel) async {
    try {
      await _client.removeChannel(channel);
    } catch (_) {}
  }
}
