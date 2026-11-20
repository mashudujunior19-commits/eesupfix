import 'dart:async';

import 'package:data/kasipool_timeline/kasipool_timeline_repository.dart';
import 'package:data/kasipool_timeline/models/kasipool_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class KasiPoolTimelineState {
  const KasiPoolTimelineState();
}

class KasiPoolTimelineLoading extends KasiPoolTimelineState {
  const KasiPoolTimelineLoading();
}

class KasiPoolTimelineLoaded extends KasiPoolTimelineState {
  const KasiPoolTimelineLoaded(this.timeline);
  final KasiPoolTimeline timeline;
}

class KasiPoolTimelineError extends KasiPoolTimelineState {
  const KasiPoolTimelineError(this.message);
  final String message;
}

/// Loads the KasiPool order timeline and keeps it live (realtime signal,
/// debounced refetch).
class KasiPoolTimelineCubit extends Cubit<KasiPoolTimelineState> {
  KasiPoolTimelineCubit(this._repository, this.eesupoolOrderId)
      : super(const KasiPoolTimelineLoading());

  final KasiPoolTimelineRepository _repository;
  final int eesupoolOrderId;
  RealtimeChannel? _channel;
  Timer? _debounce;

  Future<void> start() async {
    await refresh();
    if (isClosed) return;
    _channel = _repository.subscribe(eesupoolOrderId, _onEvent);
  }

  void _onEvent() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!isClosed) unawaited(refresh());
    });
  }

  Future<void> refresh() async {
    final res = await _repository.getTimeline(eesupoolOrderId);
    if (isClosed) return;
    res.fold(
      (e) {
        // Keep what is on screen if a refresh fails.
        if (state is! KasiPoolTimelineLoaded) {
          emit(KasiPoolTimelineError(e.message));
        }
      },
      (t) => emit(KasiPoolTimelineLoaded(t)),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    final c = _channel;
    _channel = null;
    if (c != null) unawaited(_repository.unsubscribe(c));
    return super.close();
  }
}
