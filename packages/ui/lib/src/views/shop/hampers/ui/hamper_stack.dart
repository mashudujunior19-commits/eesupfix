// import 'package:auto_route/auto_route.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:data/orders/models/order_product.dart';
// import 'package:data/shopping/models/product.dart';
// import 'package:data/shopping/repository/shopping_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:ui/src/core/extensions/context_alerts_ext.dart';

// import '../../../../../app_route.gr.dart';
// import '../../cart/bloc/cart_bloc.dart';
// import '../bloc/hamper_bloc.dart';

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
//   String? selectedHamperId = '';
//   Product? hamperProduct;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         final bloc = HamperBloc(context.read<ShoppingRepository>());
//         if (widget.imgUrl != null) {
//           bloc.add(FetchHampersByImageUrl(widget.imgUrl!));
//         }
//         return bloc;
//       },
//       child: Scaffold(
//         body: BlocListener<HamperBloc, HamperState>(
//           listener: (context, state) {
//             if (state is HamperIdLoaded) {
//               final hamperId = state.hamperId;
//               selectedHamperId = hamperId;
//               context.read<HamperBloc>().add(FetchHamper(hamperId));
//               context.read<HamperBloc>().add(FetchHamperProducts(hamperId));
//               context.read<HamperBloc>().add(FetchHamperAsProduct(hamperId));
//             }
//             if (state is HamperAsProductLoaded) {
//               hamperProduct = state.hamperProduct;
//             }
//             if (state is HamperError) {
//               // ScaffoldMessenger.of(context).showSnackBar(
//               //   SnackBar(
//               //       content: Text('Error loading hamper: ${state.message}')),
//               // );
//             }
//           },
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               if (widget.imgUrl != null && widget.imgUrl!.isNotEmpty)
//                 Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   child: Image.network(
//                     widget.imgUrl!,
//                     fit: BoxFit.fill,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(color: Colors.grey);
//                     },
//                   ),
//                 )
//               else
//                 Container(color: Colors.grey),
//               if (widget.hamperGifUrl1 != null &&
//                   widget.hamperGifUrl1!.isNotEmpty)
//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   child: Image.network(
//                     widget.hamperGifUrl1!,
//                     height: 50,
//                     width: 100,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container();
//                     },
//                   ),
//                 ),
//               if (widget.hamperGifUrl2 != null &&
//                   widget.hamperGifUrl2!.isNotEmpty)
//                 Positioned(
//                   bottom: 1,
//                   right: 50,
//                   child: Image.network(
//                     widget.hamperGifUrl2!,
//                     height: 75,
//                     width: 140,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container();
//                     },
//                   ),
//                 ),
//               Positioned(
//                 top: 10,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: () {
//                     print("Gesture detected!");
//                     context
//                         .read<HamperBloc>()
//                         .add(FetchHampersByImageUrl(widget.imgUrl!));
//                     context.router
//                         .push(HamperViewRoute(imageUrl: widget.imgUrl));
//                   },
//                   child: const Icon(
//                     IconlyLight.buy,
//                     size: 25,
//                   ),
//                 ),
//               ),
//               if (selectedHamperId != null && hamperProduct != null)
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: IconButton(
//                     icon: const Icon(Icons.shopping_cart),
//                     onPressed: () {
//                       print('icon pressed');
//                       context
//                           .read<HamperBloc>()
//                           .add(FetchHampersByImageUrl(widget.imgUrl!));
//                       context.read<CartBloc>().add(
//                             ProductAddedToCart(
//                               OrderProduct(
//                                 productId: hamperProduct!.id,
//                                 quantity: 1,
//                                 price: hamperProduct!.salePrice,
//                                 name: hamperProduct!.name,
//                                 imageUrl: hamperProduct!.imageUrl,
//                                 category: hamperProduct!.categoryName,
//                               ),
//                             ),
//                           );
//                       context.snackBarSuccess('Hamper added to cart');
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';

import '../../../../../app_route.gr.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../bloc/hamper_bloc.dart';

@RoutePage()
class HamperImageStack extends StatefulWidget {
  final String? imgUrl;
  final String? hamperCode;
  final double? hamperPrice;
  final double? profitpercentage;
  final String? hamperGifUrl1;
  final String? hamperGifUrl2;

  const HamperImageStack({
    super.key,
    required this.imgUrl,
    this.hamperCode,
    this.hamperPrice,
    this.profitpercentage,
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
    return BlocProvider(
      create: (context) {
        final bloc = HamperBloc(context.read<ShoppingRepository>());
        if (widget.imgUrl != null) {
          bloc.add(FetchHampersByImageUrl(widget.imgUrl!));
        }
        return bloc;
      },
      child: Scaffold(
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
              // Handle error state
              context.snackBarError('Error occurred while loading hamper.');
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.imgUrl != null && widget.imgUrl!.isNotEmpty)
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    widget.imgUrl!,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text('Failed to load image',
                            style: TextStyle(color: Colors.red)),
                      );
                    },
                  ),
                )
              else
                Container(color: Colors.grey),
              Positioned(
                top: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.hamperCode != null)
                      Text(
                        widget.hamperCode!,
                        style: GoogleFonts.lemon(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    if (widget.hamperCode != null && widget.hamperPrice != null)
                      Text(
                        '${widget.hamperCode} ${widget.hamperPrice ?? 0.0}',
                        style: GoogleFonts.lemon(
                          fontSize: 22,
                          color: Color(0xFFFF0000),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    context.router
                        .push(HamperViewRoute(imageUrl: widget.imgUrl));
                  },
                  child: const Icon(
                    IconlyLight.buy,
                    size: 25,
                  ),
                ),
              ),
              if (selectedHamperId != null && hamperProduct != null)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
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
              if (widget.profitpercentage != null)
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      print('Profit allocations clicked');
                    },
                    child: Text(
                      widget.profitpercentage != null
                          ? '${widget.profitpercentage}'
                          : 'No Profit Data',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFF0000),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
