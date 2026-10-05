import 'package:flutter/material.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/pill_tab_bar.dart';
import 'package:ui/src/views/orders/listing/ui/orders_tab.dart';
import 'package:ui/src/views/role_assignments/ui/role_assigned_orders_tab.dart';

/// The "My Economy" bottom tab: the user's own orders, plus the orders
/// they've been given a role on (as a KasiPool receiver/packer or through a
/// KasiPreneur they run).
class MyEconomy extends StatelessWidget {
  const MyEconomy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            50.sH,
            const PillTabBar(tabs: ['MY ORDERS', 'ROLE ASSIGNED ORDERS']),
            const Expanded(
              child: TabBarView(
                children: [
                  OrdersTab(),
                  RoleAssignedOrdersTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
