// ignore_for_file: unnecessary_null_comparison
import 'package:auto_route/auto_route.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/mapped_product_hamper.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/basket_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/shopping/models/hamper.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import '../../baskets/ui/basket_selection_dialog.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../bloc/hamper_bloc.dart';

@RoutePage()
class HamperViewPage extends StatefulWidget {
  final String? hamperId;
  final String? imageUrl;

  const HamperViewPage({super.key, this.hamperId, this.imageUrl});

  @override
  State<HamperViewPage> createState() => _HamperViewPageState();
}

class _HamperViewPageState extends State<HamperViewPage> {
  Hamper? selectedHamper;
  List<HamperProductDetail> products = [];
  Product? hamperProduct;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = HamperBloc(context.read<ShoppingRepository>());
        if (widget.hamperId != null) {
          bloc.add(FetchHamperProducts(widget.hamperId!));
          bloc.add(FetchHamper(widget.hamperId!));
          bloc.add(FetchHamperAsProduct(widget.hamperId!));
        } else if (widget.imageUrl != null) {
          bloc.add(FetchHampersByImageUrl(widget.imageUrl!));
        }
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          // title: Text(selectedHamper!.hamperCode),
          title: const Text('Hamper'),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_basket_outlined),
              onPressed: _addAllToBasket,
            ),
            IconButton(
              icon: const Icon(IconlyLight.buy, size: 25),
              onPressed: hamperProduct != null
                  ? () => _addHamperToCart(hamperProduct!)
                  : null,
            ),
          ],
        ),
        body: BlocListener<HamperBloc, HamperState>(
          listener: (context, state) {
            if (state is HamperLoaded) {
              selectedHamper = state.hamper;
            } else if (state is HamperProductLoaded) {
              products = state.hamperProductDetails;
            } else if (state is HamperAsProductLoaded) {
              hamperProduct = state.hamperProduct;
            } else if (state is HamperIdLoaded) {
              final hamperId = state.hamperId;
              context.read<HamperBloc>().add(FetchHamper(hamperId));
              context.read<HamperBloc>().add(FetchHamperProducts(hamperId));
              context.read<HamperBloc>().add(FetchHamperAsProduct(hamperId));
            } else if (state is HamperError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Something went wrong, please reload the page')),
              );
            }
            if (selectedHamper != null &&
                products.isNotEmpty &&
                hamperProduct != null) setState(() {});
          },
          child: BlocBuilder<HamperBloc, HamperState>(
            builder: (context, state) {
              if (state is HamperLoading) {
                return const FullScreenLoadingShimmer();
              } else if (state is HamperError) {
                return FullScreenError(
                  exception: EESUpException(
                    message: 'Something went wrong',
                  ),
                );
              }
              if (selectedHamper != null &&
                  products.isNotEmpty &&
                  hamperProduct != null) {
                return _buildHamperDetails(
                    context, selectedHamper!, products, hamperProduct!);
              }
              return const FullScreenLoadingShimmer();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _addAllToBasket() async {
    List<Product> productList =
        products.map((productDetail) => productDetail.product).toList();

    final selectedBasketId = await showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          BasketSelectionDialog(product: productList),
    );

    if (selectedBasketId != null) {
      final shoppingRepo = context.read<ShoppingRepository>();
      for (final product in products) {
        shoppingRepo.addProductToBasket(selectedBasketId, product.productId);
      }
      context.snackBarSuccess('All items added to selected basket.');

      final addToCart = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add to Cart"),
            content: const Text(
                "Would you like to add the entire hamper to the cart?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );

      if (addToCart == true) {
        if (selectedHamper != null) {
          context.read<CartBloc>().add(
                ProductAddedToCart(
                  OrderProduct(
                    productId: hamperProduct!.id,
                    quantity: 1,
                    price: hamperProduct!.salePrice,
                    name: hamperProduct!.name,
                    imageUrl: hamperProduct!.imageUrl,
                  ),
                ),
              );
          context.snackBarSuccess('Hamper added to cart');
        }
      }
    }
  }

  Future<void> _addHamperToCart(Product hamperProduct) async {
    if (selectedHamper != null) {
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
      context.snackBarSuccess('Hamper added to cart');
    }
  }

  Widget _buildHamperDetails(BuildContext context, Hamper hamper,
      List<HamperProductDetail> products, Product hamperProduct) {
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hamper.hamperCode,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text("Type: ${hamper.type}"),
                  const SizedBox(height: 8),
                  Text("Hamper Value: ${hamper.value.toStringAsFixed(2)}"),
                  const SizedBox(height: 8),
                  Text(
                      "Expiry date: ${hamper.expiryDate.toLocal().toString().split(' ')[0]}"),
                  const SizedBox(height: 10),
                  if (hamper.imgUrl != null && hamper.imgUrl!.isNotEmpty)
                    buildImageStack(
                      hamper.imgUrl,
                      hamper.gifUrl1,
                      hamper.gifUrl2,
                    )
                  else
                    _buildPlaceholderImage(),
                ],
              ),
            ),
            const Divider(),
            Container(
              color: Colors.grey[100],
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(text: "Products"),
                  Tab(text: "Allocations"),
                ],
              ),
            ),
            SizedBox(
              height: 400,
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: _buildProductList(context, products),
                  ),
                  SingleChildScrollView(
                    child: _buildProductList(context, products),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageStack(
      String? imgUrl, String? hamperGifUrl1, String? hamperGifUrl2) {
    return Container(
      width: double.infinity,
      height: 180,
      child: Stack(
        children: [
          // Full Background Image
          if (imgUrl != null && imgUrl.isNotEmpty)
            Positioned.fill(
              child: Image.network(
                imgUrl,
                fit: BoxFit.contain, // Ensure full image is shown
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey);
                },
              ),
            )
          else
            Positioned.fill(child: Container(color: Colors.grey)),

          // Top GIF
          if (hamperGifUrl1 != null && hamperGifUrl1.isNotEmpty)
            Positioned(
              top: 10,
              left: 10,
              child: Image.network(
                hamperGifUrl1,
                height: 50,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),

          // Bottom GIF
          if (hamperGifUrl2 != null && hamperGifUrl2.isNotEmpty)
            Positioned(
              bottom: 0, // Position at the bottom
              right: 20,
              child: Image.network(
                hamperGifUrl2,
                height: 75,
                width: 140,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductList(
      BuildContext context, List<HamperProductDetail> products) {
    final sortedProducts = products
      ..sort((a, b) {
        int freeComparison = (b.isFree ? 1 : 0).compareTo(a.isFree ? 1 : 0);
        if (freeComparison != 0) {
          return freeComparison;
        }

        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _ProductItemCard(productDetail: sortedProducts[index]);
      },
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 100,
        color: Colors.grey,
      ),
    );
  }

  // Widget _buildAllocationsView(Product hamperProduct) {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(16),
  //     itemCount: hamperProduct.allocations.length,
  //     itemBuilder: (context, index) {
  //       final allocation = hamperProduct.allocations[index];
  //       return Card(
  //         margin: const EdgeInsets.symmetric(vertical: 8),
  //         child: ListTile(
  //           title: Text(allocation.recipientName),
  //           subtitle: Text("Allocated: ${allocation.quantity}"),
  //         ),
  //       );
  //     },
  //   );
  // }
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
                  Text(
                      "Price: R${productDetail.salePrice.toStringAsFixed(2)}                       (${productDetail.quantity})"),
                  if (productDetail.isFree)
                    const Text(
                      "Free",
                      style: TextStyle(
                        color: Colors.green,
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
