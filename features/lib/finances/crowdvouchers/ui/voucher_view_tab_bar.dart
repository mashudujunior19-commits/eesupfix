import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class VoucherViewTabBar extends StatelessWidget {
  const VoucherViewTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.all(0),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: Colors.white,
        labelStyle: context.textTheme.labelMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelColor: Colors.grey.shade700,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: RectangularIndicator(
          bottomLeftRadius: 8,
          bottomRightRadius: 8,
          topLeftRadius: 8,
          topRightRadius: 8,
          color: context.colorScheme.primary,
        ),
        tabs: const [
          Tab(text: 'Voucher'),
          Tab(text: 'Transactions'),
        ],
      ),
    );
  }
}
