import 'package:data_sources/orders/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class OrdPrimaryInfo extends StatelessWidget {
  const OrdPrimaryInfo({super.key, required this.order});
  final Order order;

  double totalAmount() {
    double total = 0;
    for (var item in order.products) {
      total += item.price * item.quantity;
    }
    return total;
  }

  String get customer {
    final name = order.fullName;
    if (name != null) {
      if (name.trim().isEmpty == false) {
        return order.fullName!;
      }
    }
    if (order.corpName != null) {
      if (order.corpName?.isNotEmpty == true) {
        return order.corpName!;
      }
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blueGrey.shade100,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: colorScheme.primary.withOpacity(0.12),
              child: Icon(
                IconlyLight.profile,
                color: colorScheme.primary,
                size: 20,
              ),
            ),
            title: Text('Contact person', style: textTheme.labelSmall),
            subtitle: Text(
              customer,
              style: textTheme.labelMedium,
            ),
          ),
          const Divider(thickness: .3),
          if (order.deliveryFee != null)
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundColor: colorScheme.primary.withOpacity(0.12),
                child: Icon(
                  IconlyLight.location,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              title: Text('Delivery Address', style: textTheme.labelMedium),
              subtitle: Text(
                order.address?.streetAddress ?? '~',
                style: textTheme.labelSmall,
              ),
            )
          else
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundColor: colorScheme.primary.withOpacity(0.12),
                child: Icon(
                  IconlyLight.location,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              title: const Text('Delivery method'),
              subtitle: Text('Collection', style: textTheme.labelSmall),
            ),
          const Divider(thickness: .3),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundColor: colorScheme.primary.withOpacity(0.12),
              child: Icon(
                IconlyLight.wallet,
                color: colorScheme.primary,
                size: 20,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment', style: textTheme.labelMedium),
                Text('Amount', style: textTheme.labelMedium),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.paymentMethod.toString(),
                  style: textTheme.labelSmall,
                ),
                Column(
                  children: [
                    Text(
                      'R${totalAmount().toStringAsFixed(2)}',
                      style: textTheme.labelSmall,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
