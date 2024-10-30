// import 'package:auto_route/auto_route.dart';
// import 'package:data/shopping/models/product.dart';
// import 'package:data/shopping/repository/shopping_repository.dart';
// import 'package:data/utils/eesup_exception.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:data/shopping/models/hamper.dart';
// import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
// import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
// import '../bloc/hamper_bloc.dart';
// import 'package:data/shopping/models/mapped_product_hamper.dart';

// @RoutePage()
// class HamperViewPage extends StatelessWidget {
//   final String hamperId;

//   const HamperViewPage({super.key, required this.hamperId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HamperBloc(context.read<ShoppingRepository>())
//         ..add(FetchHampers())
//         ..add(FetchHamperProducts(hamperId)),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Hamper Details"),
//         ),
//         body: BlocBuilder<HamperBloc, HamperState>(
//           builder: (context, state) {
//             if (state is HamperLoading) {
//               return const FullScreenLoadingShimmer();
//             } else if (state is HamperError) {
//               return FullScreenError(
//                 exception: EESUpException(
//                   message: 'Something went wrong: ${state.message}',
//                 ),
//               );
//             } else if (state is HamperLoaded) {
//               final hamper = state.hampers.firstWhere((h) => h.id == hamperId);
//               return _buildHamperDetails(context, hamper);
//               // } else if (state is HamperProductLoaded) {
//               //   final products = state.hamperProductDetails;
//               //   return _buildProductList(context, products);
//             } else {
//               return const SizedBox.shrink();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildHamperDetails(BuildContext context, Hamper hamper) {
//     final state = context.watch<HamperBloc>().state;
//     // Initialize an empty list for products
//     List<HamperProductDetail> products = [];

//     // Check if the state is HamperProductLoaded
//     if (state is HamperProductLoaded) {
//       products = state.hamperProductDetails;
//       print('HamperProductLoaded: Raw Products count: ${products.length}');
//       for (var product in products) {
//         print('Product: ${product.name}, Free: ${product.isFree}');
//       }
//     }
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('${hamper.hamperName} (${hamper.hamperCode})',
//                     style: Theme.of(context).textTheme.headlineMedium),
//                 Text("Type: ${hamper.type}"),
//                 Text("Cost: ${hamper.value}"),
//                 Text(
//                     "Expires on: ${hamper.expiryDate.toLocal().toString().split(' ')[0]}"),
//                 if (hamper.imgUrl != null)
//                   Image.network(hamper.imgUrl!,
//                       height: 150, width: double.infinity, fit: BoxFit.cover),
//               ],
//             ),
//           ),
//           const Divider(),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text("Products",
//                 style: Theme.of(context).textTheme.headlineMedium),
//           ),
//           if (products.isNotEmpty)
//             _buildProductList(context, products)
//           else
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text("No products available for this hamper."),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductList(
//       BuildContext context, List<HamperProductDetail> products) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final productDetail = products[index];
//         return _ProductItemCard(productDetail: productDetail);
//       },
//     );
//   }
// }

// class _ProductItemCard extends StatelessWidget {
//   final HamperProductDetail productDetail;

//   const _ProductItemCard({required this.productDetail});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             // CircleAvatar(
//             //   backgroundImage: NetworkImage(productDetail.imageUrl.isNotEmpty
//             //       ? productDetail.imageUrl
//             //       : 'assets/images/no-photo.png'),
//             //   radius: 30,
//             // ),
//             CircleAvatar(
//               radius: 30,
//               backgroundImage: productDetail.imageUrl.isNotEmpty
//                   ? NetworkImage(productDetail.imageUrl)
//                   : null,
//               child: productDetail.imageUrl.isNotEmpty
//                   ? null
//                   : const Icon(
//                       Icons.fastfood_outlined,
//                       size: 30,
//                       color: Colors.grey,
//                     ),
//             ),

//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(productDetail.name,
//                       style: Theme.of(context).textTheme.bodyMedium),
//                   Text("Price: R${productDetail.salePrice.toStringAsFixed(2)}"),
//                   Text(
//                     productDetail.isFree ? "Free" : "Paid",
//                     style: TextStyle(
//                       color: productDetail.isFree ? Colors.green : Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:auto_route/auto_route.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/mapped_product_hamper.dart';
import 'package:data/shopping/repository/basket_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/shopping/models/hamper.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../bloc/hamper_bloc.dart';

@RoutePage()
class HamperViewPage extends StatefulWidget {
  final String hamperId;

  const HamperViewPage({super.key, required this.hamperId});

  @override
  _HamperViewPageState createState() => _HamperViewPageState();
}

class _HamperViewPageState extends State<HamperViewPage> {
  Hamper? selectedHamper;
  List<HamperProductDetail> products = [];

  @override
  void initState() {
    super.initState();
    final hamperBloc = context.read<HamperBloc>();
    hamperBloc.add(FetchHampers());
    hamperBloc.add(FetchHamperProducts(widget.hamperId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hamper Details"),
      ),
      body: BlocListener<HamperBloc, HamperState>(
        listener: (context, state) {
          if (state is HamperLoaded) {
            selectedHamper =
                state.hampers.firstWhere((h) => h.id == widget.hamperId);
          } else if (state is HamperProductLoaded) {
            products = state.hamperProductDetails;
          } else if (state is HamperError) {
            // Handle error state here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error loading hamper: ${state.message}')),
            );
          }
          // Trigger UI update once both hamper and products are loaded
          if (selectedHamper != null && products.isNotEmpty) {
            setState(() {});
          }
        },
        child: BlocBuilder<HamperBloc, HamperState>(
          builder: (context, state) {
            if (state is HamperLoading) {
              return const FullScreenLoadingShimmer();
            } else if (state is HamperError) {
              return FullScreenError(
                exception: EESUpException(
                  message: 'Something went wrong: ${state.message}',
                ),
              );
            } else if (selectedHamper != null && products.isNotEmpty) {
              return _buildHamperDetails(context, selectedHamper!, products);
            }
            return const FullScreenLoadingShimmer();
          },
        ),
      ),
    );
  }

  Widget _buildHamperDetails(
      BuildContext context, Hamper hamper, List<HamperProductDetail> products) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_basket),
                onPressed: () {
                  // final repo = context.read<ShoppingRepository>();

                  // for (final product in products) {
                  //   repo.addProductToBasket(basketId, product.productId);
                  // }
                  // context.snackBarSuccess('All items added to basket.');
                },
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  for (final p in products) {
                    context.read<CartBloc>().add(
                          ProductAddedToCart(
                            OrderProduct(
                              productId: p.productId,
                              quantity: p.quantity,
                              //productClass: p.productClass,
                              price: p.salePrice,
                              name: p.name,
                              imageUrl: p.imageUrl,
                              //category: p.category,
                            ),
                          ),
                        );
                  }
                  context.snackBarSuccess('All items added to cart');
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${hamper.hamperName} (${hamper.hamperCode})',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text("Type: ${hamper.type}"),
                Text("Cost: ${hamper.value}"),
                Text(
                    "Expires on: ${hamper.expiryDate.toLocal().toString().split(' ')[0]}"),
                if (hamper.imgUrl != null && hamper.imgUrl!.isNotEmpty)
                  Image.network(
                    hamper.imgUrl!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Products",
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          _buildProductList(context, products),
        ],
      ),
    );
  }

  Widget _buildProductList(
      BuildContext context, List<HamperProductDetail> products) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductItemCard(productDetail: product);
      },
    );
  }
}

class _ProductItemCard extends StatelessWidget {
  final HamperProductDetail productDetail;

  const _ProductItemCard({required this.productDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: productDetail.imageUrl.isNotEmpty
                  ? NetworkImage(productDetail.imageUrl)
                  : null,
              child: productDetail.imageUrl.isNotEmpty
                  ? null
                  : const Icon(
                      Icons.fastfood_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productDetail.name,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text("Price: R${productDetail.salePrice.toStringAsFixed(2)}"),
                  Text(
                    productDetail.isFree ? "Free" : "Paid",
                    style: TextStyle(
                      color: productDetail.isFree ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
