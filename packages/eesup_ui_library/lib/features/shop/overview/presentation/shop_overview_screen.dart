import 'package:auto_route/auto_route.dart';
import 'package:eesup_data_source/eesupools/models/eesupool_type.dart';
import 'package:eesup_ui_library/core/extensions/bg_image_deco_ext.dart';
import 'package:eesup_ui_library/features/eesupools/widgets/eesupool_type_view.dart';
import 'package:eesup_ui_library/features/shop/overview/presentation/my_economy_tab.dart';
import 'package:eesup_ui_library/features/shop/overview/presentation/widgets/bottom_tab_bar.dart';
import 'package:eesup_ui_library/features/shop/overview/presentation/widgets/overview_tab.dart';
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
              Center(
                child: Text('Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
