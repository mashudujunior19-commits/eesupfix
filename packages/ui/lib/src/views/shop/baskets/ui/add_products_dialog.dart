import 'package:data/shopping/models/product.dart';
import 'package:data/shopping/repository/basket_repository.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/widgets/animated_reaction_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/views/shop/baskets/cubit/search_products_cubit.dart';

class AddBasketProductsDialog extends StatelessWidget {
  AddBasketProductsDialog({super.key, required this.basketId});
  final String basketId;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchProductsCubit(context.read<ShoppingRepository>()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Builder(builder: (context) {
            return EESUpTextFormField(
              margin: const EdgeInsets.only(bottom: 5, top: 15),
              hintText: 'Search products',
              prefixIcon: const BackButton(),
              controller: controller,
              onChanged: (p0) {
                EasyDebounce.debounce(
                  'basket_products_search',
                  const Duration(milliseconds: 500),
                  () => context.read<SearchProductsCubit>().search(p0),
                );
              },
            );
          }),
        ),
        body: BlocBuilder<SearchProductsCubit, List<Product>>(
          builder: (context, products) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 300),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _ProductCard(
                  product: products[index],
                  basketId: basketId,
                ).animate().slideIn(index * 50);
              },
            );
          },
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.basketId});
  final Product product;
  final String basketId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: .5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 5),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: product.imageUrl != null
              ? Image.network(product.imageUrl!, width: 27)
              : Image.asset('assets/images/no-photo.png',
                  width: 27, color: Colors.grey),
        ),
        title: Text(
          product.name,
          style: theme.textTheme.labelMedium?.copyWith(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.categoryName ?? '',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
              ),
            ),
            Text(
              '${product.size}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.grey.shade500,
                fontSize: 11.5,
              ),
            ),
          ],
        ),
        trailing: AnimatedReactionButton(
          child: const Icon(IconlyLight.plus),
          onTap: () {
            final repo = context.read<ShoppingRepository>();
            repo.addProductToBasket(basketId, product.id).whenComplete(() {
              context.snackBarSuccess('Item added to basket.');
            });
          },
        ),
      ),
    );
  }
}
