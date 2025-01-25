import 'package:data/orders/models/order.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/views/shop/cart/bloc/cart_bloc.dart';

class OrdProducts extends StatelessWidget {
  const OrdProducts({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blueGrey.shade100,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items', style: textTheme.labelMedium),
              IconButton(
                onPressed: () {
                  final cartBloc = context.read<CartBloc>();
                  final cartState = cartBloc.state;

                  if (cartState is CurrentCart &&
                      cartState.products.isNotEmpty) {
                    _showCartConfirmationDialog(context, cartBloc);
                  } else {
                    _addProductsToCart(context, cartBloc);
                  }
                },
                icon: Icon(
                  IconlyLight.buy,
                  size: 25,
                ),
              ),
            ],
          ),
          10.sH,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                order.products.length,
                (index) => Tooltip(
                  message: order.products[index].name,
                  child: Container(
                    width: 70,
                    height: 70,
                    margin: const EdgeInsets.only(right: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blueGrey.shade100,
                        width: 0.5,
                      ),
                    ),
                    child: Badge(
                      backgroundColor: colorScheme.primary,
                      label: Text(
                        '${order.products[index].quantity}',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.surface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: SizedBox(
                        child: order.products[index].imageUrl != null
                            ? Image.network(
                                order.products[index].imageUrl!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset('assets/images/no-photo.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCartConfirmationDialog(BuildContext context, CartBloc cartBloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cart contains products'),
          content: const Text(
            'Would you like to add these new products to the existing cart or clear the cart and create a new one?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addProductsToCart(context, cartBloc);
              },
              child: const Text('Add to Existing Cart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                cartBloc.add(CartCleared());
                _addProductsToCart(context, cartBloc);
              },
              child: const Text('Clear and Create New Cart'),
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Text('Cancel'),
            // ),
          ],
        );
      },
    );
  }

  void _addProductsToCart(BuildContext context, CartBloc cartBloc) {
    for (var product in order.products) {
      cartBloc.add(
        ProductAddedToCart(
          OrderProduct(
            productId: product.productId,
            quantity: product.quantity,
            price: product.price,
            name: product.name,
            imageUrl: product.imageUrl,
          ),
        ),
      );
    }

    // Show confirmation snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${order.products.length} products added to the cart!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
