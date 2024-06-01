import 'package:data/orders/models/order.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/orders/listing/bloc/orders_filter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'orders_statues_filter_dialog.dart';

class OrdersStatusesButton extends StatelessWidget {
  const OrdersStatusesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersFilterBloc, OrdersFilterState>(
      builder: (context, state) {
        final statuses = (state as OrdersFilter).statuses;
        return Expanded(
          child: InkWell(
            onTap: () {
              context
                  .showBottomSheetDialog(
                radius: BorderRadius.circular(15),
                margin: EdgeInsets.only(
                  bottom: context.width * .55,
                  top: context.width * .35,
                  left: 10,
                  right: 10,
                ),
                child: OrdersStatuesFilterDialog(selected: statuses),
              )
                  .then((value) {
                if (value != null) {
                  final newStatuse = value as List<OrderStatus>;
                  context.read<OrdersFilterBloc>().add(
                        OrdersFiltersChanged(newStatuse, state.limit),
                      );
                }
              });
            },
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(left: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Statuses(${statuses.length})',
                    style: context.textTheme.labelMedium,
                  ),
                  5.sW,
                  const Icon(IconlyLight.arrowDown2,
                      size: 20, color: Colors.black)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
