import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper_banner_details.dart';
import 'package:data/shopping/models/hamper_offer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/views/shop/hampers/ui/compare_hamper_to_cart.dart';
import 'package:ui/src/views/shop/hampers/ui/hamper_widgets.dart';

Map<String, dynamic> _json({
  String id = 'h1',
  bool available = true,
  int? productId = 900,
  List<Map<String, dynamic>>? items,
  String? expiry,
}) =>
    {
      'id': id,
      'code': 'H12',
      'type': 'Family',
      'value': 250,
      'worth': 310.5,
      'saving': 60.5,
      'item_count': 2,
      'available': available,
      'expiry_date': expiry,
      'img_url': 'https://x/h.png',
      'hamper_gif_url1': null,
      'hamper_gif_url2': null,
      'product_id': productId,
      'product_name': 'Hamper H12',
      'product_image_url': null,
      'items': items ??
          [
            {
              'product_id': 1,
              'name': 'Rice 2kg',
              'image_url': null,
              'quantity': 2,
              'is_free': false,
              'price': 40,
              'is_active': true,
            },
            {
              'product_id': 2,
              'name': 'Sugar',
              'image_url': null,
              'quantity': 1,
              'is_free': true,
              'price': 30.5,
              'is_active': true,
            },
          ],
    };

void main() {
  group('HamperOffer.fromJson', () {
    test('reads price, saving and the items', () {
      final offer = HamperOffer.fromJson(_json());
      expect(offer.price, 250);
      expect(offer.saving, 60.5);
      expect(offer.itemCount, 2);
      expect(offer.freeItemCount, 1);
      expect(offer.quantities, {1: 2, 2: 1});
      expect(offer.canBuy, isTrue);
    });

    test('cannot be bought without a product row or when unavailable', () {
      expect(HamperOffer.fromJson(_json(productId: null)).canBuy, isFalse);
      expect(HamperOffer.fromJson(_json(available: false)).canBuy, isFalse);
    });

    test('tolerates missing optional fields', () {
      final offer = HamperOffer.fromJson({'id': 'h2', 'items': null});
      expect(offer.code, '');
      expect(offer.price, 0);
      expect(offer.items, isEmpty);
      expect(offer.expiryDate, isNull);
      expect(offer.canBuy, isFalse);
    });
  });

  group('days left', () {
    final now = DateTime(2026, 11, 21, 15, 30);

    test('counts whole days and treats today as 0', () {
      expect(
          HamperOffer.fromJson(_json(expiry: '2026-11-21')).daysLeft(now), 0);
      expect(
          HamperOffer.fromJson(_json(expiry: '2026-11-22')).daysLeft(now), 1);
      expect(
          HamperOffer.fromJson(_json(expiry: '2026-11-26')).daysLeft(now), 5);
    });

    test('no end date means no label', () {
      final offer = HamperOffer.fromJson(_json());
      expect(offer.daysLeft(now), isNull);
      expect(hamperEndsIn(offer, now), isNull);
    });

    test('wording', () {
      String? label(String d) =>
          hamperEndsIn(HamperOffer.fromJson(_json(expiry: d)), now);
      expect(label('2026-11-21'), 'Ends today');
      expect(label('2026-11-22'), 'Ends tomorrow');
      expect(label('2026-11-26'), 'Ends in 5 days');
    });
  });

  test('money is written as rands with two decimals', () {
    expect(hamperMoney(250), 'R250.00');
    expect(hamperMoney(60.5), 'R60.50');
  });

  group('HamperComparer', () {
    OrderProduct line(int id, int qty) =>
        OrderProduct(productId: id, price: 1, name: 'p$id', quantity: qty);

    final hamper = HamperOffer.fromJson(_json());

    test('matches a cart with exactly the hamper contents', () {
      final match = HamperComparer(
        cartProducts: [line(1, 2), line(2, 1)],
        hampers: [hamper],
      ).findMatchingHamper();
      expect(match?.id, 'h1');
    });

    test('does not match when a quantity differs', () {
      expect(
        HamperComparer(
          cartProducts: [line(1, 3), line(2, 1)],
          hampers: [hamper],
        ).findMatchingHamper(),
        isNull,
      );
    });

    test('does not match a cart that holds only part of the hamper', () {
      expect(
        HamperComparer(cartProducts: [line(1, 2)], hampers: [hamper])
            .findMatchingHamper(),
        isNull,
      );
    });

    test('does not match an empty cart or a hamper that cannot be bought', () {
      expect(
        HamperComparer(cartProducts: const [], hampers: [hamper])
            .findMatchingHamper(),
        isNull,
      );
      expect(
        HamperComparer(
          cartProducts: [line(1, 2), line(2, 1)],
          hampers: [HamperOffer.fromJson(_json(available: false))],
        ).findMatchingHamper(),
        isNull,
      );
    });
  });

  group('HamperBannerDetail', () {
    test('carries the hamper id and the saving, not profit', () {
      final d = HamperBannerDetail.fromJson({
        'hamper_id': 'h1',
        'base_image': 'https://x/a.png',
        'order_number': 2,
        'code': 'H12',
        'value': 250,
        'saving': 40,
      });
      expect(d.hamperId, 'h1');
      expect(d.saving, 40);
      expect(d.toJson().keys, isNot(contains('profit')));
      expect(d.toJson().keys, isNot(contains('profit_percentage')));
    });

    test('a plain banner image has no hamper id', () {
      final d = HamperBannerDetail.fromJson(
          {'base_image': 'https://x/a.png', 'order_number': 1});
      expect(d.hamperId, isNull);
    });
  });
}
