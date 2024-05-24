import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/shop/baskets/ui/basket_selection_dialog.dart';
import 'package:ui/src/features/shop/browsing/ui/product_card.dart';
import 'package:ui/src/features/shop/cart/ui/cart_button.dart';
import 'package:readmore/readmore.dart';

@RoutePage()
class ProductViewScreen extends StatelessWidget {
  const ProductViewScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          actions: [const CartButton(), 10.sW],
        ),
        body: FutureBuilder<Either<EESUpException, Product>>(
          future: context.read<ShoppingRepository>().fetchProduct(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data;
              if (result == null) {
                return FullScreenError(
                  exception: EESUpException(
                    message: '',
                  ),
                );
              }
              return result.fold((left) {
                return FullScreenError(exception: left);
              }, (right) {
                final product = right;
                return ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  children: [
                    _ProductInformation(product: product),
                    if (product.categoryId != null)
                      _PeopleLike(
                        categoryId: product.categoryId!,
                      )
                  ],
                );
              });
            } else {
              return const FullScreenLoadingShimmer();
            }
          },
        ),
      ),
    );
  }
}

class _PeopleLike extends StatelessWidget {
  const _PeopleLike({required this.categoryId});
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
          child: const Text('People also liked'),
        ),
        FutureBuilder<Either<EESUpException, List<Product>>>(
          future: context.read<ShoppingRepository>().fetchCategoryProducts(
                categoryId,
                UserRole.Ubuntunist,
                50,
              ),
          builder: (context, snap) {
            if (snap.hasData) {
              final data = snap.data;
              if (data != null) {
                return data.fold((l) {
                  return 0.sW;
                }, (products) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        products.length,
                        (index) => ProductCard(
                          isBundle: true,
                          product: products[index],
                        ),
                      ),
                    ),
                  );
                });
              }
            }
            return 0.sW;
          },
        )
      ],
    );
  }
}

class _ProductInformation extends StatelessWidget {
  const _ProductInformation({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.width,
            margin: const EdgeInsets.only(bottom: 20),
            height: 250,
            child: Center(
              child: product.imageUrl != null
                  ? Image(
                      image: NetworkImage(
                        product.imageUrl!,
                      ),
                    )
                  : Image.asset(
                      'assets/images/no-photo.png',
                      fit: BoxFit.contain,
                      color: Colors.grey.shade200,
                      width: 150,
                    ),
            ),
          ),
          Text(product.name),
          Text(product.categoryName ?? ''),
          5.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('R${product.salePrice.toStringAsFixed(2)}'),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        context.showBottomSheetDialog(
                          child: BasketSelectionDialog(
                            product: product,
                          ),
                        );
                      },
                      child: const Icon(
                        BootstrapIcons.basket,
                        size: 20,
                        color: Colors.black,
                      ),
                    );
                  }),
                  20.sW,
                  //  CartButtons(product: product),
                ],
              ),
            ],
          ),
          15.sH,
          const Text('Description'),
          Divider(color: Colors.blueGrey.shade100, thickness: .4),
          5.sH,
          ReadMoreText(
            product.description ?? '',
            trimLines: 3,
            colorClickableText: context.colorScheme.primary,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            style: context.textTheme.bodySmall?.copyWith(
                // fontSize: 15,
                // fontWeight: FontWeight.w500,
                // color: Colors.grey.shade600,
                ),
            moreStyle: context.textTheme.bodySmall?.copyWith(
                // fontSize: 15,
                // fontWeight: FontWeight.w500,
                // color: Colors.grey.shade600,
                ),
          ),
          Divider(color: Colors.blueGrey.shade100, thickness: .4),
        ],
      ),
    );
  }
}
