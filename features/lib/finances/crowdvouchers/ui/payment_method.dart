import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
  final void Function() onTap;
  final String title;
  final String subtitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
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
        onTap: onTap,
        leading: Image.asset(imagePath, width: 40),
        title: Text(
          title,
          style: context.textTheme.labelMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: context.textTheme.labelSmall?.copyWith(fontSize: 11),
        ),
        trailing: const Icon(IconlyLight.arrowRight2, size: 20),
      ),
    );
  }
}
