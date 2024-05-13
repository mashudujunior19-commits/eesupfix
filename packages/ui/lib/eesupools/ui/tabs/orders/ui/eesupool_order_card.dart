import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EESUpoolOrderCard extends StatelessWidget {
  const EESUpoolOrderCard({
    super.key,
    required this.order,
    this.onTap,
    required this.pool,
  });
  final EESUpool? pool;
  final EESUpoolOrder order;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onTap ??
          () {
            if (pool != null) {
              context.router.push(
                EESUpoolOrderViewRoute(pool: pool!, order: order),
              );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  //backgroundColor: theme.colorScheme.primary.withOpacity(.1),
                  child: Image.asset('assets/images/checklist.png', width: 30),
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
                      Text('#${order.id.toString()}'),
                      const Icon(IconlyLight.arrowRight2, size: 15)
                    ],
                  ),
                  3.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Closes on: ',
                        style: textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormatter.formatDateToNamedayWithTime3(
                            order.closesAt),
                        style: textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // 3.sH,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Receiver: ',
                  //       style: textTheme.labelMedium?.copyWith(
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     Text(
                  //       order.receiver?.fullName ?? '~',
                  //       style: textTheme.labelMedium?.copyWith(
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  3.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Member orders: ',
                        style: textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        order.ordersCount.toString(),
                        style: textTheme.labelMedium?.copyWith(
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
                        style: textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'R${order.currentAmount.toStringAsFixed(2)}',
                        style: textTheme.labelMedium?.copyWith(
                          fontSize: 14,
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
