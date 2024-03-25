import 'package:auto_route/auto_route.dart';
import 'package:data_sources/eesupools/models/eesupool_type.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/eesupools/listing/ui/eesupool_type_view.dart';
import 'package:features/menu/menu_tab.dart';
import 'package:features/shop/overview/ui/my_economy_tab.dart';
import 'package:features/shop/overview/ui/widgets/bottom_tab_bar.dart';
import 'package:features/shop/overview/ui/overview_tab.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ShopOverviewScreen extends StatefulWidget {
  const ShopOverviewScreen({super.key});

  @override
  State<ShopOverviewScreen> createState() => _ShopOverviewScreenState();
}

class _ShopOverviewScreenState extends State<ShopOverviewScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: const Key('shop_overview_screen'),
      child: Scaffold(
        bottomNavigationBar: BottomTabBar(tabController: _tabController),
        body: Container(
          decoration: context.bgImage,
          child: TabBarView(
            controller: _tabController,
            children: const [
              OverviewTab(),
              EESUpoolsTypeView(type: EESUpoolType.Kasi),
              MyEconomyTab(),
              MenuTab(),
            ],
          ),
        ),
      ),
    );
  }
}
