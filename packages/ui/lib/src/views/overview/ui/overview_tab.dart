import 'package:auto_route/auto_route.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:data/shopping/repository/shopping_repository.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/env/app_type.dart';
import 'package:ui/src/core/extensions/context_environment_ext.dart';
import 'package:ui/src/views/notifications/ui/notification_button.dart';
import 'package:ui/src/views/referrals/ui/referral_code_tile.dart';
import 'package:ui/src/views/shop/cart/ui/cart_button.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/overview/bloc/overview_bloc.dart';
import 'package:ui/src/views/overview/ui/widgets/hori_products_slider.dart';
import 'package:ui/src/views/overview/ui/widgets/search_products_button.dart';
import 'package:ui/src/views/overview/ui/widgets/overview_banner_carousel.dart';
import 'package:ui/src/views/overview/ui/widgets/overview_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewBloc(context.read<ShoppingRepository>())
        ..add(
          OvervewLoaded(role: UserRole.Ubuntunist, limit: 20),
        ),
      child: BlocBuilder<OverviewBloc, OverviewState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: const NotificationButton(),
                title: Image(
                  width: context.environment.app == AppType.eesup ? 80 : 45,
                  image: const AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
                actions: const [CartButton()],
                flexibleSpace: const SearchProductsButton(),
              ),
              if (state is OverviewLoading)
                const _OverviewShimmer(key: Key('overview_shimmer'))
              else if (state is OverviewContentsLoaded)
                _OverviewItems(key: const Key('overview_items'), state: state)
              else if (state is OverviewError)
                SliverFillRemaining(
                  child: FullScreenError(exception: state.exception),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _OverviewShimmer extends StatelessWidget {
  const _OverviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(.5),
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: context.width,
              height: 20,
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(.5),
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: context.width * .8,
              height: 20,
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(.5),
            highlightColor: Colors.grey.shade100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (var i = 0; i < 3; i++)
                    Container(
                      width: 100,
                      height: 20,
                      margin:
                          const EdgeInsets.only(top: 10, left: 15, right: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    )
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                for (var i = 0; i < 3; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300.withOpacity(.5),
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 100,
                      height: 200,
                      margin: const EdgeInsets.only(
                        top: 15,
                        left: 5,
                        right: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewItems extends StatelessWidget {
  const _OverviewItems({super.key, required this.state});
  final OverviewContentsLoaded state;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          OverviewCategories(categories: state.categories),
          OverviewBannerCarousel(
            interval: 5.seconds,
            banners: state.topBanner,
            onBannerTap: (url) {
              context.router.push(HamperImageViewRoute(imageUrl: url));
            },
          ),
          const ReferalCodeTile(),
          HoriProductSlider(label: '❤ For you', products: state.forYouProducts),
          10.sH,
          OverviewBannerCarousel(
            interval: 10.seconds,
            banners: state.bottomBanner,
            onBannerTap: (url) {
              context.router.push(HamperImageViewRoute(imageUrl: url));
            },
          ),
          HoriProductSlider(
              label: '📊  Popular', products: state.popularProducts),
          150.sH,
        ],
      ),
    );
  }
}
