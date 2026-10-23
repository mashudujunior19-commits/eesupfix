import 'package:data/orders/models/order_product.dart';
import 'package:flutter_test/flutter_test.dart';

OrderProduct _p(int id, int qty) =>
    OrderProduct(productId: id, name: 'p$id', price: 10, quantity: qty);

void main() {
  test('lines for the same product are merged into one order line', () {
    final merged = mergeDuplicateProducts([_p(1, 2), _p(2, 1), _p(1, 3)]);

    expect(merged.map((p) => p.productId), [1, 2]);
    expect(merged.first.quantity, 5);
    expect(merged.last.quantity, 1);
  });
}
