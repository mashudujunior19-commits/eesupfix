part of 'products_filter_bloc.dart';

@immutable
sealed class ProductsFilterEvent {}

final class ProductsFiltersSortingChanged extends ProductsFilterEvent {
  final ProductSortEnums newSort;
  ProductsFiltersSortingChanged(this.newSort);
}

final class ProductsFiltersLimitChanged extends ProductsFilterEvent {
  final int limit;
  ProductsFiltersLimitChanged(this.limit);
}

final class ProductsFiltersChanged extends ProductsFilterEvent {
  final ProductFilter filter;
  ProductsFiltersChanged(this.filter);
}
