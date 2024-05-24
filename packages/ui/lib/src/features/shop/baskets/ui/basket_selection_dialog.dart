import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/eesupools/ui/tabs/chats/ui/widgets/animated_reaction_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/features/shop/baskets/bloc/basket_list_bloc.dart';

class BasketSelectionDialog extends StatelessWidget {
  const BasketSelectionDialog({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Add to Basket'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 300),
        children: [
          20.sH,
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text("Add"),
          ),
          20.sH,
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text("Which basket?"),
          ),
          20.sH,
          _ProductPreview(product: product),
          20.sH,
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text("Which basket?"),
          ),
          20.sH,
          BlocProvider(
            create: (context) => BasketListBloc(
              context.read<ShoppingRepository>(),
            )..add(BasketListsFetched()),
            child: BlocBuilder<BasketListBloc, BasketListState>(
              builder: (context, state) {
                if (state is BasketListLoaded) {
                  final baskets = state.baskets;
                  return Column(
                    children: List.generate(
                      baskets.length,
                      (index) => _BasketCard(
                        basket: baskets[index],
                        productId: product.id,
                      ).animate().slideIn(index * 50),
                    ),
                  );
                } else if (state is BasketListLoading) {
                  return const FullScreenLoadingShimmer();
                } else if (state is BasketListError) {
                  return FullScreenError(exception: state.exception);
                } else {
                  return FullScreenError(
                    exception: EESUpException(message: ''),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductPreview extends StatelessWidget {
  const _ProductPreview({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: .5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 5, right: 5),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: product.imageUrl != null
              ? Image.network(product.imageUrl!, width: 27)
              : Image.asset('assets/images/no-photo.png',
                  width: 27, color: Colors.grey),
        ),
        title: Text(
          product.name,
          style:
              Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 13),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.categoryName ?? '',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              '${product.size}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BasketCard extends StatelessWidget {
  const _BasketCard({required this.basket, required this.productId});
  final Basket basket;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(BasketViewRoute(basket: basket)).whenComplete(() {
          context.read<BasketListBloc>().add(BasketListsFetched());
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 21, left: 19, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 10, right: 5),
          leading: CircleAvatar(
            backgroundColor: context.colorScheme.primary.withOpacity(.1),
            child: Icon(
              BootstrapIcons.basket,
              color: context.colorScheme.primary,
              size: 20,
            ),
          ),
          title: Text(basket.name),
          subtitle: Text(
            basket.type?.name ?? 'Custom Basket',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          trailing: AnimatedReactionButton(
            onTap: () {
              // ref
              //     .read(shoppingRepoProvider)
              //     .addProductToBasket(
              //       basket.id,
              //       productId,
              //     )
              //     .then(
              //   (value) {
              //     value.fold((l) {
              //       showSnackBar(context: context, message: l.message);
              //     }, (r) {
              //       if (r) {
              //         showSnackBar(
              //           context: context,
              //           message: 'Added to basket',
              //         );
              //       } else {
              //         showSnackBar(
              //           context: context,
              //           message: 'Failed to add to basket',
              //           type: SnackBarType.error,
              //         );
              //       }
              //     });
              //   },
              // );
            },
            child: const Icon(
              IconlyLight.plus,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
