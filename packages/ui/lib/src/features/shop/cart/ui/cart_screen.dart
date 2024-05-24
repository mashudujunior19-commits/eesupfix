import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/features/shop/cart/bloc/cart_bloc.dart';
import 'package:ui/src/features/shop/cart/ui/cart_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cart = (state as CurrentCart);
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              automaticallyImplyLeading: false,
              title: const Text(' Cart'),
              actions: [
                if (cart.products.isNotEmpty)
                  InkWell(
                    onTap: () {
                      context.read<CartBloc>().add(CartCleared());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 5.5, right: 30),
                      child: Icon(IconlyLight.delete, size: 22),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    context.router.push(const BasketsListRoute());
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 9, right: 20),
                    child: Icon(
                      BootstrapIcons.basket,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: context.bgImage,
              child: () {
                if (cart.products.isEmpty) {
                  return const _EmptyCartWidget();
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 300),
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      return CartProductCard(product: cart.products[index])
                          .animate()
                          .slideIn(index * 50);
                    },
                  );
                }
              }(),
            ),
            bottomNavigationBar: cart.products.isNotEmpty
                ? _CheckoutTotal(
                    products: cart.products,
                    total: cart.totalAmount(),
                  )
                : null,
          );
        },
      ),
    );
  }
}

class _CheckoutTotal extends StatelessWidget {
  const _CheckoutTotal({required this.total, required this.products});
  final double total;
  final List<OrderProduct> products;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.sizeOf(context).width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' Total',
                style: context.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'R${total.toStringAsFixed(2)} ',
                style: context.textTheme.displayMedium?.copyWith(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              if (total < 200) {
                context.snackBarError(
                  'A minimum of R200 is required for food items. ',
                );
                return;
              }

              context.router
                  .push(CheckoutRoute(products: products, total: total))
                  .then(
                (placed) {
                  if (placed == true) {
                    context.read<CartBloc>().add(CartCleared());
                  }
                },
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconlyBroken.arrowRight, size: 20),
                SizedBox(width: 5),
                Text('Checkout'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCartWidget extends StatelessWidget {
  const _EmptyCartWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        200.sH,
        Image.asset('assets/images/empty_cart.png'),
        20.sH,
        Padding(
          padding: const EdgeInsets.only(left: 60, right: 60),
          child: Text(
            'Your cart is empty, Start shopping now!',
            style: context.textTheme.displaySmall?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).animate().shimmer(
          delay: 200.ms,
          duration: 1000.ms,
        );
  }
}
