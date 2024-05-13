part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CurrentCart extends CartState {
  final List<OrderProduct> products;
  CurrentCart(this.products);

  int totalQty() {
    int qty = 0;
    for (var element in products) {
      qty += element.quantity;
    }
    return qty;
  }

  int totalProductQty(int id) {
    try {
      final product = products.firstWhere((element) => element.productId == id);
      return product.quantity;
    } catch (_) {
      return 0;
    }
  }

  double totalAmount() {
    double total = 0.00;
    for (var element in products) {
      total += (element.price * element.quantity);
    }
    return total;
  }
}
