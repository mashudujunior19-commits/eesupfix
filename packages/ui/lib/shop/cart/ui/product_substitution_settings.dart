import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductSubstitutionSettings extends StatefulWidget {
  const ProductSubstitutionSettings({
    super.key,
    required this.onSaved,
    required this.substituteBrands,
    required this.substituteVariants,
  });
  final bool substituteVariants;
  final bool substituteBrands;
  final void Function(bool brand, bool variant) onSaved;

  @override
  State<ProductSubstitutionSettings> createState() =>
      _ProductSubstitutionSettingsState();
}

class _ProductSubstitutionSettingsState
    extends State<ProductSubstitutionSettings> {
  bool brand = false;
  bool variant = false;

  @override
  void initState() {
    super.initState();
    brand = widget.substituteBrands;
    variant = widget.substituteVariants;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(thickness: .3),
        ExpandedTile(
          theme: const ExpandedTileThemeData(
            headerColor: Colors.transparent,
            headerRadius: 0,
            headerPadding: EdgeInsets.only(right: 10),
            headerSplashColor: Colors.transparent,
            contentBackgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.only(left: 15, right: 15),
            contentRadius: 0,
          ),
          controller: ExpandedTileController(isExpanded: false),
          title: Row(
            children: [
              const Icon(IconlyLight.setting, size: 14),
              5.sW,
              Text(
                "Substitute settings",
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 13.5,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          trailing: Icon(
            IconlyLight.arrowRight2,
            size: 15,
            color: Colors.grey.shade900,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'Product Variants',
                  style: context.textTheme.labelSmall,
                ),
                subtitle: Text(
                  'Tick if you want to accept substitute product variants. should the original product be out of stock.',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                trailing: Checkbox(
                  value: variant,
                  onChanged: (value) {
                    setState(() {
                      variant = value ?? false;
                    });
                  },
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'Product Brands',
                  style: context.textTheme.labelSmall,
                ),
                subtitle: Text(
                  'Tick if you want to accept substitute product brands. should the original product be out of stock.',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                trailing: Checkbox(
                  value: brand,
                  onChanged: (value) {
                    setState(() {
                      brand = value ?? false;
                    });
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    widget.onSaved(brand, variant);
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ],
    );
  }
}
