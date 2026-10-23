import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/pool_progress/data_source/pool_progress_data_source.dart';
import 'package:data/pool_progress/repository/pool_progress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/views/pool_progress/cubit/pool_progress_cubit.dart';

/// Compact "KasiPool delivery" section. Renders nothing unless the Centre has
/// recorded at least one step; never shows an error.
class PoolProgressTimeline extends StatelessWidget {
  const PoolProgressTimeline({super.key, required this.eesupoolOrderId});

  final int eesupoolOrderId;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PoolProgressRepository(
        context.read<AuthRepository>(),
        PoolProgressDataSource(GetIt.I.get<SupabaseClient>()),
      ),
      child: Builder(
        builder: (context) => BlocProvider(
          create: (context) => PoolProgressCubit(
            context.read<PoolProgressRepository>(),
            eesupoolOrderId,
          )..start(),
          child: const _PoolProgressView(),
        ),
      ),
    );
  }
}

class _PoolProgressView extends StatelessWidget {
  const _PoolProgressView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PoolProgressCubit, PoolProgressState>(
      builder: (context, state) {
        if (state is! PoolProgressLoaded) return const SizedBox.shrink();
        final p = state.progress;
        return Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KasiPool delivery',
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              _Row(label: 'Packed at the Centre', at: p.packedAt),
              _Row(label: 'Ready to load', at: p.readyAt),
              _Row(label: 'Left the Centre', at: p.departedAt),
              _Row(label: 'Received by your KasiPool', at: p.receivedAt),
            ],
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.at});

  final String label;
  final DateTime? at;

  @override
  Widget build(BuildContext context) {
    final done = at != null;
    final muted = Colors.blueGrey.shade300;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Center(
              child: done
                  ? Icon(Icons.check_circle,
                      size: 18, color: context.colorScheme.primary)
                  : Container(
                      width: 8,
                      height: 8,
                      decoration:
                          BoxDecoration(color: muted, shape: BoxShape.circle),
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: done ? null : muted),
            ),
          ),
          if (done)
            Text(
              DateFormatter.yetAnotherDateFormat2(at!),
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
