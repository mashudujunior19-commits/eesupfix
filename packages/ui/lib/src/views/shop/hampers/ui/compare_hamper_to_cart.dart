import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper_offer.dart';

/// Finds a hamper whose contents are exactly what is in the cart.
class HamperComparer {
  final List<OrderProduct> cartProducts;
  final List<HamperOffer> hampers;

  HamperComparer({required this.cartProducts, required this.hampers});

  HamperOffer? findMatchingHamper() {
    if (cartProducts.isEmpty) return null;
    for (final hamper in hampers) {
      if (!hamper.canBuy) continue;
      final quantities = hamper.quantities;
      if (quantities.length != cartProducts.length) continue;
      final allMatch = cartProducts
          .every((item) => quantities[item.productId] == item.quantity);
      if (allMatch) return hamper;
    }
    return null;
  }
}
