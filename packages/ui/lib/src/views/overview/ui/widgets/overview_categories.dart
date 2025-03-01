import 'package:auto_route/auto_route.dart';
import 'package:data/shopping/models/category.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:flutter/material.dart';

class OverviewCategories extends StatelessWidget {
  const OverviewCategories({super.key, required this.categories});
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...categories.map(
              (e) => InkWell(
                onTap: () {
                  context.router.push(CategoryRoute(category: e));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  padding: const EdgeInsets.only(
                    left: 7,
                    right: 7,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withOpacity(.95),
                    borderRadius: BorderRadius.circular(6.5),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    e.name,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}