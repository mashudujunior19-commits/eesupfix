import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/shopping/models/basket.dart';
import 'package:data/shopping/models/product.dart';
import 'package:ui/eesupools/ui/tabs/chats/ui/widgets/animated_reaction_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

Future<Object?> addProductToBasketDialog(
    BuildContext context, Product prodcut) {
  return showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return _BasketSelectionDialog(product: prodcut);
    },
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.easeIn,
    duration: 400.ms,
  );
}

class _BasketSelectionDialog extends StatelessWidget {
  const _BasketSelectionDialog({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * .09),
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Add to Basket'),
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 300),
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 20,
                ),
                child: Text("Add"),
              ),
              Container(
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
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 13),
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
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 20,
                ),
                child: Text("Which basket?"),
              ),
              // Column(
              //   children: List.generate(
              //     baskets.length,
              //     (index) => _BasketCard(
              //       basket: baskets[index],
              //       productId: product.id,
              //     ).animate().slideIn(index * 50),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BasketCard extends StatelessWidget {
  const _BasketCard({
    required this.basket,
    required this.productId,
  });
  final Basket basket;
  final int productId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        // context.push(BasketViewScreen.route, extra: basket).whenComplete(() {
        //   ref.invalidate(basketsProvider);
        // });
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
            backgroundColor: colorScheme.primary.withOpacity(.1),
            child: Icon(
              BootstrapIcons.basket,
              color: colorScheme.primary,
              size: 20,
            ),
          ),
          title: Text(basket.name),
          subtitle: Text(
            basket.type?.name ?? 'Custom Basket',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
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
