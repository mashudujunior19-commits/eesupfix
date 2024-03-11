import 'package:eesup_data_source/shopping/models/product.dart';
import 'package:eesup_ui_library/core/extensions/context_theme_ext.dart';
import 'package:eesup_ui_library/features/shop/overview/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HoriProductSlider extends StatelessWidget {
  const HoriProductSlider({
    super.key,
    required this.label,
    required this.products,
  });
  final String label;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    products.shuffle();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
          child: Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              products.length,
              (index) => ProductCard(
                isBundle: true,
                product: products[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
