import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/features/eesupools/ui/eesupool_type_view.dart';
import 'package:ui/src/features/finances/wallets/ui/screens/wallets_tab.dart';
import 'package:ui/src/features/kasipreneur/ui/kasipreneur_tab.dart';
import 'package:ui/src/features/orders/listing/ui/orders_tab.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:ui/src/features/referrals/ui/referrals_tab.dart';

class MyKasiShop extends StatelessWidget {
  const MyKasiShop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            _TabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  EESUpoolsTypeView(type: EESUpoolType.trade),
                  OrdersTab(),
                  KasipreneurTab(),
                  WalletsTab(),
                  //  CrowdfundWalletScreen(),
                  ReferralsTab(),
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
          Tab(text: 'EESUPOOLS'),
          Tab(text: 'ORDERS'),
          Tab(text: 'KASIPRENEUR'),
          Tab(text: 'WALLETS'),
          //  Tab(text: 'CROWDFUND WALLET & VOUCHERS'),
          Tab(text: 'REFERRALS'),
        ],
      ),
    );
  }
}
