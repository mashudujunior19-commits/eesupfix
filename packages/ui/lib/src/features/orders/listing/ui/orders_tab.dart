import 'package:data/orders/models/order.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/orders/listing/bloc/orders_bloc.dart';
import 'package:ui/src/features/orders/listing/bloc/orders_filter_bloc.dart';
import 'package:ui/src/features/orders/listing/ui/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';
import 'orders_limit_filter.dart';
import 'orders_statuses_button.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrdersBloc(context.read<OrderRepository>())
            ..add(
              OrdersFetched(OrderStatus.values, 500),
            ),
        ),
        BlocProvider(create: (context) => OrdersFilterBloc()),
      ],
      child: BlocListener<OrdersFilterBloc, OrdersFilterState>(
        listener: (context, state) {
          if (state is OrdersFilter) {
            final statuses = state.statuses;
            final limit = state.limit;
            context.read<OrdersBloc>().add(OrdersFetched(statuses, limit));
          }
        },
        child: BlocBuilder<OrdersFilterBloc, OrdersFilterState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.width,
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 5,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [OrdersLimitFilter(), OrdersStatusesButton()],
                  ),
                ),
                BlocBuilder<OrdersBloc, OrdersState>(
                  builder: (context, state) {
                    if (state is OrdersLoading) {
                      return const FullScreenLoadingShimmer();
                    } else if (state is OrdersLoaded) {
                      final orders = state.orders;
                      if (orders.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 250),
                          child: FullScreenError(
                            isError: false,
                            exception: EESUpException(
                              message: 'You don\'t orders yet.',
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 300),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];
                            return OrderCard(
                              order: order,
                              privilege: OrderEditPrivilage.owner,
                            ).animate().slideIn(index * 50);
                          },
                        ),
                      );
                    } else {
                      return FullScreenError(
                        exception: EESUpException(
                          message: 'Something went wrong while '
                              'we were trying to fetch your orders.',
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
