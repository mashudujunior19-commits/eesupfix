import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/models/receiver_role.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
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
          // Always hand the latest receivers/roles back, including on a
          // system back gesture, so the order screen never keeps (and later
          // re-saves) a stale copy.
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop) Navigator.of(context).pop(_result);
            },
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: () {
                    Navigator.of(context).pop(_result);
                  },
                ),
                title: const Text('ASSIGN RECEIVERS'),
                actions: [
                  if (!order.isClosed)
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
                child: BlocConsumer<OrderReceiversBloc, OrderReceiversState>(
                  listenWhen: (_, state) =>
                      state is OrderReceiversLoaded && state.saveError != null,
                  listener: (context, state) {
                    context.snackBarError(
                      (state as OrderReceiversLoaded).saveError!,
                    );
                  },
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
                          if (order.isClosed)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 22, right: 22),
                              child: Text(
                                'Once the order is closed the receivers cannot be modified.',
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
                                      // Master orders only have receivers, so the
                                      // role is set automatically.
                                      Text(
                                        ReceiverRole.receiver.label,
                                        style: context.textTheme.labelSmall
                                            ?.copyWith(
                                          color: context.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                      if (!order.isClosed)
                                        InkWell(
                                          onTap: () async {
                                            final bloc = context
                                                .read<OrderReceiversBloc>();
                                            final sure =
                                                await context.confirmAction(
                                              'Remove receiver',
                                              'Are you sure you want to remove ${member.fullName}? Their assigned role will be removed too.',
                                              confirmText: 'Yes, remove',
                                              destructive: true,
                                            );
                                            if (!sure) return;
                                            bloc.add(
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
