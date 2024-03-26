import 'package:auto_route/auto_route.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';


@RoutePage()
class KasipreneurViewScreen extends StatelessWidget {
  const KasipreneurViewScreen({super.key});
  static const route = '/eesupreneur-view-screen';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Container(
            decoration: context.bgImage,
            child: Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 5, right: 16),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const BackButton(),
                      15.sW,
                      SizedBox(
                        height: 26,
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorPadding: const EdgeInsets.all(0),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelColor: Colors.white,
                          labelStyle: textTheme.displayMedium?.copyWith(
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
                            color: theme.colorScheme.primary,
                          ),
                          tabs: const [
                            Tab(text: 'Orders'),
                            // Tab(text: 'People'),
                            Tab(text: 'Settings'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const Expanded(
                //   child: TabBarView(
                //     children: [
                //       EESUpreneurOrdersTab(),
                
                //       EESUpreneurSettings(),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
