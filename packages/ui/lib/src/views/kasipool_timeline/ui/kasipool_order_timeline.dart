import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/kasipool_timeline/kasipool_timeline_repository.dart';
import 'package:data/kasipool_timeline/models/kasipool_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/views/kasipool_timeline/cubit/kasipool_timeline_cubit.dart';

/// The KasiPool order timeline: one list of steps from "Order placed" to
/// "KasiPool order completed", each with its time and who did it. The same
/// data the admin app shows, updated live.
///
/// A KasiPool admin sees every member order; a member sees the KasiPool-wide
/// steps plus their own order (and orders they pack or dispatch).
class KasiPoolOrderTimeline extends StatelessWidget {
  const KasiPoolOrderTimeline({
    super.key,
    required this.eesupoolOrderId,
    this.highlightOrderId,
    this.showMemberOrders = true,
  });

  final int eesupoolOrderId;

  /// Member order to mark as "this order" (e.g. on the order tracking page).
  final int? highlightOrderId;

  /// Show the per-member-order summary (admins only).
  final bool showMemberOrders;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KasiPoolTimelineCubit(
        KasiPoolTimelineRepository(
          context.read<AuthRepository>(),
          GetIt.I.get<SupabaseClient>(),
        ),
        eesupoolOrderId,
      )..start(),
      child: _TimelineView(
        highlightOrderId: highlightOrderId,
        showMemberOrders: showMemberOrders,
      ),
    );
  }
}

class _TimelineView extends StatelessWidget {
  const _TimelineView({this.highlightOrderId, required this.showMemberOrders});

  final int? highlightOrderId;
  final bool showMemberOrders;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KasiPoolTimelineCubit, KasiPoolTimelineState>(
      builder: (context, state) {
        if (state is KasiPoolTimelineLoading) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Center(
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))),
          );
        }
        if (state is KasiPoolTimelineError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Could not load the KasiPool timeline.',
              style: context.textTheme.bodySmall,
            ),
          );
        }
        final t = (state as KasiPoolTimelineLoaded).timeline;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('KasiPool order timeline',
                      style: context.textTheme.labelMedium),
                ),
                _StageChip(
                  label: t.stage == 'collecting'
                      ? '${t.stageLabel} (${t.collectedCount}/${t.activeCount})'
                      : t.stageLabel,
                  done: t.isCompleted,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (t.events.isEmpty)
              Text('No steps yet.', style: context.textTheme.bodySmall)
            else
              for (var i = 0; i < t.events.length; i++)
                _EventRow(
                  event: t.events[i],
                  isLast: i == t.events.length - 1,
                  highlight: highlightOrderId != null &&
                      t.events[i].orderId == highlightOrderId,
                  showOrderNumber: t.isAdmin || t.events[i].orderId != null,
                ),
            if (showMemberOrders && t.isAdmin && t.orders.isNotEmpty) ...[
              const SizedBox(height: 10),
              _MemberOrders(orders: t.orders),
            ],
          ],
        );
      },
    );
  }
}

class _StageChip extends StatelessWidget {
  const _StageChip({required this.label, required this.done});

  final String label;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final color = done ? Colors.green.shade700 : context.colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: context.textTheme.labelSmall?.copyWith(color: color)),
    );
  }
}

IconData _iconFor(String stage) {
  switch (stage) {
    case 'order_placed':
      return Icons.shopping_bag_outlined;
    case 'pool_order_closed':
      return Icons.lock_outline;
    case 'processed':
      return Icons.inventory_2_outlined;
    case 'delivered':
      return Icons.local_shipping_outlined;
    case 'roles_assigned':
      return Icons.groups_outlined;
    case 'packing_checklist_completed':
      return Icons.checklist;
    case 'pin_issued':
      return Icons.pin_outlined;
    case 'collected':
      return Icons.handshake_outlined;
    case 'order_cancelled':
      return Icons.cancel_outlined;
    case 'pool_order_completed':
      return Icons.verified_outlined;
    default:
      return Icons.circle_outlined;
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({
    required this.event,
    required this.isLast,
    required this.highlight,
    required this.showOrderNumber,
  });

  final KasiPoolTimelineEvent event;
  final bool isLast;
  final bool highlight;
  final bool showOrderNumber;

  @override
  Widget build(BuildContext context) {
    final cancelled = event.stage == 'order_cancelled';
    final color = cancelled
        ? Colors.red
        : event.stage == 'pool_order_completed'
            ? Colors.green.shade700
            : context.colorScheme.primary;
    final subtitle = [
      if (event.actorName != null && event.actorName!.isNotEmpty)
        'by ${event.actorName}',
      if (event.note != null && event.note!.isNotEmpty) event.note!,
    ].join(' · ');

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 26,
            child: Column(
              children: [
                Icon(_iconFor(event.stage), size: 18, color: color),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: Colors.blueGrey.shade100,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.label,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight:
                                highlight ? FontWeight.w700 : FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        DateFormatter.yetAnotherDateFormat2(event.occurredAt),
                        style: context.textTheme.labelSmall,
                      ),
                    ],
                  ),
                  if (subtitle.isNotEmpty)
                    Text(subtitle, style: context.textTheme.labelSmall),
                  if (highlight || event.mine)
                    Text(
                      highlight ? 'This order' : 'Your order',
                      style: context.textTheme.labelSmall
                          ?.copyWith(color: context.colorScheme.primary),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberOrders extends StatelessWidget {
  const _MemberOrders({required this.orders});

  final List<KasiPoolTimelineOrder> orders;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text('Member orders (${orders.length})',
          style: context.textTheme.labelMedium),
      children: orders.map((o) {
        final details = [
          o.status,
          if (o.roles != null) o.roles!,
          if (o.pinIssuedAt != null && o.collectedAt == null) 'PIN issued',
          if (o.collectedBy != null) 'handed over by ${o.collectedBy}',
        ].join(' · ');
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text('#${o.orderId} · ${o.customerName}',
              style: context.textTheme.bodySmall),
          subtitle: Text(details, style: context.textTheme.labelSmall),
          trailing: Icon(
            o.status == 'Collected'
                ? Icons.check_circle
                : o.status == 'Cancelled'
                    ? Icons.cancel
                    : Icons.schedule,
            size: 18,
            color: o.status == 'Collected'
                ? Colors.green
                : o.status == 'Cancelled'
                    ? Colors.red
                    : Colors.orange,
          ),
        );
      }).toList(),
    );
  }
}
