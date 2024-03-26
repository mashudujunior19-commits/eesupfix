import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/orders/models/order_product.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/shop/cart/ui/cart_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final products = <OrderProduct>[];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          automaticallyImplyLeading: false,
          title: const Text(' Cart'),
          actions: [
            if (products.isNotEmpty)
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 5.5, right: 25),
                  child: Icon(IconlyLight.delete, size: 22),
                ),
              ),
            InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(bottom: 9, right: 15),
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
          child: Builder(builder: (context) {
            if (products.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  140.sH,
                  Image.asset(
                    'assets/images/empty_cart.png',
                    width: 300,
                  ),
                  20.sH,
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
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
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 200),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return CartProductCard(product: products[index])
                    .animate()
                    .slideIn(index * 50);
              },
            );
          }),
        ),
        bottomNavigationBar: products.isEmpty
            ? null
            : Container(
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
                          'R${0.toStringAsFixed(2)} ',
                          style: context.textTheme.displayMedium?.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        // final foodTotal = totalByClass(ref, ProductClass.food);
                        // final isVouchersOnly = hasVouchersOnlyReaderCart(ref);

                        // if (isVouchersOnly) {
                        //   _checkout(ref, products, context);
                        //   return;
                        // }

                        // if (foodTotal >= 200) {
                        //   _checkout(ref, products, context);
                        //   return;
                        // } else {
                        //   context.snackBarError(
                        //     'A minimum of R200 is required for food items. ',
                        //   );
                        //   return;
                        // }
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
              ),
      ),
    );
  }
}
