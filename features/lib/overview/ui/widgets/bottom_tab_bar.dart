import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.labelMedium;
    int index = tabController.index;
    return Container(
      height: 60,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: Colors.black.withOpacity(.99),
        labelStyle: textTheme?.copyWith(fontSize: 9),
        indicatorColor: Colors.transparent,
        tabs: [
          Tab(
            icon: Icon(
              index == 0 ? BootstrapIcons.house_fill : BootstrapIcons.house,
              size: 22,
            ),
            iconMargin: const EdgeInsets.only(bottom: 3),
            text: 'Home',
          ),
          Tab(
            icon: Icon(
              index == 1 ? BootstrapIcons.people_fill : BootstrapIcons.people,
            ),
            iconMargin: const EdgeInsets.only(bottom: 3),
            text: 'MyKasi',
          ),
          Tab(
            icon: Icon(
              index == 2
                  ? BootstrapIcons.bar_chart_fill
                  : BootstrapIcons.bar_chart,
              size: 22,
            ),
            iconMargin: const EdgeInsets.only(bottom: 3),
            text: 'MyEconomy',
          ),
          Tab(
            icon: Image.asset(
              'assets/images/open-menu.png',
              width: 23,
              color: tabController.index == 3
                  ? theme.colorScheme.primary
                  : Colors.black,
            ),
            iconMargin: const EdgeInsets.only(bottom: 2),
            text: 'Menu',
          ),
        ],
      ),
    );
  }
}
