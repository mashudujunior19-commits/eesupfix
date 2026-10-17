import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/pool_progress/data_source/pool_progress_data_source.dart';
import 'package:data/pool_progress/models/pool_order_progress.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PoolProgressRepository {
  final AuthRepository _authRepository;
  final PoolProgressDataSource _dataSource;

  PoolProgressRepository(this._authRepository, this._dataSource);

  Future<Either<EESUpException, PoolOrderProgress>> getProgress(
    int eesupoolOrderId,
  ) {
    return _authRepository.executeFutureWithAuth(
      (_) => _dataSource.getProgress(eesupoolOrderId),
    );
  }

  /// Subscribes; [onChange] fires on every realtime event. Returns null if
  /// the channel could not be created (caller falls back to manual refresh).
  RealtimeChannel? subscribe(int eesupoolOrderId, void Function() onChange) {
    try {
      return _dataSource.channel(eesupoolOrderId, onChange).subscribe();
    } catch (_) {
      return null;
    }
  }

  Future<void> unsubscribe(RealtimeChannel channel) async {
    try {
      await _dataSource.removeChannel(channel);
    } catch (_) {}
  }
}
