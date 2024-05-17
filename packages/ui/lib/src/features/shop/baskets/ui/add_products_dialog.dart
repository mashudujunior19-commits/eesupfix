import 'package:data/shopping/models/product.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/features/eesupools/ui/tabs/chats/ui/widgets/animated_reaction_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AddBasketProductsDialog extends StatelessWidget {
  AddBasketProductsDialog({super.key, required this.basketId});
  final String basketId;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final products = <Product>[];
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: context.height * .09),
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
            automaticallyImplyLeading: false,
            title: EESUpTextFormField(
              margin: const EdgeInsets.only(bottom: 5, top: 15),
              hintText: 'Search products',
              prefixIcon: const BackButton(),
              controller: controller,
              onChanged: (p0) {},
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.only(bottom: 300),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _ProductCard(
                product: products[index],
                basketId: basketId,
              ).animate().slideIn(index * 50);
            },
          ),
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
            // ref.read(shoppingRepoProvider).addProductToBasket(
            //       basketId,
            //       product.id,
            //     );
          },
        ),
      ),
    );
  }
}
