import 'package:data/shopping/models/product_filter.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/features/shop/browsing/bloc/products_filter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingFiltersButton extends StatelessWidget {
  const ShoppingFiltersButton({
    super.key,
    required this.filter,
  });
  final ProductFilter filter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .showBottomSheetDialog(
          margin: EdgeInsets.only(top: context.height * .6),
          child: _ProductsFilterDialog(currentFilter: filter),
        )
            .then((value) {
          if (value != null) {
            context.read<ProductsFilterBloc>().add(
                  ProductsFiltersChanged(value as ProductFilter),
                );
          }
        });
      },
      child: const Padding(
        padding: EdgeInsets.only(right: 15),
        child: Icon(IconlyLight.filter, size: 24.5),
      ),
    );
  }
}

class _ProductsFilterDialog extends StatefulWidget {
  const _ProductsFilterDialog({required this.currentFilter});
  final ProductFilter currentFilter;

  @override
  State<_ProductsFilterDialog> createState() => __ProductsFilterDialogState();
}

class __ProductsFilterDialogState extends State<_ProductsFilterDialog> {
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
        title: const Text('Sort'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 100),
        children: [
          // Container(
          //   padding: const EdgeInsets.only(left: 10, right: 10),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(13),
          //     border: Border.all(color: Colors.grey.shade300),
          //   ),
          //   child: DropdownButton<int>(
          //     // Initial Value
          //     value: filter.limit,
          //     dropdownColor: Colors.white,

          //     isExpanded: true,
          //     borderRadius: BorderRadius.circular(15),
          //     underline: const SizedBox.shrink(),
          //     // Down Arrow Icon
          //     icon: const Icon(IconlyLight.arrowDown2, size: 17),

          //     // Array list of items
          //     items: [50, 200, 500, 10000].map((int value) {
          //       return DropdownMenuItem(
          //         value: value,
          //         child: Text(
          //           value == 10000 ? 'Show all' : 'Show $value Items',
          //           style: context.textTheme.labelSmall,
          //         ),
          //       );
          //     }).toList(),
          //     // After selecting the desired option,it will
          //     // change button value to selected value
          //     onChanged: (int? newValue) {
          //       if (newValue == null) return;
          //       setState(() {
          //         filter = filter.copyWith(limit: newValue);
          //       });
          //     },
          //   ),
          // ),

          Container(
            margin: const EdgeInsets.only(top: 0),
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
                const Text('Sort'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
