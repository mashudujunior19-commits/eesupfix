import 'package:data_sources/orders/models/order.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/shop/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutError) {
          context.read<CheckoutBloc>().add(
                CheckoutStarted(
                  state.order.value,
                  state.order.products,
                ),
              );
          tabController.animateTo(0);
        }
      },
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          Order? newOrder;
          double? total;
          if (state is CurrentCheckout) {
            newOrder = state.newOrder;
            total = state.totalToPay();
          }
          return ListView(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    const Text('Order Summary'),
                    20.sH,
                    _LineTile(
                      label: 'Payment method',
                      value:
                          newOrder?.paymentMethod.toString() ?? "No selected",
                    ),
                    _LineTile(
                      label: 'Subtotal',
                      value: 'R${newOrder?.value.toStringAsFixed(2) ?? '0.00'}',
                    ),
                    _LineTile(
                      label: 'Card fee',
                      isVisible: newOrder?.cardFee != null,
                      value:
                          'R${newOrder?.cardFee?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                    _LineTile(
                      label: 'Delivery fee',
                      value:
                          "R${newOrder?.deliveryFee?.toStringAsFixed(2) ?? 0.00}",
                    ),
                    _LineTile(
                      label: 'Total',
                      value: "R${total?.toStringAsFixed(2) ?? 0.00}",
                      isBold: true,
                    ),
                  ],
                ),
              ),
              Image.asset("assets/images/receipt_bottom.png"),
              30.sH,
              ElevatedButton(
                onPressed: () {
                  context.read<CheckoutBloc>().add(OrderPlaced());
                },
                child: const Text("Place order"),
              )
            ],
          );
        },
      ),
    );
  }
}

class _LineTile extends StatelessWidget {
  const _LineTile({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isVisible = true,
  });
  final String label;
  final String value;
  final bool isBold;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return 0.sW;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 13,
                fontWeight: isBold ? FontWeight.bold : null,
              ),
            ),
            Text(
              value,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 13,
                fontWeight: isBold ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        const Divider(height: 30, thickness: .35),
      ],
    );
  }
}
