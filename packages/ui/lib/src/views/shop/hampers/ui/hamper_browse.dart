import 'package:data/shopping/models/hamper_offer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hamper_widgets.dart';

/// How the hampers list can be ordered.
enum HamperSort {
  recommended('Recommended'),
  priceLow('Price: low to high'),
  priceHigh('Price: high to low'),
  biggestSaving('Biggest saving'),
  endingSoon('Ending soon');

  const HamperSort(this.label);
  final String label;
}

/// The distinct hamper types, in the order they first appear.
List<String> hamperTypes(List<HamperOffer> hampers) {
  final seen = <String>[];
  for (final h in hampers) {
    final t = h.type.trim();
    if (t.isNotEmpty && !seen.contains(t)) seen.add(t);
  }
  return seen;
}

/// Keeps hampers of [type] (all when null) and orders them by [sort].
/// Never changes the list it is given.
List<HamperOffer> browseHampers(
  List<HamperOffer> hampers, {
  String? type,
  HamperSort sort = HamperSort.recommended,
  DateTime? now,
}) {
  final result =
      hampers.where((h) => type == null || h.type.trim() == type).toList();
  int ending(HamperOffer a, HamperOffer b) {
    final da = a.daysLeft(now);
    final db = b.daysLeft(now);
    if (da == null && db == null) return 0;
    if (da == null) return 1; // no end date goes last
    if (db == null) return -1;
    return da.compareTo(db);
  }

  switch (sort) {
    case HamperSort.recommended:
      break; // the database order: newest first
    case HamperSort.priceLow:
      result.sort((a, b) => a.price.compareTo(b.price));
    case HamperSort.priceHigh:
      result.sort((a, b) => b.price.compareTo(a.price));
    case HamperSort.biggestSaving:
      result.sort((a, b) => b.saving.compareTo(a.saving));
    case HamperSort.endingSoon:
      result.sort(ending);
  }
  return result;
}

/// The text shared when a customer sends a hamper to a friend.
String hamperShareText(HamperOffer h) {
  final saving =
      h.saving > 0 ? ' It saves you ${hamperMoney(h.saving)}.' : '';
  return 'Hamper ${h.code} on Towris: ${h.itemCount} items for '
      '${hamperMoney(h.price)}.$saving';
}

/// What the cart would save by switching to [hamper], or 0 when it would not.
double hamperSwitchSaving(double cartTotal, HamperOffer hamper) {
  final saving = cartTotal - hamper.price;
  return saving > 0 ? saving : 0;
}

/// Hamper ids the customer has hearted, kept on the device.
class HamperFavourites {
  static const _key = 'favourite_hamper_ids';

  static Future<Set<String>> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return (prefs.getStringList(_key) ?? const []).toSet();
    } catch (_) {
      return <String>{};
    }
  }

  /// Flips [id] and returns the new set.
  static Future<Set<String>> toggle(String id) async {
    final current = await load();
    current.contains(id) ? current.remove(id) : current.add(id);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, current.toList());
    } catch (_) {}
    return current;
  }
}
