import 'package:auto_route/auto_route.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/features/eesupools/ui/mykasi_tab.dart';
import 'package:ui/src/features/menu/menu_tab.dart';
import 'package:ui/src/features/overview/ui/my_kasi_shop.dart';
import 'package:ui/src/features/overview/ui/widgets/bottom_tab_bar.dart';
import 'package:ui/src/features/overview/ui/overview_tab.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
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
      child: Container(
        decoration: context.bgImage,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomTabBar(tabController: _tabController),
          body: TabBarView(
            controller: _tabController,
            children: const [
              OverviewTab(),
              MyKasiTab(),
              MyKasiShop(),
              MenuTab(),
            ],
          ),
        ),
      ),
    );
  }
}
