import 'package:auto_route/auto_route.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:data_sources/eesupools/models/eesupool_member.dart';
import 'package:data_sources/eesupools/models/eesupool_order.dart';
import 'package:features/app_route.gr.dart';
import 'package:features/core/extensions/bottom_sheet_context_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/utils/date_formatter.dart';
import 'package:features/eesupools/ui/tabs/orders/bloc/pool_order_view_bloc.dart';
import 'package:features/geolocation/ui/widgets/address_card.dart';
import 'package:features/orders/tracking/ui/confirm_order_collection.dart';
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
            right: 15,
            left: 20,
            top: 15,
          ),
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
                    child: Image.asset(
                      'assets/images/checklist.png',
                      width: 30,
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
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          DateFormatter.formatDateToNamedayWithTime3(
                              order.closesAt),
                          style: context.textTheme.labelMedium?.copyWith(
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
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          order.ordersCount.toString(),
                          style: context.textTheme.labelMedium?.copyWith(
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
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'R${order.currentAmount.toStringAsFixed(2)}',
                          style: context.textTheme.labelMedium?.copyWith(
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
                          'Delivery on: ',
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          DateFormatter.formatDateToNamedayWithTime3(
                              order.scheduleFor),
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    if (pool.role == EESUpoolMemberRole.admin)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.sH,
                          const Divider(thickness: .5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Confirm delivery: ',
                                style: context.textTheme.labelMedium?.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              Transform.scale(
                                scale: .7,
                                child: Switch(
                                  value: order.deliveredAt != null,
                                  onChanged: (value) {
                                    if (order.deliveredAt == null) {
                                      context
                                          .showBottomSheetDialog(
                                              child:
                                                  ConfirmOrderCollectionDialog(
                                                      pin: '32325',
                                                      isEESUpoolOrder: true))
                                          .then((value) {
                                        if (value == true) {
                                          context.read<PoolOrderViewBloc>().add(
                                              PoolOrderIsReceived(
                                                  DateTime.now()));
                                        }
                                      });
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (order.receiversId != null)
          InkWell(
            onTap: () {
              context.router.push(OrderReceiverRoute(ids: order.receiversId!));
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
              child: Row(
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
                        'Bulk Order Receivers',
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
            ),
          ),
        if (order.address != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text('Location'),
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
