import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/kasipool_rules.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/models/receiver_role.dart';
import 'package:data/utils/double_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/bloc/pool_order_view_bloc.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/consolidate_order_dialog.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/create_order_dialog.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/delivary_secret.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/order_receivers_screen.dart';
import 'package:ui/src/views/geolocation/ui/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class OrderDetailsTab extends StatelessWidget {
  const OrderDetailsTab({super.key, required this.order, required this.pool});
  final EESUpool pool;
  final EESUpoolOrder order;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 15,
          ),
          padding: const EdgeInsets.only(
            right: 10,
            left: 10,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: .5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('#${order.id.toString()}'),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        color: order.isClosed
                            ? Colors.redAccent.withOpacity(.5)
                            : context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.isClosed ? 'Closed' : 'Open',
                          style: context.textTheme.labelMedium?.copyWith(
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
                    order.isClosed ? 'Closed on' : 'Closes on',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    DateFormatter.formatDateToNamedayWithTime3(order.closesAt),
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              3.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Member orders',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    order.ordersCount.toString(),
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              3.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'R${order.currentAmount.toRounded()}',
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              3.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery on: ',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    DateFormatter.formatDateToNamedayWithTime3(
                        order.scheduleFor),
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              3.sH,
              if (order.deliveredAt != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Received At',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      DateFormatter.formatDateToNamedayWithTime3(
                          order.deliveredAt!),
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              if (pool.role == EESUpoolMemberRole.admin &&
                  order.secretPin != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.sH,
                    const Divider(thickness: .5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery secret pin: ',
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 13,
                          ),
                        ),
                        DelivarySecret(secret: order.secretPin.toString())
                      ],
                    ),
                  ],
                ),
              if (pool.role == EESUpoolMemberRole.admin &&
                  !order.isClosed &&
                  order.closesAt.isAfter(DateTime.now()))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(thickness: .5),
                    TextButton(
                      onPressed: () {
                        context
                            .showBottomSheetDialog(
                          child:
                              CreatePoolOrderDialog(pool: pool, order: order),
                        )
                            .then((value) {
                          if (value is EESUpoolOrder) {
                            context
                                .read<PoolOrderViewBloc>()
                                .add(PoolOrderUpdated(value));
                          }
                        });
                      },
                      child: const Text('Edit order'),
                    ),
                  ],
                ),
              if (pool.role == EESUpoolMemberRole.admin &&
                  !order.isClosed &&
                  order.closesAt.isAfter(DateTime.now()))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(thickness: .5),
                    // The database refuses to close an order below the
                    // minimum; the button is disabled so that's clear up front.
                    TextButton(
                      onPressed: order.meetsMinimum
                          ? () {
                              context.read<PoolOrderViewBloc>().add(
                                    PoolOrderUpdated(
                                      order.copyWith(
                                        closesAt: DateTime.now().subtract(
                                          const Duration(hours: 2),
                                        ),
                                        scheduleFor: DateTime.now().add(
                                          const Duration(days: 3),
                                        ),
                                      ),
                                    ),
                                  );
                            }
                          : null,
                      child: Text(
                        'Close order',
                        style: TextStyle(
                          color: order.meetsMinimum ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                    if (!order.meetsMinimum)
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 4),
                        child: Text(
                          'An order can only close once it reaches '
                          'R${minKasipoolOrder.toRounded()}. '
                          'It is R${order.currentAmount.toRounded()} now.',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    if (!order.meetsMinimum &&
                        (order.orderExtensionCount ?? 0) > 0)
                      TextButton(
                        onPressed: () async {
                          final joined = await context.showBottomSheetDialog(
                            child: ConsolidateOrderDialog(order: order),
                          );
                          if (joined == true && context.mounted) {
                            context.snackBarSuccess(
                              'Consolidated. It can close once the combined '
                              'total reaches R${minKasipoolOrder.toRounded()}.',
                            );
                          }
                        },
                        child: const Text('Consolidate with another KasiPool'),
                      ),
                  ],
                )
            ],
          ),
        ),
        if (pool.role == EESUpoolMemberRole.admin)
          InkWell(
            onTap: () {
              try {
                context.router
                    .push(
                  OrderReceiverRoute(
                    order: order,
                    ids: order.receiversId ?? [],
                    pool: pool,
                  ),
                )
                    .then((value) {
                  if (value is OrderReceiversResult) {
                    context.read<PoolOrderViewBloc>().add(
                          PoolOrderUpdated(
                            order.copyWith(
                              receiversId: value.ids,
                              receiverRoles: value.roles,
                            ),
                          ),
                        );
                  }
                });
              } catch (e) {
                print(e);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 15, top: 15),
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: Colors.grey.shade400),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            IconlyBold.user3,
                            color: Colors.black,
                            size: 18,
                          ),
                          10.sW,
                          Text(
                            'Assign Receivers',
                            style: context.textTheme.labelMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Icon(IconlyLight.arrowRight2,
                          size: 18, color: Colors.black)
                    ],
                  ),
                  if (_receiverRolesSummary(order.receiverRoles) != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 28),
                      child: Text(
                        _receiverRolesSummary(order.receiverRoles)!,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        if (order.address != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text('Pickup Point'),
              ),
              AddressCard(
                address: order.address!,
                allowDelete: false,
                onTap: () {},
                margin: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                ),
              ),
            ],
          )
      ],
    );
  }
}

/// A short "2 Packer, 1 Distributor" style readout of who's assigned which
/// role, so the admin can see who does what without opening the receivers
/// screen. Returns null when no roles have been assigned yet.
String? _receiverRolesSummary(Map<String, ReceiverRole> roles) {
  if (roles.isEmpty) return null;
  final counts = <ReceiverRole, int>{};
  for (final role in roles.values) {
    counts[role] = (counts[role] ?? 0) + 1;
  }
  return counts.entries
      .map((e) => '${e.value} ${e.key.label}${e.value > 1 ? 's' : ''}')
      .join(', ');
}
