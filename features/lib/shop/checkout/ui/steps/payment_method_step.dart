import 'package:data_sources/finance/models/payment_method.dart';
import 'package:features/core/errors/large_error_widget.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/large_loading_shimmer.dart';
import 'package:features/finances/crowdvouchers/ui/payment_method.dart';
import 'package:features/finances/wallets/bloc/wallets_bloc.dart';
import 'package:features/shop/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/finances/wallets_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

class PaymentMethodStep extends StatelessWidget {
  const PaymentMethodStep({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WalletsBloc(context.read<WalletsRepository>())..add(WalletsFetched()),
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, checkoutState) {
          double? total;
          if (checkoutState is CurrentCheckout) {
            total = checkoutState.totalToPay();
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
                  return const LargeLoadingShimmer();
                } else if (state is WalletsLoaded) {
                  double balance = 0;

                  try {
                    final retailWallet = state.wallets.firstWhere(
                      (e) => e.typeId == "retail",
                    );

                    balance = retailWallet.balance;
                  } catch (_) {}

                  return ListView(
                    children: [
                      PaymentMethodTile(
                        title: 'Retail wallet',
                        imagePath: 'assets/images/wallet.png',
                        subtitle: 'Available balance:'
                            ' R${balance.toStringAsFixed(2)}',
                        onTap: () {
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
                                ),
                              );
                          tabController.animateTo(tabController.index + 1);
                        },
                      ).animate().slideIn(0),
                      PaymentMethodTile(
                        title: 'Yoco',
                        imagePath: 'assets/images/yoco.png',
                        subtitle: 'Visa, Mastercard, American Express, EFT.',
                        onTap: () {
                          context.read<CheckoutBloc>().add(
                                PaymentMethodUpdated(
                                  PaymentMethod.instapay,
                                ),
                              );
                          tabController.animateTo(tabController.index + 1);
                        },
                      ).animate().slideIn(50),
                      PaymentMethodTile(
                        title: 'Ozow',
                        imagePath: 'assets/images/ozow.png',
                        subtitle: 'EFT with FNB, ABSA, Nedbank, etc.',
                        onTap: () {
                          context.read<CheckoutBloc>().add(
                                PaymentMethodUpdated(PaymentMethod.ozow),
                              );
                          tabController.animateTo(tabController.index + 1);
                        },
                      ).animate().slideIn(100),
                      PaymentMethodTile(
                        title: 'Instapay',
                        imagePath: 'assets/images/instapay.png',
                        subtitle: 'Visa, Mastercard, American Express, EFT.',
                        onTap: () {
                          context.read<CheckoutBloc>().add(
                                PaymentMethodUpdated(
                                  PaymentMethod.instapay,
                                ),
                              );
                          tabController.animateTo(tabController.index + 1);
                        },
                      ).animate().slideIn(150),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 15),
                        child: Row(
                          children: [
                            Expanded(
                                child: Divider(color: Colors.grey.shade300)),
                            10.sW,
                            const Text('Or'),
                            10.sW,
                            Expanded(
                                child: Divider(color: Colors.grey.shade300)),
                          ],
                        ),
                      ).animate().slideIn(200),
                      PaymentMethodTile(
                        title: 'Split payment with Instapay',
                        imagePath: 'assets/images/bill_2.png',
                        subtitle: 'Use your retail wallet balance and pay'
                            ' the remaining amount with Instapay',
                        onTap: () {
                          if (balance > 0) {
                            context.snackBarError(
                              "You do not have enough funds on your Retail Wallet",
                            );
                            return;
                          }

                          context.read<CheckoutBloc>().add(
                                PaymentMethodUpdated(
                                  PaymentMethod
                                      .splitInstapayRetailWalletPayment,
                                ),
                              );
                          tabController.animateTo(tabController.index + 1);
                        },
                      ).animate().slideIn(220),
                      PaymentMethodTile(
                        title: 'Split payment with Ozow',
                        imagePath: 'assets/images/bill.png',
                        subtitle: 'Use your retail wallet balance and pay'
                            ' the remaining amount with Ozow',
                        onTap: () {
                          if (balance > 0) {
                            context.snackBarError(
                              "You do not have enough funds on your Retail Wallet",
                            );
                            return;
                          }

                          context.read<CheckoutBloc>().add(
                                PaymentMethodUpdated(
                                  PaymentMethod.splitOzowRetailWalletPayment,
                                ),
                              );
                          tabController.animateTo(tabController.index + 1);
                        },
                      ).animate().slideIn(300),
                    ],
                  );
                } else {
                  return LargeErrorWidget(
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
