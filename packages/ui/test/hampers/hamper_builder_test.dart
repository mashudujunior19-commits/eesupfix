import 'package:data/shopping/models/hamper_builder_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/views/shop/hampers/ui/hamper_builder_logic.dart';

HamperBuilderItem _item(int id, String name, double price,
        {int max = 3, String? brand, String? size}) =>
    HamperBuilderItem.fromJson({
      'product_id': id,
      'name': name,
      'price': price,
      'max_quantity': max,
      'brand': brand,
      'size': size,
    });

void main() {
  final rice = _item(1, 'Rice', 40, max: 2, brand: 'Spekko', size: '2kg');
  final oil = _item(2, 'Cooking oil', 55.5, brand: 'Sunfoil', size: '750ml');
  final items = [rice, oil];

  test('adds up to the maximum and no further', () {
    var s = const HamperSelection();
    s = s.add(rice).add(rice).add(rice);
    expect(s.quantityOf(1), 2);
    expect(s.itemCount, 2);
  });

  test('removing the last one drops the product', () {
    final s = const HamperSelection().add(rice).remove(rice);
    expect(s.isEmpty, isTrue);
    expect(const HamperSelection().remove(rice).isEmpty, isTrue);
  });

  test('total uses today prices and ignores products not on the list', () {
    final s = const HamperSelection().add(rice).add(rice).add(oil);
    expect(s.total(items), 135.5);
    expect(s.total([rice]), 80); // oil no longer offered
  });

  test('lines come back in list order with quantities', () {
    final s = const HamperSelection().add(oil).add(rice).add(rice);
    expect(s.lines(items).map((l) => (l.$1.productId, l.$2)).toList(),
        [(1, 2), (2, 1)]);
  });

  test('a selection is never changed in place', () {
    const a = HamperSelection();
    a.add(rice);
    expect(a.isEmpty, isTrue);
  });

  test('search matches name, brand and size, ignoring case', () {
    expect(searchBuilderItems(items, 'RICE'), [rice]);
    expect(searchBuilderItems(items, 'sunfoil'), [oil]);
    expect(searchBuilderItems(items, '750'), [oil]);
    expect(searchBuilderItems(items, '  '), items);
    expect(searchBuilderItems(items, 'zzz'), isEmpty);
  });

  test('item parsing tolerates missing fields', () {
    final i = HamperBuilderItem.fromJson({'product_id': 9});
    expect(i.name, '');
    expect(i.price, 0);
    expect(i.maxQuantity, 1);
    expect(HamperBuilderItem.fromJson({'product_id': 9, 'max_quantity': 0})
        .maxQuantity, 1);
  });
}
