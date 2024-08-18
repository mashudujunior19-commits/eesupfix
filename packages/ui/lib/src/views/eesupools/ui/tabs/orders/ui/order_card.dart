import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/bloc/orders_bloc.dart';

class EESUpoolOrderCard extends StatelessWidget {
  const EESUpoolOrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.selectedAddress,
    required this.pool,
  });
  final EESUpool? pool;
  final EESUpoolOrder order;
  final Address? selectedAddress;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: onTap ??
          () {
            if (pool != null) {
              context.router
                  .push(
                EESUpoolOrderViewRoute(pool: pool!, order: order),
              )
                  .then((_) {
                context.read<OrdersBloc>().add(
                      PoolOrdersFetched(pool!.eesupoolId!, 500),
                    );
              });
            }
          },
      child: Container(
        margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: context.colorScheme.primary.withOpacity(.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/checklist.png',
                      width: 25,
                    ),
                  ),
                ),
              ],
            ),
            15.sW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${order.eesupoolName}\n#${order.id.toString()}'),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            color: order.closesAt.isBefore(DateTime.now())
                                ? Colors.redAccent.withOpacity(.5)
                                : context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order.closesAt.isBefore(DateTime.now())
                                  ? 'Closed'
                                  : 'Open',
                              style: textTheme.labelMedium?.copyWith(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  3.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.closesAt.isBefore(DateTime.now())
                            ? 'Closed on'
                            : 'Closes on',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormatter.formatDateToNamedayWithTime3(
                            order.closesAt),
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  3.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Member orders: ',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        order.ordersCount.toString(),
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  3.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount: ',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'R${order.currentAmount.toStringAsFixed(2)}',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  3.sH,
                  if (order.address != null && selectedAddress != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(BootstrapIcons.person_walking, size: 12),
                        10.sW,
                        Text(
                          '${calculateDistance(
                            order.address!.latitude!,
                            order.address!.longitude!,
                            selectedAddress!.latitude!,
                            selectedAddress!.longitude!,
                          ).toStringAsFixed(2)} km Away',
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double r = 6371;
  double phi1 = lat1 * pi / 180;
  double phi2 = lat2 * pi / 180;
  double deltaPhi = (lat2 - lat1) * pi / 180;
  double deltaLambda = (lon2 - lon1) * pi / 180;

  // Haversine formula
  double a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
      cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return r * c;
}
