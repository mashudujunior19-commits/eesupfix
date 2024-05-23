import 'package:auto_route/auto_route.dart';
import 'package:data/shopping/models/product_request.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/shop/product_request/product_request_dialog.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class ProductRequestScreen extends StatefulWidget {
  const ProductRequestScreen({super.key});

  @override
  State<ProductRequestScreen> createState() => _ProductRequestScreenState();
}

class _ProductRequestScreenState extends State<ProductRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('My Requests'),
          actions: [
            IconButton(
              onPressed: () {
                context
                    .showBottomSheetDialog(child: ProductRequestFormDialog())
                    .whenComplete(() => setState(() {}));
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Container(
          decoration: context.bgImage,
          width: context.width,
          height: context.height,
          child: FutureBuilder<Either<EESUpException, List<ProductRequest>>>(
              future: context.read<ShoppingRepository>().fetchProductRequests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;

                  if (data == null) {
                    return FullScreenError(
                      exception: EESUpException(
                        message: '',
                      ),
                    );
                  }

                  return data.fold((l) {
                    return FullScreenError(exception: l);
                  }, (r) {
                    final products = r;
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 100,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _ProductRequestCard(product: product)
                            .animate()
                            .slideIn(index * 50);
                      },
                    );
                  });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const FullScreenLoadingShimmer();
                } else {
                  return FullScreenError(
                    exception: EESUpException(
                      message: 'Something went wrong while '
                          'fetching your product request',
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class _ProductRequestCard extends StatelessWidget {
  const _ProductRequestCard({required this.product});

  final ProductRequest product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: .5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10, right: 5),
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade50.withOpacity(.7),
          child: Image.asset(
            "assets/images/dairy-products.png",
            width: 30,
          ),
        ),
        title: Text(product.type),
        subtitle: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10,
          children: [
            Text(
              product.brand,
              style: context.textTheme.labelSmall,
              textAlign: TextAlign.start,
            ),
            Text(
              product.packSize,
              style: context.textTheme.labelSmall,
              textAlign: TextAlign.start,
            ),
            if (product.variant != null)
              Text(
                product.variant ?? '',
                style: context.textTheme.labelSmall,
                textAlign: TextAlign.start,
              ),
            Text(
              product.productId != null ? 'Available' : 'Not Yet Added.',
              textAlign: TextAlign.start,
              style: context.textTheme.labelSmall?.copyWith(
                color: product.productId != null
                    ? Colors.green
                    : Colors.red.shade400,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () async {
            context.loaderOverlay.show();
            // final results =
            //     await ref.read(shoppingRepoProvider).deleteRequest(product.id);

            // context.loaderOverlay.hide();
            // results.fold((l) {
            //   context.snackBarError(l.message);
            // }, (r) {
            //   if (r) {
            //     context.snackBarSuccess("Request deleted successfully");
            //     ref.invalidate(productRequestsProvider);
            //   } else {
            //     context.snackBarError("Failed to delete request");
            //   }
            // });
          },
          icon: const Icon(IconlyLight.delete, size: 20),
        ),
      ),
    );
  }
}
