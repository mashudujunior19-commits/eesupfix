import 'package:data/shopping/models/hamper_offer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/views/shop/hampers/ui/hamper_browse.dart';

HamperOffer _h(String id, String type, double price, double saving,
        {String? expiry}) =>
    HamperOffer.fromJson({
      'id': id,
      'code': id.toUpperCase(),
      'type': type,
      'value': price,
      'worth': price + saving,
      'saving': saving,
      'available': true,
      'product_id': 1,
      'expiry_date': expiry,
      'items': [
        {'product_id': 1, 'name': 'Rice', 'quantity': 1, 'price': price}
      ],
    });

void main() {
  final now = DateTime(2026, 11, 21);
  final a = _h('a', 'Family', 300, 20, expiry: '2026-12-01');
  final b = _h('b', 'Starter', 120, 50, expiry: '2026-11-23');
  final c = _h('c', 'Family', 200, 0);
  final all = [a, b, c];

  List<String> ids(List<HamperOffer> l) => l.map((e) => e.id).toList();

  test('types are distinct, in first-seen order, blanks skipped', () {
    expect(hamperTypes([a, b, c, _h('d', '  ', 1, 0)]), ['Family', 'Starter']);
  });

  test('filter by type', () {
    expect(ids(browseHampers(all, type: 'Family')), ['a', 'c']);
    expect(ids(browseHampers(all)), ['a', 'b', 'c']);
  });

  test('sorts', () {
    expect(ids(browseHampers(all, sort: HamperSort.priceLow)), ['b', 'c', 'a']);
    expect(
        ids(browseHampers(all, sort: HamperSort.priceHigh)), ['a', 'c', 'b']);
    expect(ids(browseHampers(all, sort: HamperSort.biggestSaving)),
        ['b', 'a', 'c']);
    expect(ids(browseHampers(all, sort: HamperSort.endingSoon, now: now)),
        ['b', 'a', 'c']); // no end date goes last
  });

  test('does not change the list it was given', () {
    browseHampers(all, sort: HamperSort.priceLow);
    expect(ids(all), ['a', 'b', 'c']);
  });

  test('share text and cart switch saving', () {
    expect(hamperShareText(a), contains('R300.00'));
    expect(hamperShareText(a), contains('saves you R20.00'));
    expect(hamperShareText(c), isNot(contains('saves')));
    expect(hamperSwitchSaving(350, a), 50);
    expect(hamperSwitchSaving(300, a), 0);
    expect(hamperSwitchSaving(250, a), 0);
  });
}
