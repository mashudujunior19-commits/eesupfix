import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/product.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/views/shop/cart/bloc/cart_bloc.dart';
import 'package:ui/src/views/shop/cart/ui/cart_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../hampers/bloc/hamper_bloc.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  Product? hamperOrderProduct;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CurrentCart) {
            return _buildCartUI(context, state.products);
          } else if (state is HamperComparisonLoading) {
            // Show a loading indicator during hamper comparison
            return const Center(child: CircularProgressIndicator());
          } else if (state is HamperComparisonError) {
            // Show an error message
            return Center(
              child: Text("Error: ${state.message}"),
            );
          } else {
            // Default state or unhandled states
            return const Center(
              child: Text("Something went wrong."),
            );
          }
        },
      ),
    );
  }

  Widget _buildCartUI(BuildContext context, List<OrderProduct> products) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Cart'),
        actions: [
          if (products.isNotEmpty)
            IconButton(
              icon: const Icon(IconlyLight.delete),
              onPressed: () {
                context.read<CartBloc>().add(CartCleared());
              },
            ),
          IconButton(
            icon: const Icon(BootstrapIcons.basket),
            onPressed: () {
              context.router.push(const BasketsListRoute());
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: context.bgImage,
        child: products.isEmpty
            ? const _EmptyCartWidget()
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 300),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return CartProductCard(product: products[index])
                      .animate()
                      .slideIn(index * 50);
                },
              ),
      ),
      // bottomNavigationBar: products.isNotEmpty
      //     ? _CheckoutTotal(
      //         products: products,
      //         total: products.fold(0, (sum, product) => sum + product.price),
      //       )
      //     : null,

      bottomNavigationBar: products.isNotEmpty
          ? _CheckoutTotal(
              products: products,
              total: products.fold(0.0,
                  (sum, product) => sum + (product.price * product.quantity)),
            )
          : null,
    );
  }

  void _showHamperDialog(BuildContext context, Product hamperProduct) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Hamper Match Found!',
            style: context.textTheme.bodyMedium,
          ),
          content: Text(
            'Would you like to add the hamper to your cart?',
            style: context.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<CartBloc>().add(
                      ProductAddedToCart(
                        OrderProduct(
                          productId: hamperProduct.id,
                          quantity: 1,
                          price: hamperProduct.salePrice,
                          name: hamperProduct.name,
                          imageUrl: hamperProduct.imageUrl,
                        ),
                      ),
                    );
                Navigator.pop(context);
                context
                    .snackBarSuccess('The hamper has been added to your cart!');
              },
              child: const Text('Add to Cart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
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
                'Total',
                style: context.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'R${total.toStringAsFixed(2)}',
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
                  'A minimum of R200 is required for food items.',
                );
                return;
              }

              context.router
                  .push(CheckoutRoute(products: products, total: total))
                  .then((placed) {
                if (placed == true) {
                  context.read<CartBloc>().add(CartCleared());
                }
              });
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


// ignore_for_file: must_be_immutable

// import 'package:auto_route/auto_route.dart';
// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import 'package:data/orders/models/order_product.dart';
// import 'package:data/shopping/models/product.dart';
// import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
// import 'package:ui/src/core/extensions/context_alerts_ext.dart';
// import 'package:ui/src/core/extensions/context_theme_ext.dart';
// import 'package:ui/src/core/extensions/sizedbox_ext.dart';
// import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
// import 'package:ui/app_route.gr.dart';
// import 'package:ui/src/views/shop/cart/bloc/cart_bloc.dart';
// import 'package:ui/src/views/shop/cart/ui/cart_product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';

// import '../../hampers/bloc/hamper_bloc.dart';

// @RoutePage()
// class CartScreen extends StatelessWidget {
//   CartScreen({super.key});

//   Product? hamperOrderProduct;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
//         final cart = (state as CurrentCart);

//         return BlocListener<CartBloc, CartState>(
//           listener: (context, cartState) {
//             if (cartState is CurrentCart) {
//               print("Cart state updated, starting hamper comparison...");
//               context
//                   .read<HamperBloc>()
//                   .add(CompareCartWithHampers(cartState.products));
//             }
//           },
//           child: BlocListener<HamperBloc, HamperState>(
//             listener: (context, hamperState) {
//               if (hamperState is HamperComparisonResultState) {
//                 hamperOrderProduct = hamperState.hamperProduct;
//                 print("Hamper product: ${hamperState.hamperProduct}");
//                // print("Matching hamper: ${hamperState.matchingHamper}");

//                 hamperOrderProduct = hamperState.hamperProduct;

//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   _showHamperDialog(context, hamperOrderProduct!);
//                 });

//                 context.read<HamperBloc>().add(ResetHamperComparison());
//               }
//               _showHamperDialog(context, hamperOrderProduct!);
//             },
//             child: Scaffold(
//               appBar: AppBar(
//                 leading: const BackButton(),
//                 title: const Text('Cart'),
//                 actions: [
//                   if (cart.products.isNotEmpty)
//                     IconButton(
//                       icon: const Icon(IconlyLight.delete),
//                       onPressed: () {
//                         context.read<CartBloc>().add(CartCleared());
//                       },
//                     ),
//                   IconButton(
//                     icon: const Icon(BootstrapIcons.basket),
//                     onPressed: () {
//                       context.router.push(const BasketsListRoute());
//                     },
//                   ),
//                 ],
//               ),
//               body: Container(
//                 height: MediaQuery.sizeOf(context).height,
//                 width: MediaQuery.sizeOf(context).width,
//                 decoration: context.bgImage,
//                 child: cart.products.isEmpty
//                     ? const _EmptyCartWidget()
//                     : ListView.builder(
//                         padding: const EdgeInsets.only(bottom: 300),
//                         itemCount: cart.products.length,
//                         itemBuilder: (context, index) {
//                           return CartProductCard(product: cart.products[index])
//                               .animate()
//                               .slideIn(index * 50);
//                         },
//                       ),
//               ),
//               bottomNavigationBar: cart.products.isNotEmpty
//                   ? _CheckoutTotal(
//                       products: cart.products,
//                       total: cart.totalAmount(),
//                     )
//                   : null,
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   void _showHamperDialog(BuildContext context, Product? hamperProduct) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(
//             'Hamper Match Found!',
//             style: context.textTheme.bodyMedium,
//           ),
//           content: Text(
//             'Would you like to add the hamper to your cart?',
//             style: context.textTheme.bodyMedium,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 context.read<CartBloc>().add(
//                       ProductAddedToCart(
//                         OrderProduct(
//                           productId: hamperProduct!.id,
//                           quantity: 1,
//                           price: hamperProduct.salePrice,
//                           name: hamperProduct.name,
//                           imageUrl: hamperProduct.imageUrl,
//                         ),
//                       ),
//                     );
//                 context.read<HamperBloc>().add(ResetHamperComparison());
//                 Navigator.pop(context);
//                 context
//                     .snackBarSuccess('The hamper has been added to your cart!');
//               },
//               child: const Text('Add to Cart'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _CheckoutTotal extends StatelessWidget {
//   const _CheckoutTotal({required this.total, required this.products});
//   final double total;
//   final List<OrderProduct> products;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       width: MediaQuery.sizeOf(context).width,
//       color: Colors.white,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Total',
//                 style: context.textTheme.displayMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               Text(
//                 'R${total.toStringAsFixed(2)}',
//                 style: context.textTheme.displayMedium?.copyWith(
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: () {
//               if (total < 200) {
//                 context.snackBarError(
//                   'A minimum of R200 is required for food items.',
//                 );
//                 return;
//               }

//               context.router
//                   .push(CheckoutRoute(products: products, total: total))
//                   .then((placed) {
//                 if (placed == true) {
//                   context.read<CartBloc>().add(CartCleared());
//                 }
//               });
//             },
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(IconlyBroken.arrowRight, size: 20),
//                 SizedBox(width: 5),
//                 Text('Checkout'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _EmptyCartWidget extends StatelessWidget {
//   const _EmptyCartWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         200.sH,
//         Image.asset('assets/images/empty_cart.png'),
//         20.sH,
//         Padding(
//           padding: const EdgeInsets.only(left: 60, right: 60),
//           child: Text(
//             'Your cart is empty, Start shopping now!',
//             style: context.textTheme.displaySmall?.copyWith(
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey.shade500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     ).animate().shimmer(
//           delay: 200.ms,
//           duration: 1000.ms,
//         );
//   }
// }
