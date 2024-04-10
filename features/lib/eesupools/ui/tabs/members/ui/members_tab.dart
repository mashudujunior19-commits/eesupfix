import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/eesupools/ui/tabs/members/ui/members_invites.dart';
import 'package:features/eesupools/ui/tabs/members/ui/members_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'members_list_view.dart';

class MembersTab extends StatelessWidget {
  const MembersTab({super.key, required this.pool});
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              children: [
                MembersListView(pool: pool),
                MembersInvites(pool: pool),
                MembersRequests(pool: pool),
                MembersListView(pool: pool),
              ],
            ),
          ),
          Container(
            height: 50,
            color: Colors.white,
            width: MediaQuery.sizeOf(context).width,
            child: TabBar(
              labelColor: context.colorScheme.primary,
              unselectedLabelColor: Colors.grey.shade400,
              labelStyle: context.textTheme.displayMedium?.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey.shade100,
              ),
              isScrollable: false,
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(
                height: 3,
                topLeftRadius: 0,
                topRightRadius: 0,
                bottomLeftRadius: 0,
                bottomRightRadius: 0,
                tabPosition: TabPosition.top,
                color: context.colorScheme.primary,
              ),
              tabs: const [
                Tab(
                  icon: Icon(IconlyLight.user3, size: 20),
                  text: 'Members',
                  iconMargin: EdgeInsets.only(bottom: 3),
                ),
                Tab(
                  icon: Icon(IconlyLight.addUser, size: 20),
                  text: 'Invites',
                  iconMargin: EdgeInsets.only(bottom: 3),
                ),
                Tab(
                  icon: Icon(IconlyLight.user2, size: 20),
                  text: 'Requests',
                  iconMargin: EdgeInsets.only(bottom: 3),
                ),
                Tab(
                  text: 'Grievances',
                  icon: Icon(BootstrapIcons.flag, size: 20),
                  iconMargin: EdgeInsets.only(bottom: 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
