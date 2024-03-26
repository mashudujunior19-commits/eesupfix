import 'package:data_sources/eesupools/models/eesupool_type.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/eesupools/ui/eesupool_type_view.dart';
import 'package:features/orders/listing/ui/orders_tab.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class MyEconomyTab extends StatelessWidget {
  const MyEconomyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            _TabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  EESUpoolsTypeView(type: EESUpoolType.trade),
                  OrdersTab(),
                  Center(child: Text('Kasipreneur')),
                  Center(child: Text('Wallets')),
                  Center(child: Text('Crowdfund Wallet & Vouchers')),
                  Center(child: Text('Referrals')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      height: 40,
      color: Colors.white,
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
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: RectangularIndicator(
          bottomLeftRadius: 8,
          bottomRightRadius: 8,
          topLeftRadius: 8,
          topRightRadius: 8,
          color: context.colorScheme.primary,
        ),
        tabs: const [
          Tab(text: 'EESUpools'),
          Tab(text: 'Orders'),
          Tab(text: 'Kasipreneur'),
          Tab(text: 'Wallets'),
          Tab(text: 'Crowdfund Wallet & Vouchers'),
          Tab(text: 'Referrals'),
        ],
      ),
    );
  }
}
