import 'package:data/eesupreneur/models/eesupreneur.dart';
import 'package:data/orders/models/order.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:ui/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/kasipreneur/bloc/orders_bloc.dart';
import 'package:ui/orders/listing/ui/order_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';

class KasipreneurOrdersTab extends StatelessWidget {
  const KasipreneurOrdersTab({super.key, required this.eesupreneur});
  final EESUpreneur eesupreneur;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          KasipreneurOrdersBloc(context.read<OrderRepository>())
            ..add(
              OrdersFetched(
                  eesupreneur.id,
                  OrderStatus.values
                      .where((e) => e != OrderStatus.pending)
                      .toList(),
                  500),
            ),
      child: BlocBuilder<KasipreneurOrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const FullScreenLoadingShimmer();
          } else if (state is OrdersLoaded) {
            final orders = state.orders;
            if (orders.isEmpty) {
              return FullScreenError(
                isError: false,
                exception: EESUpException(
                  message: 'You don\'t '
                      'have orders yet',
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 300),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(
                  order: order,
                  privilege: OrderEditPrivilage.all,
                ).animate().slideIn(index * 50);
              },
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
    );
  }
}
