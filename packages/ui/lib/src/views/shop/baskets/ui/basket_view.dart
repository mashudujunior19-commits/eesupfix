import 'package:auto_route/auto_route.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/models/basket_product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/shop/baskets/bloc/basket_view_bloc.dart';
import 'package:ui/src/views/shop/baskets/cubit/copying_cubit.dart';
import 'package:ui/src/views/shop/baskets/ui/add_products_dialog.dart';
import 'package:ui/src/views/shop/cart/bloc/cart_bloc.dart';
import 'package:ui/src/views/shop/cart/ui/cart_button.dart';
import 'package:ui/src/views/shop/cart/ui/product_substitution_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';

@RoutePage()
class BasketViewScreen extends StatelessWidget {
  const BasketViewScreen({super.key, required this.basket});
  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BasketViewBloc(context.read<ShoppingRepository>())
                ..add(BasketViewFetched(basket)),
        ),
        BlocProvider(create: (context) => CopyingCubit()),
      ],
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: _AddProdactButton(basket: basket),
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(basket.name),
            actions: const [CartButton()],
          ),
          body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: context.bgImage,
            child: BlocBuilder<BasketViewBloc, BasketViewState>(
              builder: (context, state) {
                if (state is BasketViewCurrentState) {
                  final products = state.products;
                  return BlocBuilder<CopyingCubit, List<BasketProduct>>(
                    builder: (context, selectedProdcuts) {
                      return Column(
                        children: [
                          _CopyingButtons(
                            products: products,
                            selectedProdcuts: selectedProdcuts,
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 300),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final basketProduct = products[index];
                                return _BasketProductCard(
                                  isSelected: selectedProdcuts.contains(
                                    basketProduct,
                                  ),
                                  basketProduct: basketProduct,
                                ).animate().slideIn(index * 50);
                              },
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else if (state is BasketViewLoading) {
                  return const FullScreenLoadingShimmer();
                } else if (state is BasketViewError) {
                  return FullScreenError(exception: state.error);
                } else {
                  return FullScreenError(
                    exception: EESUpException(
                      message: 'Something went wrong while '
                          'fetching your basket products',
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
}

class _CopyingButtons extends StatelessWidget {
  const _CopyingButtons({
    required this.selectedProdcuts,
    required this.products,
  });

  final List<BasketProduct> selectedProdcuts;
  final List<BasketProduct> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              for (final p in products) {
                context.read<CartBloc>().add(
                      ProductAddedToCart(
                        OrderProduct(
                          productId: p.productId,
                          quantity: p.quantity,
                          productClass: p.productClass,
                          price: p.price,
                          name: p.name,
                          imageUrl: p.imageUrl,
                          category: p.category,
                        ),
                      ),
                    );
              }
              context.snackBarSuccess('Items copied');
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(width: .5),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Text('Copy all to Cart'),
            ),
          ),
          15.sW,
          if (selectedProdcuts.isNotEmpty)
            GestureDetector(
              onTap: () {
                for (final p in selectedProdcuts) {
                  context.read<CartBloc>().add(
                        ProductAddedToCart(
                          OrderProduct(
                            productId: p.productId,
                            quantity: p.quantity,
                            productClass: p.productClass,
                            price: p.price,
                            name: p.name,
                            imageUrl: p.imageUrl,
                            category: p.category,
                          ),
                        ),
                      );
                }
                context.snackBarSuccess('Items copied');
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(width: .5),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  'Copy Selected to Cart',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddProdactButton extends StatelessWidget {
  const _AddProdactButton({required this.basket});
  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return FloatingActionButton(
        onPressed: () {
          context
              .showBottomSheetDialog(
                  child: AddBasketProductsDialog(basketId: basket.id))
              .whenComplete(() {
            context.read<BasketViewBloc>().add(BasketViewFetched(basket));
          });
        },
        backgroundColor: context.colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      );
    });
  }
}

class _BasketProductCard extends StatelessWidget {
  const _BasketProductCard({
    required this.basketProduct,
    required this.isSelected,
  });
  final bool isSelected;
  final BasketProduct basketProduct;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<BasketViewBloc>().add(
              BasketProductRemoved(basketProduct),
            );
      },
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
      child: Row(
        children: [
          5.sW,
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              final isSelected = value ?? false;
              if (isSelected) {
                context.read<CopyingCubit>().select(basketProduct);
              } else {
                context.read<CopyingCubit>().deselect(basketProduct);
              }
            },
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 20, top: 15),
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
                      style:
                          theme.textTheme.labelMedium?.copyWith(fontSize: 13),
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
                                            basketProduct.copyWith(
                                                quantity: qty),
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
          ),
        ],
      ),
    );
  }
}
