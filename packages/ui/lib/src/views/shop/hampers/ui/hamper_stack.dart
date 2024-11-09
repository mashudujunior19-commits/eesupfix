import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';

import '../../cart/bloc/cart_bloc.dart';
import '../bloc/hamper_bloc.dart';

// @RoutePage()
// class HamperImageStack extends StatefulWidget {
//   final String? imgUrl;
//   final String? hamperGifUrl1;
//   final String? hamperGifUrl2;

//   const HamperImageStack({
//     super.key,
//     required this.imgUrl,
//     this.hamperGifUrl1,
//     this.hamperGifUrl2,
//   });

//   @override
//   State<HamperImageStack> createState() => _HamperImageStackState();
// }

// class _HamperImageStackState extends State<HamperImageStack> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<HamperBloc, HamperState>(
//       listener: (context, state) {
//         if (state is HamperProductLoaded) {
//           IconButton(
//             icon: const Icon(Icons.shopping_cart),
//             onPressed: () {
//               for (final p in state.hamperProductDetails) {
//                 context.read<CartBloc>().add(
//                       ProductAddedToCart(
//                         OrderProduct(
//                           productId: p.productId,
//                           quantity: p.quantity,
//                           productClass: p.product.productClass,
//                           price: p.salePrice,
//                           name: p.name,
//                           imageUrl: p.imageUrl,
//                           category: p.product.categoryName,
//                         ),
//                       ),
//                     );
//               }
//               context.snackBarSuccess('Hamper added to cart');
//             },
//           );
//         } else if (state is HamperError) {
//           // Show an error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           if (widget.imgUrl != null && widget.imgUrl!.isNotEmpty)
//             Container(
//               height: 270,
//               width: 700,
//               child: Image.network(
//                 widget.imgUrl!,
//                 fit: BoxFit.fill,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(color: Colors.grey);
//                 },
//               ),
//             )
//           else
//             Container(color: Colors.grey),
//           if (widget.hamperGifUrl1 != null && widget.hamperGifUrl1!.isNotEmpty)
//             Positioned(
//               top: 14,
//               left: 10,
//               child: Image.network(
//                 widget.hamperGifUrl1!,
//                 height: 20,
//                 width: 80,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container();
//                 },
//               ),
//             ),
//           if (widget.hamperGifUrl2 != null && widget.hamperGifUrl2!.isNotEmpty)
//             Positioned(
//               bottom: 10,
//               right: 145,
//               child: Image.network(
//                 widget.hamperGifUrl2!,
//                 height: 88,
//                 width: 80,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container();
//                 },
//               ),
//             ),
//           Positioned(
//             top: 10,
//             right: 10,
//             child: GestureDetector(
//               onTap: () {
//                 context
//                     .read<HamperBloc>()
//                     .add(FetchHamperProductsByImageUrl(widget.imgUrl!));
//               },
//               child: const Icon(
//                 IconlyLight.buy,
//                 size: 25,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
@RoutePage()
class HamperImageStack extends StatefulWidget {
  final String? imgUrl;
  final String? hamperGifUrl1;
  final String? hamperGifUrl2;

  const HamperImageStack({
    super.key,
    required this.imgUrl,
    this.hamperGifUrl1,
    this.hamperGifUrl2,
  });

  @override
  State<HamperImageStack> createState() => _HamperImageStackState();
}

class _HamperImageStackState extends State<HamperImageStack> {
  String? selectedHamperId = '';
  Product? hamperProduct;

  @override
  Widget build(BuildContext context) {
    print("Image URL: ${widget.imgUrl}");
    print("Hamper GIF 1 URL: ${widget.hamperGifUrl1}");
    print("Hamper GIF 2 URL: ${widget.hamperGifUrl2}");
    return Scaffold(
      body: BlocListener<HamperBloc, HamperState>(
        listener: (context, state) {
          if (state is HamperIdLoaded) {
            final hamperId = state.hamperId;
            selectedHamperId = hamperId;
            context.read<HamperBloc>().add(FetchHamper(hamperId));
            context.read<HamperBloc>().add(FetchHamperProducts(hamperId));
            context.read<HamperBloc>().add(FetchHamperAsProduct(hamperId));
          }
          if (state is HamperAsProductLoaded) {
            hamperProduct = state.hamperProduct;
          }
          if (state is HamperError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error loading hamper: ${state.message}')),
            );
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Base Image (Hamper Image)
            if (widget.imgUrl != null && widget.imgUrl!.isNotEmpty)
              SizedBox(
                height: 270,
                width: MediaQuery.of(context).size.width,
                // child: Image.network(
                //   widget.imgUrl!,
                //   fit: BoxFit.fill,
                //   errorBuilder: (context, error, stackTrace) {
                //     return Container(color: Colors.grey);
                //   },
                // ),
    
                child: CachedNetworkImage(
                  imageUrl: widget.imgUrl!,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Row(
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              )
            else
              Container(color: Colors.grey),
    
            if (widget.hamperGifUrl1 != null &&
                widget.hamperGifUrl1!.isNotEmpty)
              Positioned(
                top: 10,
                left: 10,
                child: CachedNetworkImage(
                  imageUrl: widget.hamperGifUrl1!,
                  height: 40,
                  width: 70,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const SizedBox.shrink(),
                ),
              ),
    
            if (widget.hamperGifUrl2 != null &&
                widget.hamperGifUrl2!.isNotEmpty)
              Positioned(
                bottom: 10,
                right: 60,
                child: CachedNetworkImage(
                  imageUrl: widget.hamperGifUrl1!,
                  height: 40,
                  width: 70,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const SizedBox.shrink(),
                ),
              ),
    
            // GestureDetector to fetch hamper by image URL on tap
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  // This action will trigger the FetchHampersByImageUrl event
                  context
                      .read<HamperBloc>()
                      .add(FetchHampersByImageUrl(widget.imgUrl!));
                },
                child: const Icon(
                  IconlyLight.buy,
                  size: 25,
                ),
              ),
            ),
    
            // Adding the IconButton for adding to the cart
            if (selectedHamperId != null && hamperProduct != null)
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    print("Adding hamper to cart...");
                    context.read<CartBloc>().add(
                          ProductAddedToCart(
                            OrderProduct(
                              productId: hamperProduct!.id,
                              quantity: 1,
                              price: hamperProduct!.salePrice,
                              name: hamperProduct!.name,
                              imageUrl: hamperProduct!.imageUrl,
                              category: hamperProduct!.categoryName,
                            ),
                          ),
                        );
                    context.snackBarSuccess('Hamper added to cart');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
