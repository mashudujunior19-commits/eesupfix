import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/orders/models/order.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/eesupools/ui/tabs/orders/bloc/member_orders_bloc.dart';
import 'package:ui/src/features/eesupools/ui/tabs/orders/ui/edit_member_assignment_role.dart';
import 'package:ui/src/features/orders/listing/ui/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';

class MemberOrdersTab extends StatelessWidget {
  const MemberOrdersTab({
    super.key,
    required this.pool,
    required this.poolOrder,
  });
  final EESUpool pool;
  final EESUpoolOrder poolOrder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemberOrdersBloc(
          context.read<EESUpoolRepository>(), context.read<OrderRepository>())
        ..add(MemberOrdersFetched(
            OrderStatus.values.where((e) => e != OrderStatus.pending).toList(),
            500,
            poolOrder.id)),
      child: BlocBuilder<MemberOrdersBloc, MemberOrdersState>(
        builder: (context, state) {
          if (state is OrdersLoaded) {
            final orders = state.orders;
            if (orders.isNotEmpty) {
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: EESUpTextFormField(
                      margin: const EdgeInsets.only(
                        left: 23,
                        right: 21,
                        top: 10,
                      ),
                      hintText: 'Search ORDER-ID, MEMBER NAME',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Icon(IconlyLight.search,
                            size: 21, color: Colors.grey),
                      ),
                      onSubmit: (value) {},
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 400),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return _OrderCardX(
                          order: orders[index],
                          pool: pool,
                          poolOrder: poolOrder,
                        );
                      },
                    ),
                  ),
                ],
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
  const _OrderCardX({
    required this.order,
    required this.pool,
    required this.poolOrder,
  });
  final EESUpool pool;
  final Order order;
  final EESUpoolOrder poolOrder;

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

    if (order.assignments.isEmpty) {
      return false;
    }

    final memberId = pool.memberId;
    return order.assignments.any((element) => element.memberId == memberId);
  }

  OrderEditPrivilage getPrevillage() {
    if (poolOrder.deliveredAt == null) {
      return OrderEditPrivilage.none;
    }
    try {
      final memberId = pool.memberId;
      final assignment = order.assignments.firstWhere(
        (element) => element.memberId == memberId,
      );
      return assignment.privilage ?? OrderEditPrivilage.none;
    } catch (e) {
      return OrderEditPrivilage.none;
    }
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
        context.router.push(
          OrderTrackingRoute(id: order.id!, privilage: getPrevillage()),
        );
      },
      bottomChildren: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ExpandedTile(
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
                if (pool.role == EESUpoolMemberRole.admin)
                  InkWell(
                    onTap: () {
                      context
                          .showBottomSheetDialog(
                              child: EditOrderAssignmentsDialog(
                                  order: order, pool: pool))
                          .then((value) {
                        if (value is List<MemberOrderAssignment>) {
                          context.read<MemberOrdersBloc>().add(
                                MemberOrderAssignmentsUpdated(order.id!, value),
                              );
                        }
                      });
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
        ),
      ],
    );
  }

  Padding _assignmentCard(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 15,
                child: const Icon(
                  BootstrapIcons.person,
                  color: Colors.grey,
                  size: 13,
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
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    order.assignments[index].privilage.toString(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 10,
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
