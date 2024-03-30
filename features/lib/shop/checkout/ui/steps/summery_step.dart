import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class SummeryStep extends StatelessWidget {
  const SummeryStep({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
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
              const Text('Order Summery'),
              20.sH,
              const _LineTile(label: 'Payment method', value: 'Ozow'),
              const Divider(height: 30, thickness: .35),
              const _LineTile(label: 'Subtotal', value: 'Ozow'),
              const Divider(height: 30, thickness: .35),
              const _LineTile(label: 'Card fee', value: 'Ozow'),
              const Divider(height: 30, thickness: .35),
              const _LineTile(label: 'Delivery fee', value: 'Ozow'),
              const Divider(height: 30, thickness: .35),
              const _LineTile(label: 'Total', value: 'Ozow', isBold: true),
            ],
          ),
        ),
        Image.asset("assets/images/receipt_bottom.png"),
        30.sH,
        ElevatedButton(
          onPressed: () {},
          child: const Text("Place order"),
        )
      ],
    );
  }
}

class _LineTile extends StatelessWidget {
  const _LineTile({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });
  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
