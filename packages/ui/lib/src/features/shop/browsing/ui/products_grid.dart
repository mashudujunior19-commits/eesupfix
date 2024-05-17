import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/models/product_filter.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/features/shop/browsing/ui/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.filter,
    required this.products,
  });
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
    final sortedProducts = orderedProducts(filter);
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.71,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 200),
      children: [
        for (int i = 0; i < sortedProducts.length; i++)
          ProductCard(
            product: sortedProducts[i],
          ).animate().slideIn(10.00 * i),
        // InkWell(
        //   onTap: () {},
        //   child: Container(
        //     padding: const EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //       color: Colors.white.withOpacity(.3),
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //         color: Colors.grey.shade200,
        //         width: 1,
        //       ),
        //     ),
        //     child: Center(
        //       child: Text(
        //         'Load more',
        //         style: context.textTheme.bodySmall?.copyWith(
        //           decoration: TextDecoration.underline,
        //           color: context.colorScheme.primary,
        //           fontSize: 16,
        //           fontStyle: FontStyle.italic,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Can't find what you are looking for?",
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.router.push(const BrowseShopRoute());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Search',
                      style: context.textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        color: context.colorScheme.primary,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    5.sW,
                    const Icon(BootstrapIcons.search, size: 16),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
