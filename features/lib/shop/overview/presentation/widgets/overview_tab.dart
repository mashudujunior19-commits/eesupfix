import 'package:auto_route/auto_route.dart';
import 'package:data_sources/auth/models/user_role.dart';
import 'package:features/core/env/app_type.dart';
import 'package:features/core/extensions/context_environment_ext.dart';
import 'package:repository/shop/shopping_repository.dart';
import 'package:features/core/errors/large_error_widget.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/referrals/presentation/widgets/referral_code_tile.dart';
import 'package:features/shop/overview/bloc/overview_bloc.dart';
import 'package:features/shop/overview/presentation/widgets/hori_products_slider.dart';
import 'package:features/shop/overview/presentation/widgets/mock_search_button.dart';
import 'package:features/shop/overview/presentation/widgets/overview_banner_carousel.dart';
import 'package:features/shop/overview/presentation/widgets/overview_categories.dart';
import 'package:features/core/navigation/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instapay_flutter/data/merchant_transaction.dart';
import 'package:intl/intl.dart';
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
                // leading: NotificationButton(),
                title: Image(
                  width: context.environment.app == AppType.eesup ? 80 : 45,
                  image: const AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      var now = DateTime.now();
                      var formatter = DateFormat('yyyy-MM-dd');
                      String formattedDate = formatter.format(now);
                      context.router.push(
                        InstapayRoute(
                          transaction: MerchantTransaction(
                            mUuid: dotenv.env['INSTA_PAY_MERCHANT_ID']!,
                            mAccountUuid: dotenv.env['INSTA_PAY_ACCOUNT_ID']!,
                            mTxOrderNr: 'EES12345678967432134',
                            mTxId: '9370832a-ce36-43d6-83f3-e14d611bc2de',
                            mTxCurrency: 'ZAR',
                            mCategory1: '1234455',
                            mCategory2: 'Order',
                            mCategory3:
                                'eesup_iyxjp1tlR2rClGJZUK6B0ZqBs8CR9hjqrJM3PrABKQEqKz3MbBrLWTo2v8XmCmB9xfYa436PkZI9MpDBmkOXTEDLmLuLfxXKbyQQblUugiidzVWrWuZaMi3nXu7a',
                            mTxAmount: 560.toStringAsFixed(2),
                            mTxItemName: 'Basket Items',
                            mTxItemDescription: 'The item(s) being ordered',
                            secret: dotenv.env['INSTA_PAY_SECRET']!,
                            mEftAllowed: true,
                            mCardAllowed: true,
                            mPassAllowed: true,
                            mChipsAllowed: true,
                            mPayatAllowed: true,
                            mTridentAllowed: true,
                            mTxDueDate: formattedDate,
                            mMessage: 'This is a test message',
                            mSiteName: 'EESUp',
                            bName: 'Joe',
                            bSurname: 'Soap',
                            bEmail: 'misomenze6@gmail.com',
                            bMobile: '+2719582572',
                            mReturnUrl:
                                'https://zngp5d89-8080.inc1.devtunnels.ms/v1/payments/insta_pay',
                            mNotifyUrl:
                                'https://zngp5d89-8080.inc1.devtunnels.ms/v1/payments/insta_pay',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.payment),
                  )

                  //CartButton(margin: EdgeInsets.only(right: 16, bottom: 5)),
                ],
                flexibleSpace: MockSearchButton(),
              ),
              if (state is OverviewLoading)
                const _OverviewShimmer(key: Key('overview_shimmer'))
              else if (state is OverviewContentsLoaded)
                _OverviewItems(key: const Key('overview_items'), state: state)
              else if (state is OverviewError)
                SliverFillRemaining(
                  child: LargeErrorWidget(exception: state.exception),
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
          OverviewBannerCarousel(interval: 5.seconds, banners: state.topBanner),
          const ReferalCodeTile(),
          HoriProductSlider(label: '❤ For you', products: state.forYouProducts),
          10.sH,
          OverviewBannerCarousel(
              interval: 10.seconds, banners: state.bottomBanner),
          HoriProductSlider(
              label: '📊  Popular', products: state.popularProducts),
          150.sH,
        ],
      ),
    );
  }
}
