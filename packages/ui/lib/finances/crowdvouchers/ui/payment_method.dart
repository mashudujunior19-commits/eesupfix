import 'package:data/finance/models/payment_gateway.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.amount,
    this.isVisible = true,
    this.gateway,
  });
  final bool isVisible;
  final double amount;
  final PaymentGateway? gateway;
  final void Function(PaymentGateway?) onTap;
  final String title;
  final String subtitle;
  final String imagePath;

  double? fee() {
    if (gateway == null) return null;
    final fee = amount * (gateway!.fee / 100);
    return fee;
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return 0.sH;
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 20, left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: .5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10, right: 10),
        onTap: () => onTap(gateway),
        leading: Image.asset(imagePath, width: 40),
        title: Text(
          title,
          style: context.textTheme.labelMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (fee() != null)
              Text(
                'Additional fee R${fee()?.toStringAsFixed(2) ?? 0.00} (${gateway?.fee.toStringAsFixed(2) ?? 0.00}%)',
                style: context.textTheme.labelMedium?.copyWith(fontSize: 11),
              ),
            Text(
              subtitle,
              style: context.textTheme.labelSmall?.copyWith(fontSize: 11),
            ),
          ],
        ),
        trailing: const Icon(IconlyLight.arrowRight2, size: 20),
      ),
    );
  }
}
