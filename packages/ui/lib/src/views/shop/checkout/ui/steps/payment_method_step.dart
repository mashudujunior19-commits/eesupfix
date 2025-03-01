import 'package:data/finance/models/payment_method.dart';
import 'package:data/finance/repository/payment_gateway_repository.dart';
import 'package:data/finance/repository/wallets_repository.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/finances/crowdvouchers/ui/payment_method.dart';
import 'package:ui/src/views/finances/payments/bloc/payment_gatway_bloc.dart';
import 'package:ui/src/views/finances/wallets/bloc/wallets_bloc.dart';
import 'package:ui/src/views/shop/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:data/utils/double_ext.dart';

class PaymentMethodStep extends StatelessWidget {
  const PaymentMethodStep({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WalletsBloc(context.read<WalletsRepository>())
            ..add(WalletsFetched()),
        ),
        BlocProvider(
          create: (context) => PaymentGatwayBloc(
            context.read<PaymentGatewayRepo>(),
          )..add(PaymentGatewaysFetched()),
        ),
      ],
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, checkoutState) {
          double? total;
          if (checkoutState is CurrentCheckout) {
            total = checkoutState.subTotalToPay();
          }

          return BlocListener<WalletsBloc, WalletsState>(
            listener: (context, state) {
              if (state is WalletsLoaded) {
                try {
                  final retailWallet = state.wallets.firstWhere(
                    (e) => e.typeId == "retail",
                  );
                  context.read<CheckoutBloc>().add(
                        WalletIdUpdated(retailWallet.id),
                      );
                } catch (_) {}
              }
            },
            child: BlocBuilder<WalletsBloc, WalletsState>(
              builder: (context, state) {
                if (state is WalletsLoading) {
                  return const FullScreenLoadingShimmer();
                } else if (state is WalletsLoaded) {
                  double balance = 0;

                  try {
                    final retailWallet = state.wallets.firstWhere(
                      (e) => e.typeId == "retail",
                    );

                    balance = retailWallet.balance;
                  } catch (_) {}

                  return BlocBuilder<PaymentGatwayBloc, PaymentGatwayState>(
                    builder: (context, gatewayState) {
                      if (gatewayState is PaymentGatwaysLoaded) {
                        return ListView(
                          padding: const EdgeInsets.only(bottom: 200),
                          children: [
                            PaymentMethodTile(
                              gateway: null,
                              isVisible: true,
                              amount: total ?? 0,
                              title: 'Retail wallet',
                              imagePath: 'assets/images/wallet.png',
                              subtitle: 'Available balance:'
                                  ' R${balance.toRounded()}',
                              onTap: (gateway) {
                                final amount = total ?? 0;

                                if (amount > balance) {
                                  context.snackBarError(
                                    "You do not have enough funds on your Retail Wallet.",
                                  );
                                  return;
                                }

                                context.read<CheckoutBloc>().add(
                                      PaymentMethodUpdated(
                                        PaymentMethod.retailWallet,
                                        null,
                                      ),
                                    );
                                tabController
                                    .animateTo(tabController.index + 1);
                              },
                            ).animate().slideIn(0),
                            PaymentMethodTile(
                              amount: total ?? 0,
                              gateway: gatewayState.gateway(PaymentMethod.yoco),
                              title: 'Yoco',
                              isVisible: gatewayState
                                      .gateway(PaymentMethod.yoco)
                                      ?.isActive ??
                                  false,
                              imagePath: 'assets/images/yoco.png',
                              subtitle:
                                  'Visa, Mastercard, American Express, EFT.',
                              onTap: (gateway) {
                                context.read<CheckoutBloc>().add(
                                      PaymentMethodUpdated(
                                        PaymentMethod.yoco,
                                        gateway,
                                      ),
                                    );
                                tabController
                                    .animateTo(tabController.index + 1);
                              },
                            ).animate().slideIn(50),
                            PaymentMethodTile(
                              gateway: gatewayState.gateway(
                                PaymentMethod.instapay,
                              ),
                              amount: total ?? 0,
                              title: 'Instapay',
                              imagePath: 'assets/images/instapay.png',
                              subtitle:
                                  'Visa, Mastercard, American Express, EFT.',
                              isVisible: gatewayState
                                      .gateway(PaymentMethod.instapay)
                                      ?.isActive ??
                                  false,
                              onTap: (gateway) {
                                context.read<CheckoutBloc>().add(
                                      PaymentMethodUpdated(
                                        PaymentMethod.instapay,
                                        gateway,
                                      ),
                                    );
                                tabController
                                    .animateTo(tabController.index + 1);
                              },
                            ).animate().slideIn(100),
                            PaymentMethodTile(
                              gateway: gatewayState.gateway(PaymentMethod.ozow),
                              title: 'Ozow',
                              amount: total ?? 0,
                              isVisible: gatewayState
                                      .gateway(PaymentMethod.ozow)
                                      ?.isActive ??
                                  false,
                              imagePath: 'assets/images/ozow.png',
                              subtitle:
                                  'EFT with FNB, ABSA, Nedbank, etc. \n**Capitec Pay Not Available**',
                              onTap: (gateway) {
                                context.read<CheckoutBloc>().add(
                                      PaymentMethodUpdated(
                                        PaymentMethod.ozow,
                                        gateway,
                                      ),
                                    );
                                tabController
                                    .animateTo(tabController.index + 1);
                              },
                            ).animate().slideIn(150),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      child:
                                          Divider(color: Colors.grey.shade300)),
                                  10.sW,
                                  const Text('Or'),
                                  10.sW,
                                  Expanded(
                                      child:
                                          Divider(color: Colors.grey.shade300)),
                                ],
                              ),
                            ).animate().slideIn(200),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 15, right: 20, left: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: .5,
                                ),
                              ),
                              child: ExpandedTile(
                                theme: const ExpandedTileThemeData(
                                  headerColor: Colors.transparent,
                                 // headerRadius: 0,
                                  headerPadding: EdgeInsets.only(right: 10),
                                  headerSplashColor: Colors.transparent,
                                  contentBackgroundColor: Colors.transparent,
                                  contentPadding: EdgeInsets.all(0),
                                  //contentRadius: 0,
                                ),
                                controller: ExpandedTileController(
                                  isExpanded: false,
                                ),
                                title: ListTile(
                                  leading: Image.asset('assets/images/bill.png',
                                      width: 40),
                                  title: Text(
                                    'Split Payment',
                                    style:
                                        context.textTheme.labelMedium?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Split payment with your retail wallet',
                                    style: context.textTheme.labelSmall
                                        ?.copyWith(fontSize: 11),
                                  ),
                                ),
                                trailing: const Icon(
                                  IconlyLight.arrowRight2,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PaymentMethodTile(
                                      amount: total ?? 0,
                                      gateway: gatewayState
                                          .gateway(PaymentMethod.yoco),
                                      isVisible: gatewayState
                                              .gateway(PaymentMethod.yoco)
                                              ?.isActive ??
                                          false,
                                      title: 'Split payment with Yoco',
                                      imagePath: 'assets/images/yoco.png',
                                      subtitle:
                                          'Use your retail wallet balance and pay'
                                          ' the remaining amount with Yoco',
                                      onTap: (gateway) {
                                        if (balance <= 0) {
                                          context.snackBarError(
                                            "You do not have enough funds on your Retail Wallet",
                                          );
                                          return;
                                        }

                                        context.read<CheckoutBloc>().add(
                                              PaymentMethodUpdated(
                                                PaymentMethod.splitYoco,
                                                gateway,
                                              ),
                                            );
                                        tabController
                                            .animateTo(tabController.index + 1);
                                      },
                                    ).animate().slideIn(0),
                                    PaymentMethodTile(
                                      amount: total ?? 0,
                                      gateway: gatewayState
                                          .gateway(PaymentMethod.instapay),
                                      isVisible: gatewayState
                                              .gateway(PaymentMethod.instapay)
                                              ?.isActive ??
                                          false,
                                      title: 'Split payment with Instapay',
                                      imagePath: 'assets/images/instapay.png',
                                      subtitle:
                                          'Use your retail wallet balance and pay'
                                          ' the remaining amount with Instapay',
                                      onTap: (gateway) {
                                        if (balance <= 0) {
                                          context.snackBarError(
                                            "You do not have enough funds on your Retail Wallet",
                                          );
                                          return;
                                        }

                                        context.read<CheckoutBloc>().add(
                                              PaymentMethodUpdated(
                                                PaymentMethod.splitInstapay,
                                                gateway,
                                              ),
                                            );
                                        tabController
                                            .animateTo(tabController.index + 1);
                                      },
                                    ).animate().slideIn(20),
                                    PaymentMethodTile(
                                      amount: total ?? 0,
                                      gateway: gatewayState
                                          .gateway(PaymentMethod.ozow),
                                      isVisible: gatewayState
                                              .gateway(PaymentMethod.ozow)
                                              ?.isActive ??
                                          false,
                                      title: 'Split payment with Ozow',
                                      imagePath: 'assets/images/ozow.png',
                                      subtitle:
                                          'Use your retail wallet balance and pay'
                                          ' the remaining amount with Ozow',
                                      onTap: (gateway) {
                                        if (balance <= 0) {
                                          context.snackBarError(
                                            "You do not have enough funds on your Retail Wallet",
                                          );
                                          return;
                                        }

                                        context.read<CheckoutBloc>().add(
                                              PaymentMethodUpdated(
                                                PaymentMethod.splitOzow,
                                                gateway,
                                              ),
                                            );
                                        tabController
                                            .animateTo(tabController.index + 1);
                                      },
                                    ).animate().slideIn(30),
                                    25.sH,
                                  ],
                                ),
                              ),
                            ).animate().slideIn(250),
                          ],
                        );
                      } else {
                        return const FullScreenLoadingShimmer();
                      }
                    },
                  );
                } else {
                  return FullScreenError(
                    exception: EESUpException(
                      message: 'Something went wrong, while'
                          ' loading your wallets balance',
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
