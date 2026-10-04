import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/widgets/pill_tab_bar.dart';
import 'package:ui/src/views/eesupools/ui/eesupool_type_view.dart';
import 'package:ui/src/views/referrals/ui/referrals_tab.dart';
import 'package:ui/src/views/referrals/ui/share_referral_button.dart';

/// Groups the user's community-facing features: the KasiPools they belong
/// to and the people they've referred.
@RoutePage()
class MyCommunityScreen extends StatelessWidget {
  const MyCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('My Community'),
          actions: const [ShareReferralButton()],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: context.bgImage,
          child: const Column(
            children: [
              PillTabBar(tabs: ['KASIPOOLS', 'MY REFERRALS']),
              Expanded(
                child: TabBarView(
                  children: [
                    EESUpoolsTypeView(type: EESUpoolType.trade),
                    ReferralsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
