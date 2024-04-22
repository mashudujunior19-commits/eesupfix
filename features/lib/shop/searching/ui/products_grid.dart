import 'package:data_sources/shopping/models/product.dart';
import 'package:data_sources/shopping/models/product_filter.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/shop/searching/ui/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.filter, required this.products});
  final ProductFilter filter;
  final List<Product> products;

  List<Product> orderedProducts(ProductFilter filter) {
    //price low to high
    switch (filter.sort) {
      case ProductSortEnums.priceLowToHigh:
        products.sort((a, b) => a.salePrice.compareTo(b.salePrice));
        break;
      case ProductSortEnums.priceHighToLow:
        products.sort((a, b) => b.salePrice.compareTo(a.salePrice));
        break;
      case ProductSortEnums.nameAtoZ:
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ProductSortEnums.nameZtoA:
        products.sort((a, b) => b.name.compareTo(a.name));
        break;
      case ProductSortEnums.defaultSort:
        return products;
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    // final products = orderedProducts(filter);
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.71,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 200),
      children: List.generate(
        products.length,
        (index) {
          return ProductCard(
            product: products[index],
          )
              .animate()
              .fadeIn(delay: (200 + index * 50).ms)
              .slideIn(10.00 * index);
        },
      ),
    );
  }
}
