import 'package:auto_route/auto_route.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:either_dart/either.dart';
import 'package:features/app_route.gr.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    required this.privilege,
    this.bottomChildren = const [],
  });
  final Order order;
  final OrderEditPrivilage privilege;
  final void Function()? onTap;
  final List<Widget> bottomChildren;

  double totalAmount() {
    double total = 0;
    for (var item in order.products) {
      total += item.price * item.quantity;
    }
    return total;
  }

  String get customer {
    final name = order.fullName;
    if (name != null) {
      if (name.trim().isEmpty == false) {
        return order.fullName!;
      }
    }
    if (order.corpName != null) {
      if (order.corpName?.isNotEmpty == true) {
        return order.corpName!;
      }
    }

    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            context.router.push(
              OrderTrackingRoute(params: Right(order), privilage: privilege),
            );
          },
      splashColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueGrey.shade100,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/package.png',
                            width: 18,
                            color: context.colorScheme.primary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${order.id.toString()} ~ ',
                            style: context.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 150,
                            ),
                            child: Text(
                              customer,
                              maxLines: 1,
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.track_changes,
                            size: 10,
                            color: Colors.blueGrey.shade300,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Tap to track',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.blueGrey.shade300,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  5.sH,
                  Text(
                    _getStatusDateString(),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 11,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 7, bottom: 5),
                    height: 0.5,
                    color: Colors.blueGrey.shade100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount',
                            style: context.textTheme.labelSmall?.copyWith(),
                          ),
                          3.sH,
                          Text('R${totalAmount().toStringAsFixed(2)}'),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 3,
                          bottom: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(context),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          order.status.toString(),
                          style: context.textTheme.labelSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            if (bottomChildren.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Divider(thickness: .5),
              ),
            ...bottomChildren
          ],
        ),
      ),
    );
  }

  String _getStatusDateString() {
    if (order.cancelledAt != null) {
      return 'Cancelled on ${DateFormatter.formatDateToNamedayWithTime(order.cancelledAt!)}';
    }
    if (order.collectedAt != null) {
      return 'Collected on ${DateFormatter.formatDateToNamedayWithTime(order.collectedAt!)}';
    }
    if (order.readyAt != null) {
      return 'Ready for from ${DateFormatter.formatDateToNamedayWithTime(order.readyAt!)}';
    }
    if (order.packagedAt != null) {
      return 'Parkaged at ${DateFormatter.formatDateToNamedayWithTime(order.packagedAt!)}';
    }
    if (order.placedAt != null) {
      return 'Placed at ${DateFormatter.formatDateToNamedayWithTime(order.placedAt!)}';
    }
    return 'Created at ${DateFormatter.formatDateToNamedayWithTime(order.createdAt!)}';
  }

  Color _getStatusColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (order.status) {
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.collected:
        return theme.colorScheme.primary;
      case OrderStatus.packaged:
        return Colors.orange;
      case OrderStatus.placed:
        return Colors.blue;
      case OrderStatus.ready:
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }
}
