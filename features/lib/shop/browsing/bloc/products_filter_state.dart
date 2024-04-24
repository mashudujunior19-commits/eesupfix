part of 'products_filter_bloc.dart';

@immutable
sealed class ProductsFilterState {}

final class CurrentProductsFilters extends ProductsFilterState {
  final ProductFilter filter;
  CurrentProductsFilters(this.filter);
}
