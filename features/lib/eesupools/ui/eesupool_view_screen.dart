import 'package:auto_route/auto_route.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:data_sources/eesupools/models/eesupool_level.dart';
import 'package:data_sources/eesupools/models/eesupool_member.dart';
import 'package:data_sources/eesupools/models/eesupool_type.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/eesupools/bloc/eesupool_view_bloc.dart';
import 'package:features/eesupools/ui/tabs/chats/ui/chat_tab.dart';
import 'package:features/eesupools/ui/tabs/events/events_tab.dart';
import 'package:features/eesupools/ui/tabs/members/ui/members_tab.dart';
import 'package:features/eesupools/ui/tabs/my_kasi_tree/mykasi_tree.dart';
import 'package:features/eesupools/ui/tabs/orders/presentation/orders_tab.dart';
import 'package:features/eesupools/ui/tabs/settings/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'widgets/eesupool_view_tab_bar.dart';

@RoutePage()
class EESUpoolViewScreen extends StatelessWidget {
  //we take both the poolId and the pool object
  //if we get the id, we can fetch the pool object from the repository
  //if we get the pool object, we can use it directly
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
          return SafeArea(
            child: Scaffold(
              body: Container(
                width: context.width,
                height: context.height,
                decoration: context.bgImage,
                child: () {
                  if (state is CurrentEESUpoolView) {
                    final pool = state.eesupool;
                    final tabs = _getCorrectTabs(pool);
                    return DefaultTabController(
                      length: tabs.length,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                const BackButton(),
                                EESUpoolViewTabBar(
                                  tabs: tabs,
                                  key: const Key('pool_getCorrectTabs'),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: (50).ms).slide(
                                begin: const Offset(0, -1),
                                end: const Offset(0, 0),
                                duration: 600.ms,
                                curve: Curves.easeInOutCubic,
                              ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                ..._getTabBarViews(pool),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
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
      if (type == EESUpoolType.trade) const OrdersPoolTab(),
      const EventsTab(),
      if (type == EESUpoolType.Kasi && level != EESUpoolLevel.Street)
        const MyKasiTreeTab(),
      MembersTab(pool: pool),
      SettingsTab(pool: pool),
    ];
  } else if (!isAdmin && type == EESUpoolType.interestGroup) {
    return [
      ChatsTab(pool: pool),
      const EventsTab(),
      MembersTab(pool: pool),
    ];
  } else {
    return [
      ChatsTab(pool: pool),
      const OrdersPoolTab(),
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
      const Tab(text: 'Chats'),
      if (type == EESUpoolType.trade) const Tab(text: 'Orders'),
      const Tab(text: 'Events'),
      if (type == EESUpoolType.Kasi && level != EESUpoolLevel.Street)
        const Tab(text: 'MyKasi Tree'),
      const Tab(text: 'Members'),
      const Tab(text: 'Settings'),
    ];
  } else if (!isAdmin && type == EESUpoolType.interestGroup) {
    return [
      const Tab(text: 'Chats'),
      const Tab(text: 'Events'),
      const Tab(text: 'Members'),
    ];
  } else {
    return [
      const Tab(text: 'Chats'),
      const Tab(text: 'Orders'),
      const Tab(text: 'Members'),
    ];
  }
}
