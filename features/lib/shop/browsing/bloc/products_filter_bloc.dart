import 'package:bloc/bloc.dart';
import 'package:data_sources/shopping/models/product_filter.dart';
import 'package:meta/meta.dart';

part 'products_filter_event.dart';
part 'products_filter_state.dart';

class ProductsFilterBloc
    extends Bloc<ProductsFilterEvent, ProductsFilterState> {
  ProductsFilterBloc()
      : super(
          CurrentProductsFilters(
            const ProductFilter(
              limit: 500,
              sort: ProductSortEnums.defaultSort,
            ),
          ),
        ) {
    on<ProductsFiltersSortingChanged>((event, emit) {
      final filter = (state as CurrentProductsFilters).filter;
      emit(CurrentProductsFilters(filter.copyWith(sort: event.newSort)));
    });

    on<ProductsFiltersLimitChanged>((event, emit) {
      final filter = (state as CurrentProductsFilters).filter;
      emit(CurrentProductsFilters(filter.copyWith(limit: event.limit)));
    });

    on<ProductsFiltersChanged>((event, emit) {
      emit(CurrentProductsFilters(event.filter));
    });
  }
}
