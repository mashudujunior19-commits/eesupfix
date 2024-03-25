import 'package:data_sources/orders/models/order.dart';
import 'package:features/core/errors/large_error_widget.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/large_loading_shimmer.dart';
import 'package:features/orders/listing/bloc/orders_bloc.dart';
import 'package:features/orders/listing/bloc/orders_filter_bloc.dart';
import 'package:features/orders/listing/ui/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:repository/orders/order_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrdersBloc(context.read<OrderRepository>())
            ..add(
              OrdersFetched(OrderStatus.values, 10),
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
        child: Column(
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
              child: Row(
                children: [OrdersLimitFilter()],
              ),
            ),
            BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const LargeLoadingShimmer();
                } else if (state is OrdersLoaded) {
                  final orders = state.orders;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return OrderCard(
                          order: order,
                          previllage: OrderEditPrivilage.owner,
                        ).animate().slideIn(index * 50);
                      },
                    ),
                  );
                } else {
                  return LargeErrorWidget(
                    exception: EESUpException(
                      message: 'Something went wrong while '
                          'we were trying to fetch your orders.',
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersLimitFilter extends StatelessWidget {
  const OrdersLimitFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<OrdersFilterBloc, OrdersFilterState>(
        builder: (context, state) {
          final limit = (state as OrdersFilter).limit;

          return DropdownButton<int>(
              underline: 0.sW,
              value: limit,
              dropdownColor: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(IconlyLight.arrowDown2,
                  size: 16, color: Colors.black),
              items: [10, 30, 150, 1000]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e == 1000 ? 'Show all' : 'Show $e',
                          style: context.textTheme.labelSmall,
                        ),
                      ))
                  .toList(),
              onChanged: (v) {
                context
                    .read<OrdersFilterBloc>()
                    .add(OrdersFiltersChanged(state.statuses, v ?? 10));
              });
        },
      ),
    );
  }
}
