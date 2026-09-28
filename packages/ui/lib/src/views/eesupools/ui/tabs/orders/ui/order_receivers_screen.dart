import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/models/receiver_role.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/ui/member_card.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/ui/select_member_dialog.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/bloc/order_receivers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';

/// What [OrderReceiverScreen] pops back to its caller: the current receiver
/// ids and their assigned roles, so the caller (the order details screen)
/// can update its own copy of the order without a full refetch.
typedef OrderReceiversResult = ({
  List<String> ids,
  Map<String, ReceiverRole> roles,
});

@RoutePage()
// ignore: must_be_immutable
class OrderReceiverScreen extends StatelessWidget {
  OrderReceiverScreen({
    super.key,
    required this.order,
    required this.pool,
    required this.ids,
  });
  final EESUpool pool;
  final EESUpoolOrder order;
  final List<String> ids;

  OrderReceiversResult _result = (ids: const [], roles: const {});

  @override
  Widget build(BuildContext context) {
    _result = (ids: ids, roles: order.receiverRoles);
    return BlocProvider(
      create: (context) => OrderReceiversBloc(context.read<EESUpoolRepository>())
        ..add(OrderReceiversFetched(ids, order.receiverRoles)),
      child: BlocBuilder<OrderReceiversBloc, OrderReceiversState>(
        builder: (context, state) {
          return SizedBox(
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: () {
                    Navigator.of(context).pop(_result);
                  },
                ),
                title: const Text('ORDER RECEIVERS'),
                actions: [
                  if (order.deliveredAt == null)
                    IconButton(
                      onPressed: () {
                        context
                            .showBottomSheetDialog(
                                child: SelectMemberDialog(pool: pool))
                            .then((value) {
                          if (value != null) {
                            if (value is EESUpoolMember) {
                              context.read<OrderReceiversBloc>().add(
                                    OrderReceiverAdded(order.id, value),
                                  );
                            }
                          }
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                ],
              ),
              body: Container(
                decoration: context.bgImage,
                height: context.height,
                child: BlocBuilder<OrderReceiversBloc, OrderReceiversState>(
                  builder: (context, state) {
                    if (state is OrderReceiversLoading) {
                      return const FullScreenLoadingShimmer();
                    } else if (state is OrderReceiversLoaded) {
                      final members = state.receivers;
                      _result = (
                        ids: members.map((e) => e.memberId).toList(),
                        roles: state.roles,
                      );
                      return Column(
                        children: [
                          if (order.deliveredAt != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 22, right: 22),
                              child: Text(
                                'Once the order has been received the receivers cannot be modified.',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 11.5,
                                ),
                              ),
                            ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              itemBuilder: (context, index) {
                                final member = members[index];
                                return MemberCard(
                                  member: member,
                                  pool: pool,
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _RoleDropdown(
                                        role: state.roles[member.memberId],
                                        enabled: order.deliveredAt == null,
                                        onChanged: (role) {
                                          context.read<OrderReceiversBloc>().add(
                                                OrderReceiverRoleAssigned(
                                                  order.id,
                                                  member.memberId,
                                                  role,
                                                ),
                                              );
                                        },
                                      ),
                                      if (order.deliveredAt == null)
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<OrderReceiversBloc>()
                                                .add(
                                                  OrderReceiverRemoved(
                                                    order.id,
                                                    member,
                                                  ),
                                                );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Icon(
                                              IconlyLight.delete,
                                              size: 20,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: members.length,
                            ),
                          ),
                        ],
                      );
                    } else if (state is OrderReceiversError) {
                      return FullScreenError(exception: state.error);
                    } else {
                      return FullScreenError(
                        exception: EESUpException(message: ''),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RoleDropdown extends StatelessWidget {
  const _RoleDropdown({
    required this.role,
    required this.enabled,
    required this.onChanged,
  });

  final ReceiverRole? role;
  final bool enabled;
  final ValueChanged<ReceiverRole?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 100,
      child: DropdownButton<ReceiverRole?>(
        value: role,
        isExpanded: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        underline: const SizedBox(),
        icon: enabled ? const Icon(IconlyLight.arrowDown2, size: 16) : null,
        hint: Text(
          'No role',
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.grey.shade500,
            fontSize: 11,
          ),
        ),
        onChanged: enabled ? onChanged : null,
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
        items: [
          const DropdownMenuItem<ReceiverRole?>(
            value: null,
            child: Text('No role'),
          ),
          ...ReceiverRole.values.map(
            (r) => DropdownMenuItem<ReceiverRole?>(
              value: r,
              child: Text(r.label),
            ),
          ),
        ],
      ),
    );
  }
}
