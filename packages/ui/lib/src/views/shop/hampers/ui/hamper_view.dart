import 'package:auto_route/auto_route.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper_offer.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/core/widgets/safe_network_image.dart';
import 'package:data/utils/eesup_exception.dart';

import '../../baskets/ui/basket_selection_dialog.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../bloc/hamper_bloc.dart';
import 'hamper_widgets.dart';

/// One hamper: what it costs, what is inside and how much it saves.
///
/// Everything comes from a single call (`get_hampers`). The page never shows
/// cost, profit or allocation figures: the database does not send them.
@RoutePage()
class HamperViewPage extends StatelessWidget {
  final String hamperId;

  const HamperViewPage({super.key, required this.hamperId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HamperBloc(context.read<ShoppingRepository>())
        ..add(LoadHamper(hamperId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Hamper')),
        body: BlocBuilder<HamperBloc, HamperState>(
          builder: (context, state) {
            if (state is HamperLoading || state is HamperInitial) {
              return const FullScreenLoadingShimmer();
            }
            if (state is HamperError) {
              return HamperRetry(
                message: state.message,
                onRetry: () =>
                    context.read<HamperBloc>().add(LoadHamper(hamperId)),
              );
            }
            if (state is HamperNotFound) {
              return FullScreenError(
                exception: EESUpException(
                  message: 'This hamper is no longer available.',
                ),
                isError: false,
              );
            }
            if (state is HamperLoaded) {
              return _HamperDetails(hamper: state.hamper);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _HamperDetails extends StatelessWidget {
  const _HamperDetails({required this.hamper});
  final HamperOffer hamper;

  void _addToCart(BuildContext context) {
    context.read<CartBloc>().add(
          ProductAddedToCart(
            OrderProduct(
              productId: hamper.productId!,
              quantity: 1,
              price: hamper.price,
              name: hamper.productName ?? 'Hamper ${hamper.code}',
              imageUrl: hamper.productImageUrl ?? hamper.imgUrl,
            ),
          ),
        );
    context.snackBarSuccess('Hamper added to cart');
  }

  Future<void> _addItemsToBasket(BuildContext context) async {
    final products = hamper.items
        .map(
          (i) => Product(
            id: i.productId,
            name: i.name,
            imageUrl: i.imageUrl,
            salePrice: i.price,
            productClass: ProductClass.food,
            sellable: true,
          ),
        )
        .toList();

    // The dialog adds the products to the chosen basket itself.
    await showDialog<String>(
      context: context,
      builder: (_) => BasketSelectionDialog(product: products),
    );
  }

  @override
  Widget build(BuildContext context) {
    final endsIn = hamperEndsIn(hamper);
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              HamperPicture(
                imgUrl: hamper.imgUrl,
                gifUrl1: hamper.gifUrl1,
                gifUrl2: hamper.gifUrl2,
                semanticLabel: 'Picture of hamper ${hamper.code}',
              ),
              const SizedBox(height: 12),
              Text(hamper.code, style: theme.textTheme.headlineMedium),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  if (hamper.type.isNotEmpty) HamperChip(hamper.type),
                  if (hamper.saving > 0)
                    HamperChip('Save ${hamperMoney(hamper.saving)}',
                        highlight: true),
                  if (endsIn != null) HamperChip(endsIn),
                ],
              ),
              if (hamper.saving > 0) ...[
                const SizedBox(height: 8),
                Text(
                  'Worth ${hamperMoney(hamper.worth)} if bought one by one.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.grey.shade700),
                ),
              ],
              const SizedBox(height: 20),
              Text(
                hamper.freeItemCount > 0
                    ? 'What is inside (${hamper.itemCount} items, '
                        '${hamper.freeItemCount} free)'
                    : 'What is inside (${hamper.itemCount} items)',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (hamper.items.isEmpty)
                const Text('This hamper has no items yet.')
              else
                for (final item in hamper.items) _ItemRow(item: item),
            ],
          ),
        ),
        _BottomBar(
          hamper: hamper,
          onAddToCart: () => _addToCart(context),
          onAddItemsToBasket: () => _addItemsToBasket(context),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.hamper,
    required this.onAddToCart,
    required this.onAddItemsToBasket,
  });
  final HamperOffer hamper;
  final VoidCallback onAddToCart;
  final VoidCallback onAddItemsToBasket;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      hamperMoney(hamper.price),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  FilledButton(
                    onPressed: hamper.canBuy ? onAddToCart : null,
                    child: const Text('Add hamper to cart'),
                  ),
                ],
              ),
              if (!hamper.canBuy)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'This hamper cannot be bought right now.',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
              if (hamper.items.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: onAddItemsToBasket,
                    child: const Text('Add the items to a basket instead'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({required this.item});
  final HamperOfferItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SafeNetworkImage(item.imageUrl, width: 52, height: 52),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 2),
                  Text(
                    item.isFree
                        ? 'Free'
                        : '${hamperMoney(item.price)} each',
                    style: TextStyle(
                      color: item.isFree
                          ? Colors.green.shade800
                          : Colors.grey.shade700,
                      fontWeight:
                          item.isFree ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (!item.isActive)
                    Text(
                      'Not available right now',
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                ],
              ),
            ),
            Text('x${item.quantity}',
                style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
