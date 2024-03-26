import 'package:data_sources/orders/models/order_product.dart';
import 'package:features/shop/cart/ui/product_substitution_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({super.key, required this.product});
  final OrderProduct product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      background: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              'Swipe Left to remove',
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.redAccent,
              ),
            ),
          ).animate().shimmer(duration: 1000.ms),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 17, left: 17, top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 5),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: product.imageUrl != null
                    ? Image.network(product.imageUrl!, width: 27)
                    : Image.asset('assets/images/no-photo.png',
                        width: 27, color: Colors.grey),
              ),
              title: Text(
                product.name,
                style: theme.textTheme.labelMedium?.copyWith(fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.category}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  if (product.size != null)
                    Text(
                      '${product.size}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 11.5,
                      ),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    'R${(product.price * product.quantity).toStringAsFixed(2)}',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/mark.png',
                            width: 22,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                      Text('${product.quantity}',
                          style: theme.textTheme.labelMedium),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(IconlyLight.plus),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Divider(thickness: .35),
            ),
            ProductSubstitutionSettings(
              substituteVariants: product.substituteVariant,
              substituteBrands: product.substituteBrand,
              onVariantChanged: (v) {},
              onBrandChanged: (v) {},
            )
          ],
        ),
      ),
    );
  }
}
