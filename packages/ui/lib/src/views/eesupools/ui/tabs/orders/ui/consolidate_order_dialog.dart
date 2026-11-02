import 'package:data/eesupools/models/consolidation_candidate.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/utils/double_ext.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';

/// Lets a KasiPool admin join an order that is still below the minimum to
/// another KasiPool's order that is also below it. Pops `true` once joined.
class ConsolidateOrderDialog extends StatefulWidget {
  const ConsolidateOrderDialog({super.key, required this.order});
  final EESUpoolOrder order;

  @override
  State<ConsolidateOrderDialog> createState() => _ConsolidateOrderDialogState();
}

class _ConsolidateOrderDialogState extends State<ConsolidateOrderDialog> {
  late final Future<List<ConsolidationCandidate>> _candidates;

  @override
  void initState() {
    super.initState();
    final repo = context.read<EESUpoolRepository>();
    _candidates = repo
        .fetchConsolidationCandidates(widget.order.id)
        .then((r) => r.fold((l) => throw l, (r) => r));
  }

  Future<void> _join(ConsolidationCandidate c) async {
    final sure = await context.confirmAction(
      'Consolidate orders',
      'Join order #${widget.order.id} to ${c.poolName}\'s order #${c.orderId}? '
          'The combined total decides when it can close.',
      confirmText: 'Yes, consolidate',
    );
    if (!sure || !mounted) return;
    final result = await context
        .read<EESUpoolRepository>()
        .consolidateOrders(widget.order.id, c.orderId);
    if (!mounted) return;
    result.fold(
      (l) => context.snackBarError(l.message),
      (_) {
        context.snackBarSuccess('Orders consolidated.');
        Navigator.of(context).pop(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Consolidate order'),
      ),
      body: FutureBuilder<List<ConsolidationCandidate>>(
        future: _candidates,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const FullScreenLoadingShimmer();
          }
          if (snapshot.hasError) {
            final e = snapshot.error;
            return FullScreenError(
              exception: e is EESUpException
                  ? e
                  : EESUpException(message: 'Could not load orders.'),
            );
          }
          final candidates = snapshot.data ?? const [];
          if (candidates.isEmpty) {
            return FullScreenError(
              isError: false,
              exception: EESUpException(
                message: 'No other KasiPool has an open order below the '
                    'minimum right now.',
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: candidates.length,
            itemBuilder: (context, index) {
              final c = candidates[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(c.poolName, style: context.textTheme.labelMedium),
                  subtitle: Text(
                    'Order #${c.orderId} • R${c.currentAmount.toRounded()} • '
                    'closes ${DateFormatter.formatDateToNamedayWithTime3(c.closesAt)}',
                  ),
                  onTap: () => _join(c),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
