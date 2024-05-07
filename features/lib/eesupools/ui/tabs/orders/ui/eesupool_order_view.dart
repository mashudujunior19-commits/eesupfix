import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/utils/date_formatter.dart';
import 'package:data_sources/eesupools/models/eesupool_member.dart';
import 'package:data_sources/eesupools/models/eesupool_order.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:features/core/widgets/fullscreen_error_widget.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/eesupools/ui/tabs/members/bloc/members_bloc.dart';
import 'package:features/eesupools/ui/tabs/orders/bloc/member_orders_bloc.dart';
import 'package:features/geolocation/ui/widgets/address_card.dart';
import 'package:features/orders/listing/ui/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:repository/orders/order_repository.dart';
import 'package:repository/utils/eesup_exception.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

@RoutePage()
class EESUpoolOrderViewScreen extends StatelessWidget {
  const EESUpoolOrderViewScreen({
    super.key,
    required this.pool,
    required this.order,
  });
  final EESUpool pool;
  final EESUpoolOrder order;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: context.bgImage,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 42,
                  padding: const EdgeInsets.only(left: 8, right: 10, top: 15),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const BackButton(),
                      TabBar(
                        dividerColor: Colors.transparent,
                        indicatorPadding: const EdgeInsets.all(0),
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        labelColor: Colors.white,
                        labelStyle: context.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: RectangularIndicator(
                          bottomLeftRadius: 8,
                          bottomRightRadius: 8,
                          topLeftRadius: 8,
                          topRightRadius: 8,
                          color: context.colorScheme.primary,
                        ),
                        tabs: const [
                          Tab(text: 'Details'),
                          Tab(text: 'Member Orders')
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _OrderDetailsTab(order: order, pool: pool),
                      _MemberOrdersTab(pool: pool, orderId: order.id)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderDetailsTab extends StatelessWidget {
  const _OrderDetailsTab({required this.order, required this.pool});
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
                    //backgroundColor: theme.colorScheme.primary.withOpacity(.1),
                    child:
                        Image.asset('assets/images/checklist.png', width: 30),
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
                    // 3.sH,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Receiver: ',
                    //       style: context.textTheme.labelMedium?.copyWith(
                    //         fontSize: 14,
                    //       ),
                    //     ),
                    //     Text(
                    //       order.receiver?.fullName ?? '~',
                    //       style: context.textTheme.labelMedium?.copyWith(
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
                          const Divider(),
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
                                  value: false,
                                  onChanged: (value) {
                                    // confirmOrderCollectionDialog(context,
                                    //         isEESUpoolOrder: true,
                                    //         pin: '132423')
                                    //     .then((value) {
                                    //   if (value == true) {}
                                    // });
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

class _MemberOrdersTab extends StatelessWidget {
  const _MemberOrdersTab({required this.pool, required this.orderId});
  final int orderId;
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemberOrdersBloc(context.read<OrderRepository>())
        ..add(MemberOrdersFetched(OrderStatus.values, 500, orderId)),
      child: BlocBuilder<MemberOrdersBloc, MemberOrdersState>(
        builder: (context, state) {
          if (state is OrdersLoaded) {
            final orders = state.orders;
            if (orders.isNotEmpty) {
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return _OrderCardX(order: orders[index], pool: pool);
                },
              );
            } else {
              return FullScreenError(
                isError: false,
                exception: EESUpException(
                  message: 'There are not orders yet,'
                      ' once ${pool.name} members have placed '
                      'their orders under this order, they will appear here',
                ),
              );
            }
          } else if (state is OrdersLoading) {
            return const FullScreenLoadingShimmer();
          } else if (state is OrdersError) {
            return FullScreenError(exception: state.exception);
          } else {
            return FullScreenError(
              exception: EESUpException(
                message: 'Something went wrong'
                    ' while fetching the orders.',
              ),
            );
          }
        },
      ),
    );
  }
}

class _OrderCardX extends StatelessWidget {
  const _OrderCardX({required this.order, required this.pool});
  final EESUpool pool;
  final Order order;

  String customer(MemberOrderAssignment assignment) {
    final name = assignment.fullName;
    if (name != null) {
      if (name.trim().isEmpty == false) {
        return assignment.fullName!;
      }
    }

    if (assignment.corpName != null) {
      if (assignment.corpName?.isNotEmpty == true) {
        return assignment.corpName!;
      }
    }

    return 'Unknown';
  }

  bool hasPrevillage() {
    if (pool.role == EESUpoolMemberRole.admin) {
      return true;
    }
    final memberId = pool.memberId;
    return order.assignments.any((element) => element.memberId == memberId);
  }

  OrderEditPrivilage getPrevillage() {
    final memberId = pool.memberId;
    final assignment = order.assignments.firstWhere(
      (element) => element.memberId == memberId,
    );

    return assignment.privilage ?? OrderEditPrivilage.none;
  }

  @override
  Widget build(BuildContext context) {
    if (hasPrevillage() == false) {
      return const SizedBox();
    }
    return OrderCard(
      order: order,
      privilege: OrderEditPrivilage.none,
      onTap: () {
        // setOrder(ref, order: order);
        // context
        //     .push(OrderTrackScreen.route, extra: getPrevillage(ref))
        //     .whenComplete(() {
        //   resetOrder(ref);
        // });
      },
      bottomChildren: [
        ExpandedTile(
          theme: const ExpandedTileThemeData(
            headerColor: Colors.transparent,
            headerRadius: 0,
            headerPadding: EdgeInsets.all(0),
            headerSplashColor: Colors.transparent,
            contentBackgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0),
            contentRadius: 0,
          ),
          controller: ExpandedTileController(isExpanded: true),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Role Assignments"),
              InkWell(
                onTap: () {
                  // editOrderAssignments(context, order: order).then((value) {
                  //   if (value == true) {
                  //     ref.invalidate(memberOrders(order.eesupoolOrderId!));
                  //   }
                  // });
                },
                child: const Icon(
                  IconlyLight.edit,
                  size: 17,
                ),
              )
            ],
          ),
          trailing: const Icon(IconlyLight.arrowRight2, size: 18),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              order.assignments.length,
              (index) => _assignmentCard(index, context),
            ),
          ),
        ),
      ],
    );
  }

  Padding _assignmentCard(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 19,
                child: const Icon(
                  BootstrapIcons.person,
                  color: Colors.grey,
                  size: 19,
                ),
              ),
              10.sW,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer(order.assignments[index]),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                    ),
                  ),
                  Text(
                    order.assignments[index].privilage.toString(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
