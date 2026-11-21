import 'package:data/shopping/models/hamper_builder_item.dart';

/// What a customer has picked so far for their own hamper.
///
/// Immutable: every change returns a new selection, and nothing goes above the
/// most the admin allows for that product.
class HamperSelection {
  const HamperSelection([this.quantities = const {}]);

  /// product id -> quantity (only quantities above zero are kept).
  final Map<int, int> quantities;

  int quantityOf(int productId) => quantities[productId] ?? 0;

  int get itemCount => quantities.values.fold(0, (a, b) => a + b);
  bool get isEmpty => quantities.isEmpty;

  HamperSelection add(HamperBuilderItem item) {
    final now = quantityOf(item.productId);
    if (now >= item.maxQuantity) return this;
    return HamperSelection({...quantities, item.productId: now + 1});
  }

  HamperSelection remove(HamperBuilderItem item) {
    final now = quantityOf(item.productId);
    if (now <= 0) return this;
    final next = {...quantities};
    if (now == 1) {
      next.remove(item.productId);
    } else {
      next[item.productId] = now - 1;
    }
    return HamperSelection(next);
  }

  /// Today's price of everything picked. Products that are no longer on the
  /// list count for nothing.
  double total(List<HamperBuilderItem> items) {
    var sum = 0.0;
    for (final i in items) {
      sum += i.price * quantityOf(i.productId);
    }
    return sum;
  }

  /// The picked products, in list order, with their quantities.
  List<(HamperBuilderItem, int)> lines(List<HamperBuilderItem> items) => [
        for (final i in items)
          if (quantityOf(i.productId) > 0) (i, quantityOf(i.productId)),
      ];
}

/// Items whose name, brand or size contains [query] (all when it is blank).
List<HamperBuilderItem> searchBuilderItems(
    List<HamperBuilderItem> items, String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return items;
  return items
      .where((i) =>
          i.name.toLowerCase().contains(q) ||
          (i.brand ?? '').toLowerCase().contains(q) ||
          (i.size ?? '').toLowerCase().contains(q))
      .toList();
}
