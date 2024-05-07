import 'package:auto_route/auto_route.dart';
import 'package:data_sources/shopping/models/basket.dart';
import 'package:data_sources/shopping/models/basket_product.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:features/core/widgets/fullscreen_error_widget.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/shop/baskets/bloc/basket_view_bloc.dart';
import 'package:features/shop/baskets/ui/add_products_dialog.dart';
import 'package:features/shop/cart/ui/product_substitution_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:repository/shop/shopping_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

@RoutePage()
class BasketView extends StatelessWidget {
  const BasketView({super.key, required this.basket});
  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BasketViewBloc(context.read<ShoppingRepository>())
        ..add(BasketViewFetched(basket)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Transform.scale(
              scale: .98,
              child: EESUpTextFormField(
                margin: const EdgeInsets.only(bottom: 5, top: 15),
                prefixIcon: const BackButton(),
                initialValue: basket.name,
                readOnly: basket.type != null,
                onChanged: (p0) {},
              ),
            ),
          ),
          body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: context.bgImage,
            child: BlocBuilder<BasketViewBloc, BasketViewState>(
              builder: (context, state) {
                if (state is BasketViewCurrentState) {
                  final products = state.products;
                  return Column(
                    children: [
                      //      Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     if (basket.type != null)
                      //       DropdownButton<BasketType?>(
                      //         padding: const EdgeInsets.only(bottom: 1),
                      //         // Initial Value
                      //         value: basketType,

                      //         // Down Arrow Icon
                      //         icon: const Padding(
                      //           padding: EdgeInsets.only(left: 5),
                      //           child: Icon(
                      //             IconlyLight.arrowDown2,
                      //             size: 18,
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //         style: context.textTheme.bodySmall?.copyWith(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w600,
                      //           decoration: TextDecoration.none,
                      //         ),
                      //         underline: const SizedBox.shrink(),
                      //         // Array list of items
                      //         items: BasketType.values.map((BasketType? value) {
                      //           return DropdownMenuItem(
                      //             value: value,
                      //             child: Text(value?.name ?? ''),
                      //           );
                      //         }).toList(),
                      //         // After selecting the desired option,it will
                      //         // change button value to selected value
                      //         onChanged: (BasketType? newValue) {
                      //           // ref.read(shoppingRepoProvider).updateBasket(
                      //           //       basket.copyWith(
                      //           //         type: newValue,
                      //           //       ),
                      //           //     );
                      //           // setState(() {
                      //           //   basketType = newValue;
                      //           // });
                      //         },
                      //       ),
                      //     10.sW,
                      //   ],
                      // ),

                      _basketOptionButtons(context),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 300),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final basketProduct = products[index];
                            return _BasketProductCard(
                              basketProduct: basketProduct,
                            ).animate().slideIn(index * 50);
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is BasketViewLoading) {
                  return const FullScreenLoadingShimmer();
                } else if (state is BasketViewError) {
                  return FullScreenError(exception: state.error);
                } else {
                  return FullScreenError(
                    exception: EESUpException(
                      message: 'Something went wrong'
                          ' while fetching your basket products',
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Container _basketOptionButtons(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              addBasketProductsDialog(context, basket.id).whenComplete(() {
                //ref.invalidate(_basketProductsProvider);
              });
            },
            child: const Text('Add Items'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              // final sellableProducts =
              //     basketProducts.where((element) => element.sellable).toList();
              // for (final p in sellableProducts) {
              //   addToCart(
              //     ref,
              //     OrderProduct(
              //       productId: p.productId,
              //       quantity: p.quantity,
              //       productClass: p.productClass,
              //       price: p.price,
              //       name: p.name,
              //       imageUrl: p.imageUrl,
              //       category: p.category,
              //     ),
              //   );
              // }
              // showSnackBar(
              //   context: context,
              //   message: "All available items added to cart",
              // );
            },
            child: Tooltip(
              message: 'Copy this Basket to Cart',
              child: const Text('Copy to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BasketProductCard extends StatelessWidget {
  const _BasketProductCard({required this.basketProduct});
  final BasketProduct basketProduct;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      background: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              'Swipe Left to remove',
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.redAccent,
              ),
            ),
          ).animate().shimmer(duration: 1000.ms),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 5),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: basketProduct.imageUrl != null
                    ? Image.network(basketProduct.imageUrl!, width: 27)
                    : Image.asset('assets/images/no-photo.png',
                        width: 27, color: Colors.grey),
              ),
              title: Text(
                basketProduct.name,
                style: theme.textTheme.labelMedium?.copyWith(fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    basketProduct.category,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  if (basketProduct.size != null)
                    Text(
                      '${basketProduct.size}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 11.5,
                      ),
                    ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<BasketViewBloc>().add(
                                BasketProductChanged(
                                  basketProduct.copyWith(
                                    quantity: basketProduct.quantity - 1,
                                  ),
                                ),
                              );
                        },
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/mark.png',
                            width: 22,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        margin: const EdgeInsets.only(top: 2),
                        child: TextFormField(
                          initialValue: basketProduct.quantity.toString(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: context.textTheme.labelMedium,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: (value) {
                            final qty = int.tryParse(value);
                            if (qty != null) {
                              context.read<BasketViewBloc>().add(
                                    BasketProductChanged(
                                      basketProduct.copyWith(quantity: qty),
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<BasketViewBloc>().add(
                                BasketProductChanged(
                                  basketProduct.copyWith(
                                    quantity: basketProduct.quantity + 1,
                                  ),
                                ),
                              );
                        },
                        icon: const Icon(IconlyLight.plus),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ProductSubstitutionSettings(
              substituteBrands: basketProduct.substituteBrand,
              substituteVariants: basketProduct.substituteVariant,
              onSaved: (brand, varaint) {
                context.read<BasketViewBloc>().add(
                      BasketProductChanged(
                        basketProduct.copyWith(
                          substituteVariant: varaint,
                          substituteBrand: brand,
                        ),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
