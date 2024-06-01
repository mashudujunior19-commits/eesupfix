import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/orders/listing/bloc/orders_filter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class OrdersLimitFilter extends StatelessWidget {
  const OrdersLimitFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: BlocBuilder<OrdersFilterBloc, OrdersFilterState>(
            builder: (context, state) {
              final limit = (state as OrdersFilter).limit;

              return DropdownButton<int>(
                  underline: 0.sW,
                  value: limit,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(IconlyLight.arrowDown2,
                      size: 20, color: Colors.black),
                  items: [10, 30, 150, 1000]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e == 1000 ? 'Show all' : 'Show $e',
                              style: context.textTheme.labelMedium,
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
        ),
      ),
    );
  }
}
