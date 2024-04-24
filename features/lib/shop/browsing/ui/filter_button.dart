import 'package:data_sources/shopping/models/product_filter.dart';
import 'package:features/core/extensions/bottom_sheet_context_ext.dart';
import 'package:features/shop/browsing/bloc/products_filter_bloc.dart';
import 'package:features/shop/browsing/ui/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

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
          child: ProductsFilterDialog(currentFilter: filter),
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
