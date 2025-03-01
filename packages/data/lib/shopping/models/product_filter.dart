// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_filter.freezed.dart';

@freezed
abstract class ProductFilter with _$ProductFilter {
  const factory ProductFilter({
    required int limit,
    required ProductSortEnums sort,
  }) = _ProductFilter;
}

enum ProductSortEnums {
  priceLowToHigh,
  priceHighToLow,
  nameAtoZ,
  nameZtoA,
  defaultSort;

  @override
  String toString() {
    switch (this) {
      case ProductSortEnums.priceLowToHigh:
        return 'Price Low-High';
      case ProductSortEnums.priceHighToLow:
        return 'Price High-Low';
      case ProductSortEnums.nameAtoZ:
        return 'Name A-Z';
      case ProductSortEnums.nameZtoA:
        return 'Name Z-A';
      case ProductSortEnums.defaultSort:
        return 'Default';
    }
  }
}
