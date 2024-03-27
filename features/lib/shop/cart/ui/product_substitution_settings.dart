import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductSubstitutionSettings extends StatelessWidget {
  const ProductSubstitutionSettings({
    super.key,
    required this.substituteVariants,
    required this.substituteBrands,
    required this.onVariantChanged,
    required this.onBrandChanged,
    this.isExpanded = false,
    this.onTap,
  });
  final VoidCallback? onTap;
  final bool isExpanded;
  final bool substituteVariants;
  final bool substituteBrands;
  final void Function(bool? value) onVariantChanged;
  final void Function(bool? value) onBrandChanged;

  @override
  Widget build(BuildContext context) {
    return ExpandedTile(
      onTap: onTap,
      theme: const ExpandedTileThemeData(
        headerColor: Colors.transparent,
        headerRadius: 0,
        headerPadding: EdgeInsets.only(right: 10),
        headerSplashColor: Colors.transparent,
        contentBackgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.only(left: 13, right: 0),
        contentRadius: 0,
      ),
      controller: ExpandedTileController(isExpanded: isExpanded),
      title: Text(
        "Substitute settings",
        style: context.textTheme.labelMedium?.copyWith(
          decoration: TextDecoration.underline,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        IconlyLight.arrowRight2,
        size: 20,
        color: Colors.black,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              'Product Variants',
              style: context.textTheme.labelMedium,
            ),
            subtitle: Text(
              'Tick if you want to accept substitute product variants. should the original product be out of stock.',
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            trailing: Checkbox(
              value: substituteVariants,
              onChanged: onVariantChanged,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              'Product Brands',
              style: context.textTheme.labelMedium,
            ),
            subtitle: Text(
              'Tick if you want to accept substitute product brands. should the original product be out of stock.',
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            trailing: Checkbox(
              value: substituteBrands,
              onChanged: onBrandChanged,
            ),
          ),
        ],
      ),
    );
  }
}
