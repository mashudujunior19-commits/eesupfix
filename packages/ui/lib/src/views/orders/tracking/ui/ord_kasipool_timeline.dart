import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

/// The order value above which a KasiPool order is considered "ready for
/// delivery" -- shown on an individual buyer's order-tracking screen.
const double kasipoolReadyForDeliveryThreshold = 10000;

/// Shown on an individual buyer's order-tracking screen when their order is
/// part of a KasiPool order: a placement confirmation plus the parent
/// KasiPool order's estimated delivery date and progress.
class OrdKasipoolTimeline extends StatefulWidget {
  const OrdKasipoolTimeline({super.key, required this.eesupoolOrderId});

  final int eesupoolOrderId;

  @override
  State<OrdKasipoolTimeline> createState() => _OrdKasipoolTimelineState();
}

class _OrdKasipoolTimelineState extends State<OrdKasipoolTimeline> {
  late final Future<EESUpoolOrder?> _future;

  @override
  void initState() {
    super.initState();
    _future = context
        .read<EESUpoolRepository>()
        .fetchEESUpoolOrderById(widget.eesupoolOrderId)
        .then((result) => result.fold((_) => null, (r) => r));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EESUpoolOrder?>(
      future: _future,
      builder: (context, snapshot) {
        final poolOrder = snapshot.data;
        if (poolOrder == null) return const SizedBox.shrink();

        final isReadyForDelivery =
            poolOrder.currentAmount > kasipoolReadyForDeliveryThreshold;

        return Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey.shade100, width: .5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle,
                      size: 16, color: context.colorScheme.primary),
                  8.sW,
                  Text(
                    'Your order has been placed.',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              10.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(IconlyLight.calendar,
                          size: 15, color: Colors.grey.shade600),
                      8.sW,
                      Text(
                        'Estimated Delivery Date',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 12.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    DateFormatter.formatDateToNamedayWithTime3(
                      poolOrder.scheduleFor,
                    ),
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
              if (isReadyForDelivery) ...[
                8.sH,
                Row(
                  children: [
                    Icon(Icons.local_shipping, size: 15, color: Colors.green),
                    8.sW,
                    Text(
                      'Order is ready for delivery.',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 12.5,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
