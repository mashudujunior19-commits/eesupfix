import 'dart:async';

import 'package:data/pool_progress/models/pool_order_progress.dart';
import 'package:data/pool_progress/repository/pool_progress_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class PoolProgressState {
  const PoolProgressState();
}

class PoolProgressLoading extends PoolProgressState {
  const PoolProgressLoading();
}

class PoolProgressEmpty extends PoolProgressState {
  const PoolProgressEmpty();
}

class PoolProgressLoaded extends PoolProgressState {
  const PoolProgressLoaded(this.progress);
  final PoolOrderProgress progress;
}

class PoolProgressError extends PoolProgressState {
  const PoolProgressError();
}

class PoolProgressCubit extends Cubit<PoolProgressState> {
  PoolProgressCubit(this._repository, this.eesupoolOrderId)
      : super(const PoolProgressLoading());

  final PoolProgressRepository _repository;
  final int eesupoolOrderId;
  RealtimeChannel? _channel;

  /// Initial load plus realtime subscription.
  Future<void> start() async {
    await refresh();
    if (isClosed) return;
    _channel = _repository.subscribe(eesupoolOrderId, _onEvent);
  }

  void _onEvent() {
    if (!isClosed) unawaited(refresh());
  }

  Future<void> refresh() async {
    final res = await _repository.getProgress(eesupoolOrderId);
    if (isClosed) return;
    res.fold(
      (_) {
        // Keep showing what we already have; otherwise stay hidden.
        if (state is! PoolProgressLoaded) emit(const PoolProgressError());
      },
      (p) => emit(p.isEmpty ? const PoolProgressEmpty() : PoolProgressLoaded(p)),
    );
  }

  @override
  Future<void> close() {
    final c = _channel;
    _channel = null;
    if (c != null) unawaited(_repository.unsubscribe(c));
    return super.close();
  }
}
