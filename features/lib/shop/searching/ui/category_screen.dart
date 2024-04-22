import 'package:auto_route/auto_route.dart';
import 'package:data_sources/shopping/models/category.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinit_scrolling/flutter_infinit_scrolling.dart';
import 'package:flutter_infinit_scrolling/infinity_scroll_controller.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

@RoutePage()
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       leading: const BackButton(),
    //       title: Text(category.name),
    //       actions: const [
    //         // ShoppingFiltersButton(),
    //         // CartButton(margin: EdgeInsets.only(right: 15)),
    //       ],
    //     ),
    //     body: Container(
    //       decoration: context.bgImage,
    //       height: context.height,
    //       width: context.width,
    //       child: Column(
    //         children: [
    //           //   _CategoriesTabBar(category: category),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: InfinitListView(
          infinitController: InfinityScrollController(
            List.generate(
              50,
              (index) => Container(
                key: Key(index.toString()),
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.red,
              ),
            ).toList(),
            loadMoreNotifier: () {},
          ),
        ),
      ),
    );
  }
}

class _CategoriesTabBar extends StatelessWidget {
  const _CategoriesTabBar({required this.category, required this.categories});
  final Category category;
  final List<Category> categories;

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

          // ///only show tabs that have products
          // ...categories
          //     .where(
          //         (e) => prodCats.allProducts.any((p) => p.categoryId == e.id))
          //     .map(
          //       (e) => Tab(
          //         text: e.name,
          //       ),
          //     )
          //     .toList(),
        ],
      ),
    );
  }
}
