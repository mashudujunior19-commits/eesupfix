import 'package:data_sources/shopping/models/product_filter.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductsFilterDialog extends StatefulWidget {
  const ProductsFilterDialog({super.key, required this.currentFilter});
  final ProductFilter currentFilter;

  @override
  State<ProductsFilterDialog> createState() => _ProductsFilterDialogState();
}

class _ProductsFilterDialogState extends State<ProductsFilterDialog> {
  ProductFilter filter = const ProductFilter(
    limit: 50,
    sort: ProductSortEnums.defaultSort,
  );

  @override
  void initState() {
    super.initState();
    filter = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Filter'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButton<int>(
              // Initial Value
              value: filter.limit,
              dropdownColor: Colors.white,

              isExpanded: true,
              borderRadius: BorderRadius.circular(15),
              underline: const SizedBox.shrink(),
              // Down Arrow Icon
              icon: const Icon(IconlyLight.arrowDown2, size: 17),

              // Array list of items
              items: [50, 200, 500, 10000].map((int value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value == 10000 ? 'Show all' : 'Show $value Items',
                    style: context.textTheme.labelSmall,
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (int? newValue) {
                if (newValue == null) return;
                setState(() {
                  filter = filter.copyWith(limit: newValue);
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButton<ProductSortEnums>(
              // Initial Value
              value: filter.sort,
              isExpanded: true, dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              underline: const SizedBox.shrink(),
              // Down Arrow Icon
              icon: const Icon(IconlyLight.arrowDown2, size: 17),

              // Array list of items
              items: ProductSortEnums.values.map((ProductSortEnums value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: context.textTheme.labelSmall,
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (ProductSortEnums? newValue) {
                if (newValue == null) return;
                setState(() {
                  filter = filter.copyWith(sort: newValue);
                });
              },
            ),
          ),
          20.sH,
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(filter);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.done_all, size: 18),
                5.sW,
                const Text('Filter'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
