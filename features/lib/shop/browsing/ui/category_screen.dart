import 'package:auto_route/auto_route.dart';
import 'package:data_sources/auth/models/user_role.dart';
import 'package:data_sources/shopping/models/category.dart';
import 'package:data_sources/shopping/models/product.dart';
import 'package:data_sources/shopping/models/product_filter.dart';
import 'package:either_dart/either.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/widgets/fullscreen_error_widget.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/shop/browsing/bloc/category_bloc.dart';
import 'package:features/shop/browsing/bloc/products_filter_bloc.dart';
import 'package:features/shop/browsing/ui/filter_button.dart';
import 'package:features/shop/browsing/ui/products_grid.dart';
import 'package:features/shop/cart/ui/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/shop/shopping_repository.dart';
import 'package:repository/utils/eesup_exception.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

@RoutePage()
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(context.read<ShoppingRepository>())
        ..add(CategoryProductAndDescendentsFetched(category.id)),
      child: SafeArea(
        child: BlocBuilder<ProductsFilterBloc, ProductsFilterState>(
          builder: (context, state) {
            final filter = (state as CurrentProductsFilters).filter;
            return Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: Text(category.name),
                actions: [
                  ShoppingFiltersButton(filter: filter),
                  const CartButton(),
                  5.sW,
                ],
              ),
              body: Container(
                decoration: context.bgImage,
                height: context.height,
                width: context.width,
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryInitial) {
                      return const FullScreenLoadingShimmer();
                    } else if (state is CategoryLoaded) {
                      return DefaultTabController(
                        length: state.descendents.length + 1,
                        child: Column(
                          children: [
                            _CategoriesTabBar(
                              category: category,
                              descendents: state.descendents,
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                ProductsGridView(
                                  filter: filter,
                                  products: state.products,
                                ),

                                ///only show tabs that have products
                                ...state.descendents.map(
                                  (e) => _CategoryProductsFutureBuilder(
                                    id: e.id,
                                    filter: filter,
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      );
                    } else {
                      return FullScreenError(
                        exception: EESUpException(
                          message: 'Failed to load products and categories',
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryProductsFutureBuilder extends StatelessWidget {
  const _CategoryProductsFutureBuilder({
    required this.id,
    required this.filter,
  });
  final int id;
  final ProductFilter filter;

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ShoppingRepository>();
    return FutureBuilder<Either<EESUpException, List<Product>>>(
      future: repo.fetchCategoryProducts(id, UserRole.Ubuntunist, filter.limit),
      builder: (context, snap) {
        if (snap.hasData && snap.data != null) {
          final data = snap.data!;
          return data.fold((left) {
            return FullScreenError(exception: left);
          }, (right) {
            return ProductsGridView(filter: filter, products: right);
          });
        } else if (snap.connectionState == ConnectionState.waiting) {
          return const FullScreenLoadingShimmer();
        } else {
          return FullScreenError(
            exception: EESUpException(
              message: 'Something went wrong while'
                  ' trying to load the products',
            ),
          );
        }
      },
    );
  }
}

class _CategoriesTabBar extends StatelessWidget {
  const _CategoriesTabBar({
    required this.category,
    required this.descendents,
  });
  final Category category;
  final List<Category> descendents;

  @override
  Widget build(BuildContext context) {
    if (descendents.isEmpty) return 0.sW;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 26,
      padding: const EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.all(0),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: Colors.white,
        labelStyle: context.textTheme.displayMedium!.copyWith(
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
        tabs: [
          ///show all products in this category including sub categories
          Tab(text: category.name),

          ///only show tabs that have products
          ...descendents.map(
            (e) => Tab(
              text: e.name,
            ),
          ),
        ],
      ),
    );
  }
}
