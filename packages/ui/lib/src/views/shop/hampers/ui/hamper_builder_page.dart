import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper_builder_item.dart';
import 'package:data/shopping/repository/hamper_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/core/widgets/safe_network_image.dart';

import '../../cart/bloc/cart_bloc.dart';
import 'hamper_builder_logic.dart';
import 'hamper_widgets.dart';

/// Pick your own items, see the total as you go, then add them to the cart.
/// The items go in as ordinary cart lines at their normal price.
class HamperBuilderPage extends StatefulWidget {
  const HamperBuilderPage({super.key});

  @override
  State<HamperBuilderPage> createState() => _HamperBuilderPageState();
}

class _HamperBuilderPageState extends State<HamperBuilderPage> {
  List<HamperBuilderItem>? _items;
  String? _error;
  var _selection = const HamperSelection();
  var _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _items = null;
      _error = null;
    });
    final result =
        await context.read<ShoppingRepository>().fetchHamperBuilderItems();
    if (!mounted) return;
    result.fold(
      (e) => setState(() => _error = e.message),
      (items) => setState(() => _items = items),
    );
  }

  void _addToCart(List<HamperBuilderItem> items) {
    final cart = context.read<CartBloc>();
    for (final (item, qty) in _selection.lines(items)) {
      for (var i = 0; i < qty; i++) {
        cart.add(
          ProductAddedToCart(
            OrderProduct(
              productId: item.productId,
              quantity: 1,
              price: item.price,
              name: item.name,
              imageUrl: item.imageUrl,
            ),
          ),
        );
      }
    }
    context.snackBarSuccess('${_selection.itemCount} items added to cart');
    setState(() => _selection = const HamperSelection());
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    return Scaffold(
      appBar: AppBar(title: const Text('Build your own hamper')),
      body: _error != null
          ? HamperRetry(message: _error!, onRetry: _load)
          : items == null
              ? const FullScreenLoadingShimmer()
              : items.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'Build your own hamper is not set up yet. '
                          'Please check back soon.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : _body(items),
    );
  }

  Widget _body(List<HamperBuilderItem> items) {
    final shown = searchBuilderItems(items, _query);
    final total = _selection.total(items);
    final belowMinimum = total > 0 && total < 200;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search items',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: shown.isEmpty
              ? const Center(child: Text('No items match your search.'))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                  itemCount: shown.length,
                  itemBuilder: (_, i) => _ItemRow(
                    item: shown[i],
                    quantity: _selection.quantityOf(shown[i].productId),
                    onAdd: () =>
                        setState(() => _selection = _selection.add(shown[i])),
                    onRemove: () => setState(
                        () => _selection = _selection.remove(shown[i])),
                  ),
                ),
        ),
        Material(
          elevation: 8,
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hamperMoney(total),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          belowMinimum
                              ? '${_selection.itemCount} items | '
                                  'R200 minimum at checkout'
                              : '${_selection.itemCount} items',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed:
                        _selection.isEmpty ? null : () => _addToCart(items),
                    child: const Text('Add to cart'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });
  final HamperBuilderItem item;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final detail = [item.brand, item.size]
        .where((s) => s != null && s.isNotEmpty)
        .join(' | ');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SafeNetworkImage(item.imageUrl, width: 56, height: 56),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
                  if (detail.isNotEmpty)
                    Text(detail,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade700)),
                  Text(hamperMoney(item.price),
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            IconButton(
              tooltip: 'One fewer ${item.name}',
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              onPressed: quantity > 0 ? onRemove : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            SizedBox(
              width: 20,
              child: Text('$quantity', textAlign: TextAlign.center),
            ),
            IconButton(
              tooltip: 'One more ${item.name}',
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              onPressed: quantity < item.maxQuantity ? onAdd : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }
}
