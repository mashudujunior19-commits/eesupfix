import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper_offer.dart';
import 'package:data/shopping/repository/hamper_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/themes/towris_brand.dart';

import '../../cart/bloc/cart_bloc.dart';
import 'compare_hamper_to_cart.dart';
import 'hamper_browse.dart';
import 'hamper_widgets.dart';

/// Shown on the cart when its contents are exactly a hamper that costs less:
/// "Switch to hamper H12 and save R40". It stays hidden on any failure, since
/// it is only a suggestion and must never get in the way of checkout.
class HamperCartSuggestion extends StatefulWidget {
  const HamperCartSuggestion({super.key, required this.products});
  final List<OrderProduct> products;

  @override
  State<HamperCartSuggestion> createState() => _HamperCartSuggestionState();
}

class _HamperCartSuggestionState extends State<HamperCartSuggestion> {
  List<HamperOffer>? _hampers;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final result = await context.read<ShoppingRepository>().fetchHamperOffers();
      result.fold((_) {}, (h) {
        if (mounted) setState(() => _hampers = h);
      });
    } catch (_) {}
  }

  void _switch(HamperOffer h) {
    final cart = context.read<CartBloc>();
    cart.add(CartCleared());
    cart.add(
      ProductAddedToCart(
        OrderProduct(
          productId: h.productId!,
          quantity: 1,
          price: h.price,
          name: h.productName ?? 'Hamper ${h.code}',
          imageUrl: h.productImageUrl ?? h.imgUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hampers = _hampers;
    if (hampers == null) return const SizedBox.shrink();
    final match = HamperComparer(
      cartProducts: widget.products,
      hampers: hampers,
    ).findMatchingHamper();
    if (match == null) return const SizedBox.shrink();
    final total = widget.products
        .fold<double>(0, (sum, p) => sum + p.price * p.quantity);
    final saving = hamperSwitchSaving(total, match);
    if (saving <= 0) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
      decoration: BoxDecoration(
        color: TowrisBrand.mint,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'These items make up hamper ${match.code}. Switch and save '
              '${hamperMoney(saving)}.',
              style: const TextStyle(
                color: TowrisBrand.deepGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _switch(match),
            child: const Text('Switch'),
          ),
        ],
      ),
    );
  }
}
