import 'package:auto_route/auto_route.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

/// Height reserved for the search bar when it is placed in an app bar's
/// `bottom` slot (bar height plus its vertical margin).
const double kSearchProductsBarHeight = 64;

/// Home-screen search entry. It is a tap target that opens the shop browser,
/// where the actual searching happens.
class SearchProductsButton extends StatelessWidget {
  const SearchProductsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;

    return Semantics(
      button: true,
      label: 'Search for products',
      child: Container(
        height: 48,
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300, width: .8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => context.router.push(const BrowseShopRoute()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Icon(IconlyLight.search, color: primary, size: 21),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search for products',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      IconlyLight.arrowRight2,
                      color: primary,
                      size: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
