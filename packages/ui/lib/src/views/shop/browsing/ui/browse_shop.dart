import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/shopping/models/product_filter.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/shop/browsing/bloc/browsing_bloc.dart';
import 'package:ui/src/views/shop/browsing/bloc/categories_bloc.dart';
import 'package:ui/src/views/shop/browsing/bloc/products_filter_bloc.dart';
import 'package:ui/src/views/shop/browsing/ui/categories_list.dart';
import 'package:ui/src/views/shop/browsing/ui/filter_dialog.dart';
import 'package:ui/src/views/shop/browsing/ui/products_grid.dart';
import 'package:ui/src/views/shop/cart/ui/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

@RoutePage()
class BrowseShopScreen extends StatelessWidget {
  const BrowseShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesBloc(
            context.read<ShoppingRepository>(),
          )..add(CategoriesFetched()),
        ),
        BlocProvider(
          create: (context) => BrowsingBloc(
            context.read<ShoppingRepository>(),
          ),
        ),
      ],
      child: BlocBuilder<BrowsingBloc, BrowsingState>(
        builder: (context, searchState) {
          return BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, categoriesState) {
              return BlocBuilder<ProductsFilterBloc, ProductsFilterState>(
                builder: (context, filterState) {
                  final filter = (filterState as CurrentProductsFilters).filter;
                  return SafeArea(
                    child: Scaffold(
                      body: Container(
                        decoration: context.bgImage,
                        height: context.height,
                        width: context.width,
                        child: Column(
                          children: [
                            _SearchBox(filter),
                            () {
                              //IF THERE ARE SEARCHING EVENTS SHOW THE RESULTS
                              //IN A TAB VIEW
                              if (searchState is BrowsingSearchResults) {
                                final results = searchState.results;
                                return DefaultTabController(
                                  length: 2,
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const _SearchTabBar(),
                                        Expanded(
                                          child: TabBarView(
                                            children: [
                                              ProductsGridView(
                                                products: results['products'],
                                                filter: const ProductFilter(
                                                  sort: ProductSortEnums
                                                      .defaultSort,
                                                  limit: 10,
                                                ),
                                              ),
                                              CategoriesList(
                                                categories:
                                                    results['categories'],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                //OTHERWISE SHOW THE LOADED CATEGORIES
                                return () {
                                  if (categoriesState is CategoriesInitial) {
                                    return const FullScreenLoadingShimmer();
                                  } else if (categoriesState
                                      is CategoriesLoaded) {
                                    return Expanded(
                                      child: CategoriesList(
                                          categories:
                                              categoriesState.categories),
                                    );
                                  } else if (categoriesState
                                      is CategoriesLoadingError) {
                                    return FullScreenError(
                                        exception: categoriesState.exception);
                                  } else {
                                    return FullScreenError(
                                      exception: EESUpException(
                                        message: 'Something went wrong while'
                                            ' fetching categories.',
                                      ),
                                    );
                                  }
                                }();
                              }
                            }()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _SearchTabBar extends StatelessWidget {
  const _SearchTabBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 26,
      padding: const EdgeInsets.only(left: 16, right: 16),
      color: Colors.white,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.all(0),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: Colors.white,
        labelStyle: context.textTheme.displayMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: RectangularIndicator(
          bottomLeftRadius: 8,
          bottomRightRadius: 8,
          topLeftRadius: 8,
          topRightRadius: 8,
          color: context.colorScheme.primary,
        ),
        tabs: const [Tab(text: 'Products'), Tab(text: 'Categories')],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  _SearchBox(this.filter);
  final ProductFilter filter;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      color: Colors.white,
      child: EESUpTextFormField(
        margin: const EdgeInsets.all(0),
        hintText: 'Looking for something?',
        prefixIcon: const BackButton(),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_textController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 2),
                child: InkWell(
                  onTap: () {
                    _textController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  child: const Icon(
                    BootstrapIcons.x,
                    color: Colors.redAccent,
                    size: 32,
                  ),
                ),
              ),
            ShoppingFiltersButton(filter: filter),
            // const ScanQrCodeButton(),
            const CartButton(),
          ],
        ),
        onChanged: (value) {
          if (value.length < 3) return;
          context.read<BrowsingBloc>().add(ProductsSearched(value, 15));
        },
      ),
    );
  }
}
