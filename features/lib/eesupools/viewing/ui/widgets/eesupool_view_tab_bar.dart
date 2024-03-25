import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class EESUpoolViewTabBar extends StatelessWidget {
  const EESUpoolViewTabBar({super.key, required this.tabs});

  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 55,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 10),
        child: TabBar(
          dividerColor: Colors.transparent,
          indicatorPadding: const EdgeInsets.all(0),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: Colors.white,
          labelStyle: context.textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: RectangularIndicator(
            bottomLeftRadius: 8,
            bottomRightRadius: 8,
            topLeftRadius: 8,
            topRightRadius: 8,
            color: context.colorScheme.primary,
          ),
          tabs: [...tabs],
        ),
      ),
    );
  }
}
