import 'package:auto_route/auto_route.dart';
import 'package:data/shopping/models/category.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.categories});
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 500),
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(category: category)
            .animate()
            .slideIn(10.00 * index);
      },
      itemCount: categories.length,
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        context.router.push(CategoryRoute(category: category));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: .5),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 15, right: 10),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: colorScheme.primary.withOpacity(.1),
            child: category.imageUrl != null
                ? Image.network(category.imageUrl!)
                : Image.asset('assets/images/diet.png',
                    width: 30, color: colorScheme.primary),
          ),
          title: Text(
            category.name,
            style: textTheme.labelMedium,
          ),
          subtitle: Text(
            '${category.products} products',
            style: textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade400,
            ),
          ),
          trailing: Icon(
            IconlyLight.arrowRight2,
            size: 20,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
