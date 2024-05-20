import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/eesupools/ui/tabs/orders/bloc/orders_bloc.dart';
import 'package:ui/src/features/eesupools/ui/tabs/orders/ui/create_order_dialog.dart';
import 'package:ui/src/features/eesupools/ui/tabs/orders/ui/eesupool_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';

class OrdersPoolTab extends StatelessWidget {
  const OrdersPoolTab({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(context.read<EESUpoolRepository>())
        ..add(PoolOrdersFetched(pool.eesupoolId!, 500)),
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoaded) {
            final openOrder = state.openOrder;
            final orders = state.orders;
            return Scaffold(
              backgroundColor: Colors.transparent,
              //IF THERE IS NO POOL ORDER THEN DISPLAY CREATE ORDER BUTTON
              floatingActionButton:
                  openOrder == null && pool.role == EESUpoolMemberRole.admin
                      ? _CreateOrderButton(pool: pool, openOrder: openOrder)
                      : null,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //DISPLAY OPEN/CURRENT EESUPOOL ORDER, IF THE IS ONE
                  if (openOrder != null)
                    _CurrentOrderCard(
                      openOrder: openOrder,
                      pool: pool,
                    ),
                  15.sH,
                  //DISPLAY ALL THE OTHER ORDERS
                  _OrdersHistory(
                    orders: orders,
                    openOrder: openOrder,
                    pool: pool,
                  ),
                ],
              ),
            );
          } else if (state is OrdersError) {
            return FullScreenError(exception: state.error);
          } else if (state is OrdersLoading) {
            return const FullScreenLoadingShimmer();
          } else {
            return FullScreenError(
              exception: EESUpException(
                message: 'Something went wrong'
                    ' while trying to fetch orders.',
              ),
            );
          }
        },
      ),
    );
  }
}

class _OrdersHistory extends StatelessWidget {
  const _OrdersHistory({
    required this.orders,
    required this.openOrder,
    required this.pool,
  });

  final List<EESUpoolOrder> orders;
  final EESUpoolOrder? openOrder;
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (orders.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('History'),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    //  width: context.width * .75,
                    height: .3,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        if (orders.isEmpty || orders.length == 1)
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: FullScreenError(
              isError: false,
              exception: EESUpException(
                message: 'There are no orders yet.',
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final o = orders[index];
                if (o.id == openOrder?.id) {
                  return 0.sW;
                }
                return EESUpoolOrderCard(
                  order: o,
                  pool: pool,
                );
              },
              itemCount: orders.length,
            ),
          ),
      ],
    );
  }
}

class _CurrentOrderCard extends StatelessWidget {
  const _CurrentOrderCard({required this.openOrder, required this.pool});

  final EESUpoolOrder openOrder;
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Current Order'),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  //  width: context.width * .75,
                  height: .3,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        EESUpoolOrderCard(order: openOrder, pool: pool),
      ],
    );
  }
}

class _CreateOrderButton extends StatelessWidget {
  const _CreateOrderButton({
    required this.pool,
    required this.openOrder,
  });

  final EESUpool pool;
  final EESUpoolOrder? openOrder;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: context.colorScheme.primary,
      onPressed: () {
        context
            .showBottomSheetDialog(
          child: CreatePoolOrderDialog(pool: pool, order: openOrder),
        )
            .then((value) {
          context.read<OrdersBloc>().add(
                PoolOrdersFetched(pool.eesupoolId!, 500),
              );
        });
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
