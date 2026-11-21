import 'package:auto_route/auto_route.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/shopping/models/hamper_offer.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';

import '../../cart/bloc/cart_bloc.dart';
import '../bloc/hamper_bloc.dart';
import 'hamper_browse.dart';
import 'hamper_builder_page.dart';
import 'hamper_widgets.dart';

@RoutePage()
class HampersList extends StatelessWidget {
  const HampersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HamperBloc(context.read<ShoppingRepository>())..add(LoadHampers()),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Hampers'),
        ),
        body: BlocBuilder<HamperBloc, HamperState>(
          builder: (context, state) {
            if (state is HamperLoading || state is HamperInitial) {
              return const FullScreenLoadingShimmer();
            }
            if (state is HamperError) {
              return HamperRetry(
                message: state.message,
                onRetry: () => context.read<HamperBloc>().add(LoadHampers()),
              );
            }
            if (state is HampersLoaded) {
              if (state.hampers.isEmpty) {
                return FullScreenError(
                  exception: EESUpException(
                    message: 'No hampers right now. Check back soon, or '
                        'browse the shop in the meantime.',
                  ),
                  isError: false,
                );
              }
              return _HampersBody(hampers: state.hampers);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _HampersBody extends StatefulWidget {
  const _HampersBody({required this.hampers});
  final List<HamperOffer> hampers;

  @override
  State<_HampersBody> createState() => _HampersBodyState();
}

class _HampersBodyState extends State<_HampersBody> {
  String? _type;
  HamperSort _sort = HamperSort.recommended;
  Set<String> _favourites = {};

  @override
  void initState() {
    super.initState();
    HamperFavourites.load().then((f) {
      if (mounted) setState(() => _favourites = f);
    });
  }

  Future<void> _toggleFavourite(String id) async {
    final next = await HamperFavourites.toggle(id);
    if (mounted) setState(() => _favourites = next);
  }

  void _add(HamperOffer h) {
    context.read<CartBloc>().add(
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
    context.snackBarSuccess('Hamper ${h.code} added to cart');
  }

  @override
  Widget build(BuildContext context) {
    final types = hamperTypes(widget.hampers);
    // A type that disappeared after a refresh must not leave an empty list.
    final type = types.contains(_type) ? _type : null;
    final shown = browseHampers(widget.hampers, type: type, sort: _sort);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.tune),
              title: const Text('Build your own hamper'),
              subtitle: const Text('Pick the items you want'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const HamperBuilderPage()),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 4, 0),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (types.isNotEmpty)
                        _FilterChip(
                          label: 'All',
                          selected: type == null,
                          onTap: () => setState(() => _type = null),
                        ),
                      for (final t in types)
                        _FilterChip(
                          label: t,
                          selected: type == t,
                          onTap: () => setState(() => _type = t),
                        ),
                    ],
                  ),
                ),
              ),
              PopupMenuButton<HamperSort>(
                tooltip: 'Sort hampers',
                icon: const Icon(Icons.sort),
                initialValue: _sort,
                onSelected: (s) => setState(() => _sort = s),
                itemBuilder: (_) => [
                  for (final s in HamperSort.values)
                    PopupMenuItem(value: s, child: Text(s.label)),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HamperBloc>().add(LoadHampers());
            },
            child: shown.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 80),
                      Center(child: Text('No hampers of this type.')),
                    ],
                  )
                : GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 120),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 260,
                      mainAxisExtent: 292,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: shown.length,
                    itemBuilder: (context, i) => _HamperCard(
                      hamper: shown[i],
                      favourite: _favourites.contains(shown[i].id),
                      onFavourite: () => _toggleFavourite(shown[i].id),
                      onAdd: () => _add(shown[i]),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _HamperCard extends StatelessWidget {
  const _HamperCard({
    required this.hamper,
    required this.favourite,
    required this.onFavourite,
    required this.onAdd,
  });
  final HamperOffer hamper;
  final bool favourite;
  final VoidCallback onFavourite;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final endsIn = hamperEndsIn(hamper);
    final theme = Theme.of(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.router.push(HamperViewRoute(hamperId: hamper.id)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: .5),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  HamperPicture(imgUrl: hamper.imgUrl, height: 120),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      tooltip: favourite
                          ? 'Remove ${hamper.code} from favourites'
                          : 'Add ${hamper.code} to favourites',
                      constraints:
                          const BoxConstraints(minWidth: 48, minHeight: 48),
                      onPressed: onFavourite,
                      icon: Icon(
                        favourite ? Icons.favorite : Icons.favorite_border,
                        color: favourite ? Colors.red : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                hamper.code,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),
              Text(
                hamperMoney(hamper.price),
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  if (hamper.saving > 0)
                    HamperChip('Save ${hamperMoney(hamper.saving)}',
                        highlight: true),
                  if (endsIn != null) HamperChip(endsIn),
                  if (!hamper.canBuy) const HamperChip('Unavailable'),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: FilledButton(
                  onPressed: hamper.canBuy ? onAdd : null,
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
