import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/eesupreneur/data_source/eesupreneur_supabase_data_soruce.dart';
import 'package:data/eesupreneur/models/eesupreneur.dart';
import 'package:data/partners/repository/eesupreneur_repository.dart';
import 'package:ui/core/extensions/context_alerts_ext.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/eesupools/ui/tabs/orders/ui/eesupool_order_card.dart';
import 'package:ui/shop/checkout/bloc/checkout_bloc.dart';
import 'package:ui/shop/checkout/bloc/collection_points_bloc.dart';
import 'package:ui/shop/checkout/bloc/open_eesupool_orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CollectionStep extends StatelessWidget {
  const CollectionStep({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EESUpreneurRepository(
        EESUpreneurSupabaseDataSource(GetIt.I.get<SupabaseClient>()),
        context.read<AuthRepository>(),
      ),
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is! CurrentCheckout) {
            return 0.sW;
          }

          final selectedAddress = state.newOrder.address;

          return BlocProvider(
            create: (context) => CollectionPointsBloc(
                context.read<EESUpreneurRepository>(),
                context.read<EESUpoolRepository>())
              ..add(CollectionPointsRequested(selectedAddress)),
            child: BlocConsumer<CollectionPointsBloc, CollectionPointsState>(
              listener: (context, state) {
                if (state is CollectionPointsLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
              },
              builder: (context, state) {
                if (state is CollectionPointsLoaded) {
                  final shops = state.shops;
                  final orders = state.orders;

                  return DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const _TabBar(),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _ShopsTab(
                                shops: shops,
                                tabController: tabController,
                              ),
                              _OrdersTab(
                                orders: orders,
                                tabController: tabController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is CollectionPointsLoading) {
                  return const FullScreenLoadingShimmer();
                } else {
                  return 0.sW;
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class _ShopsTab extends StatelessWidget {
  const _ShopsTab({
    required this.tabController,
    required this.shops,
  });
  final List<EESUpreneur> shops;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      itemBuilder: (context, index) {
        return _KasipreneurCard(
          eesupreneur: shops[index],
          tabController: tabController,
        ).animate().slideIn(index * 50);
      },
      itemCount: shops.length,
    );
  }
}

class _OrdersTab extends StatelessWidget {
  const _OrdersTab({
    required this.orders,
    required this.tabController,
  });
  final List<EESUpoolOrder> orders;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OpenEESUpoolOrdersBloc(context.read<EESUpoolRepository>())
            ..add(OpenOrdersFetched()),
      child: BlocBuilder<OpenEESUpoolOrdersBloc, OpenEesUpoolOrdersState>(
        builder: (context, state) {
          if (state is OpenEESUpoolOrdersLoaded) {
            final orders = state.openOrders;
            if (orders.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return EESUpoolOrderCard(
                    order: order,
                    pool: null,
                    onTap: () {
                      context.read<CheckoutBloc>().add(
                            CollectionPointUpdated(null, order.id, null),
                          );
                      tabController.animateTo(tabController.index + 1);
                    },
                  );
                },
                itemCount: orders.length,
              );
            } else {
              return FullScreenError(
                isError: false,
                exception: EESUpException(
                  message: 'There are no available orders at the moment.',
                ),
              );
            }
          } else if (state is OpenEESUpoolOrdersLoading) {
            return const FullScreenLoadingShimmer();
          } else if (state is OpenEESUpoolOrdersError) {
            return FullScreenError(exception: state.exception);
          } else {
            return FullScreenError(
              exception: EESUpException(
                message: 'Something went wrong while'
                    ' trying to fetch open orders.',
              ),
            );
          }
        },
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 26,
      padding: const EdgeInsets.only(left: 16, right: 16),
      color: Colors.white,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.all(0),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: Colors.white,
        labelStyle: context.textTheme.displayMedium?.copyWith(
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
        tabs: const [
          Tab(text: 'Kasipreneurs'),
          Tab(text: 'EESUpools'),
        ],
      ),
    );
  }
}

class _KasipreneurCard extends StatelessWidget {
  const _KasipreneurCard(
      {required this.eesupreneur, required this.tabController});
  final EESUpreneur eesupreneur;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        final deliveryFee = eesupreneur.deliveryFee ?? 0.00;
        if (deliveryFee > 0) {
          context
              .showAlertDialog(
                  'Delivery',
                  '${eesupreneur.name} Offers'
                      ' delivery for a R${deliveryFee.toStringAsFixed(2)} fee'
                      ' do you wish to have your Order delivered',
                  positiveText: 'Yes',
                  negativeText: 'No, I will collect my order')
              .then((value) {
            if (value == true) {
              context.read<CheckoutBloc>().add(
                    CollectionPointUpdated(eesupreneur.id, null, deliveryFee),
                  );
              tabController.animateTo(tabController.index + 1);
            } else {
              context.read<CheckoutBloc>().add(
                    CollectionPointUpdated(eesupreneur.id, null, null),
                  );
              tabController.animateTo(tabController.index + 1);
            }
          });
        } else {
          context.read<CheckoutBloc>().add(
                CollectionPointUpdated(eesupreneur.id, null, null),
              );
          tabController.animateTo(tabController.index + 1);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
            width: .5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: context.colorScheme.primary.withOpacity(.15),
            child: Image.asset(
              "assets/images/pin.png",
              height: 30,
              color: context.colorScheme.primary,
            ),
          ),
          title: Text(eesupreneur.name, style: context.textTheme.labelMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                eesupreneur.ownerName ?? eesupreneur.name,
                style: context.textTheme.labelSmall?.copyWith(
                    // color: colorScheme.primary,
                    ),
              ),
              2.sH,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Open',
                    style: context.textTheme.labelSmall?.copyWith(
                        // color: colorScheme.primary,
                        ),
                  ),
                  10.sW,
                  Text(
                    '${eesupreneur.distance?.toStringAsFixed(2)} km away',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: const Icon(
            IconlyLight.arrowRight2,
            size: 20,
          ),
        ),
      ),
    );
  }
}
