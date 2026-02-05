import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/views/eesupools/bloc/eesupool_view_bloc.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/chat_tab.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/ui/members_tab.dart';
import 'package:ui/src/views/eesupools/ui/tabs/my_kasi_tree/ui/mykasi_tree.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/orders_tab.dart';
import 'package:ui/src/views/eesupools/ui/tabs/settings/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'widgets/eesupool_view_tab_bar.dart';

@RoutePage()
class EESUpoolViewScreen extends StatelessWidget {
  const EESUpoolViewScreen({super.key, this.poolId, this.pool});
  final int? poolId;
  final EESUpool? pool;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EESUpoolViewBloc(context.read<EESUpoolRepository>())
        ..add(EESUpoolViewLoaded(id: poolId, eesupool: pool)),
      child: BlocConsumer<EESUpoolViewBloc, EESUpoolViewState>(
        listener: (context, state) {
          if (state is EESUpoolViewLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          return SizedBox(
            child: Scaffold(
              body: Container(
                width: context.width,
                height: context.height,
                decoration: context.bgImage,
                child: () {
                  if (state is CurrentEESUpoolView) {
                    final pool = state.eesupool;
                    final tabs = _getCorrectTabs(pool);
                    final tabViews = _getTabBarViews(pool);
                    return DefaultTabController(
                      length: tabs.length,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                const BackButton(),
                                EESUpoolViewTabBar(tabs: tabs),
                              ],
                            ),
                          ).animate().fadeIn(),
                          Expanded(child: TabBarView(children: tabViews))
                        ],
                      ),
                    );
                  }
                  return Container(); // Return an empty container if state is not CurrentEESUpoolView
                }(),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Widget> _getTabBarViews(EESUpool pool) {
  final isAdmin = pool.role == EESUpoolMemberRole.admin;
  final type = pool.type;
  final level = pool.level;

  if (isAdmin) {
    return [
      ChatsTab(pool: pool),
      if (type == EESUpoolType.trade) OrdersPoolTab(pool: pool),
      if (type == EESUpoolType.kasi && level != EESUpoolLevel.Street)
        MyKasiTreeTab(pool: pool),
      MembersTab(pool: pool),
      SettingsTab(pool: pool),
    ];
  } else if (!isAdmin && type == EESUpoolType.interestGroup) {
    return [
      ChatsTab(pool: pool),
      MembersTab(pool: pool),
    ];
  } else {
    return [
      ChatsTab(pool: pool),
      OrdersPoolTab(pool: pool),
      MembersTab(pool: pool),
    ];
  }
}

List<Tab> _getCorrectTabs(EESUpool pool) {
  final isAdmin = pool.role == EESUpoolMemberRole.admin;
  final type = pool.type;
  final level = pool.level;

  if (isAdmin) {
    return [
      const Tab(text: 'CHATS'),
      if (type == EESUpoolType.trade) const Tab(text: 'ORDERS'),
      if (type == EESUpoolType.kasi && level != EESUpoolLevel.Street)
        const Tab(text: 'MYKASI TREE'),
      const Tab(text: 'MEMBERS'),
      const Tab(text: 'SETTINGS'),
    ];
  } else if (!isAdmin && type == EESUpoolType.interestGroup) {
    return [
      const Tab(text: 'CHATS'),
      const Tab(text: 'MEMBERS'),
    ];
  } else {
    return [
      const Tab(text: 'CHATS'),
      const Tab(text: 'ORDERS'),
      const Tab(text: 'MEMBERS'),
    ];
  }
}
