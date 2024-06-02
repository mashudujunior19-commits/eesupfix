import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/bloc/pool_order_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:ui/src/views/eesupools/ui/tabs/orders/ui/order_products_tab.dart';
import 'member_orders_tab.dart';
import 'order_details_tab.dart';

@RoutePage()
class EESUpoolOrderViewScreen extends StatelessWidget {
  const EESUpoolOrderViewScreen({
    super.key,
    required this.pool,
    required this.order,
  });
  final EESUpool pool;
  final EESUpoolOrder order;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: context.bgImage,
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 42,
                  padding: const EdgeInsets.only(left: 8, right: 10, top: 15),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const BackButton(),
                      Expanded(
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorPadding: const EdgeInsets.all(0),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelColor: Colors.white,
                          labelStyle: context.textTheme.labelMedium?.copyWith(
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
                            color: context.colorScheme.primary,
                          ),
                          tabs: [
                            Tab(child: Icon(MdiIcons.packageVariant, size: 15)),
                            const Tab(text: 'ORDER PRODUCTS'),
                            const Tab(text: 'MEMBER ORDERS')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BlocProvider(
                  create: (context) =>
                      PoolOrderViewBloc(context.read<EESUpoolRepository>())
                        ..add(PoolOrderInitialized(order)),
                  child: BlocBuilder<PoolOrderViewBloc, PoolOrderViewState>(
                    builder: (context, state) {
                      if (state is PoolOrderViewCurrentState) {
                        final orderState = state.pooOrder;
                        return Expanded(
                          child: TabBarView(
                            children: [
                              OrderDetailsTab(order: orderState, pool: pool),
                              OrderProductsTab(id: order.id),
                              MemberOrdersTab(pool: pool, poolOrder: orderState)
                            ],
                          ),
                        );
                      } else if (state is PoolOrderViewLoading) {
                        return const FullScreenLoadingShimmer();
                      } else {
                        return FullScreenError(
                          exception: EESUpException(message: ''),
                          isError: false,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
