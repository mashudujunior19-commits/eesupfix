import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/shopping/models/product.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.isBundle = false});
  final Product product;
  final bool isBundle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: isBundle ? 170 : null,
        height: isBundle ? 250 : null,
        margin: isBundle
            ? const EdgeInsets.only(left: 15, right: 5, top: 10, bottom: 10)
            : null,
        padding: isBundle
            ? const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 20)
            : const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.sH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // addProductToBasketDialog(context, product);
                  },
                  child: const Icon(
                    BootstrapIcons.basket,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                //  CartButtons(product: product),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 70,
                  width: 70,
                  child: product.imageUrl != null
                      ? Image.network(product.imageUrl!, width: 27)
                      : Image.asset('assets/images/no-photo.png',
                          width: 27, color: Colors.grey),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                product.name.trim(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                product.categoryName ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (product.sellable)
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      'R${product.salePrice.toStringAsFixed(2)}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  )
                else
                  1.sW,
                if (product.size != null)
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade400,
                        borderRadius: BorderRadius.circular(7)),
                    child: Text(
                      product.size!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class CartButtons extends ConsumerWidget with CartProviderMixin {
//   const CartButtons({super.key, required this.product});
//   final Product product;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     int qty = productQty(ref, product.id);
//     if (!product.sellable) return 0.sH;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.blueGrey.shade100,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (qty > 0)
//                 GestureDetector(
//                   onTap: () {
//                     decrementQuantity(ref, product.id);
//                   },
//                   child: Container(
//                     height: 30,
//                     width: 30,
//                     decoration: BoxDecoration(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.circular(
//                         10,
//                       ),
//                       border: Border.all(
//                         color: Colors.blueGrey.shade100,
//                       ),
//                     ),
//                     child: Icon(
//                       MdiIcons.minus,
//                       color: Colors.red,
//                       size: 16,
//                     ),
//                   ),
//                 ),
//               if (qty > 0)
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   child: Text(qty.toString()),
//                 ),
//               GestureDetector(
//                 onTap: () {
//                   if (!product.sellable) {
//                     context.snackBarError(
//                       'This Item is currently not available for sale.',
//                     );
//                     return;
//                   }
//                   addToCart(
//                     ref,
//                     OrderProduct(
//                       productId: product.id,
//                       quantity: 1,
//                       productClass: product.productClass,
//                       price: product.salePrice,
//                       name: product.name,
//                       imageUrl: product.imageUrl,
//                       category: product.categoryName,
//                       size: product.size,
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     qty == 0 ? IconlyLight.buy : MdiIcons.plus,
//                     color: Colors.white,
//                     size: 19,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
