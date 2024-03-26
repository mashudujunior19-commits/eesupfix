import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/shopping/models/basket.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/shop/baskets/listing/ui/create_basket_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

// final basketsProvider = FutureProvider<List<Basket>>((ref) async {
//   final repo = ref.read(shoppingRepoProvider);
//   final result = await repo.fetchUserBaskets();
//   return result.fold((l) {
//     throw l;
//   }, (r) => r);
// });

class BasketsScreen extends StatelessWidget {
  const BasketsScreen({super.key});
  static const route = '/baskets-screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('My Baskets'),
          actions: [
            IconButton(
              onPressed: () {
                createBasketDialog(context).whenComplete(() {
                  // ref.invalidate(basketsProvider);
                });
              },
              icon: const Icon(IconlyLight.plus),
            ),
            10.sW,
          ],
        ),
        // body: Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   decoration: context.bgImage,
        //   child: ListView.builder(
        //     padding: const EdgeInsets.only(bottom: 300),
        //     itemCount: baskets.length,
        //     itemBuilder: (context, index) {
        //       final basket = baskets[index];
        //       return _BasketCard(basket: basket).animate().slideIn(index * 50);
        //     },
        //   ),
        // ),
      ),
    );
  }
}

class _BasketCard extends StatelessWidget {
  const _BasketCard({required this.basket});
  final Basket basket;

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
        margin: const EdgeInsets.only(right: 21, left: 19, top: 15),
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
          trailing: const Icon(
            IconlyLight.arrowRight2,
            size: 18,
          ),
        ),
      ),
    );
  }
}
