import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper.dart';

class HamperComparer {
  final List<OrderProduct> cartProducts;
  final List<Hamper> hampers;

  HamperComparer({required this.cartProducts, required this.hampers});

  Hamper? findMatchingHamper() {
    for (var hamper in hampers) {
      print("Checking hamper: ${hamper.id}");
      if (hamper.productIds == null || hamper.quantity == null) continue;

      final hamperProductIds = hamper.productIds!.toSet();
      final hamperQuantities = hamper.quantity!;
      bool allMatch = cartProducts.every((cartProduct) {
        final productId = cartProduct.productId;
        bool isMatching = hamperProductIds.contains(productId) &&
            hamperQuantities[productId] == cartProduct.quantity;
        print(
            "Comparing productId $productId (cart) with hamper productIds: $hamperProductIds. Match: $isMatching");
        return isMatching;
      });

      if (allMatch) {
        print("Match found with hamper ${hamper.id}");
        return hamper;
      } else {
        print('no matching hamper found!!!');
      }
    }
    return null;
  }
}
