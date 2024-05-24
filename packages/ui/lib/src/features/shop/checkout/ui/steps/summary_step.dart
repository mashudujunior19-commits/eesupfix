import 'package:auto_route/auto_route.dart';
import 'package:data/finance/models/payment_method.dart';
import 'package:data/orders/models/order.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/app_route.gr.dart';

import 'package:ui/src/features/shop/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instapay_flutter/data/merchant_transaction.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (BuildContext context, CheckoutState state) {
      if (state is CheckoutLoading) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }

      if (state is CheckoutError) {
        context.snackBarError(state.exception.message);
        _restartCheckout(state.order, context);
      }

      if (state is CheckoutCompleted) {
        tabController.animateTo(tabController.index++);
      }

      if (state is OutstandingPayment) {
        final method = state.paymentMethod;

        switch (method) {
          case PaymentMethod.ozow || PaymentMethod.splitOzow:
            context.router
                .push(OzowRoute(
              reference: state.response.orderId!,
              amount: state.response.outstandingAmount,
              type: "Order",
              bankRef: "${state.response.orderId} EESUp",
            ))
                .then((value) {
              if (value == true) {
                context.read<CheckoutBloc>().add(
                      CheckoutFinished(state.order.id, true),
                    );
              } else if (value == false) {
                context.read<CheckoutBloc>().add(
                      CheckoutFinished(state.order.id, false),
                    );
              }
              tabController.animateTo(tabController.index + 1);
            });

          case PaymentMethod.instapay || PaymentMethod.splitInstapay:
            final transaction = _getInstapayTransaction(state.response);
            if (transaction == null) {
              return;
            }
            context.router
                .push(InstapayConfirmDetailsRoute(transaction: transaction))
                .then((value) {
              if (value == true) {
                context.read<CheckoutBloc>().add(
                      CheckoutFinished(state.order.id, true),
                    );
              } else if (value == false) {
                context.read<CheckoutBloc>().add(
                      CheckoutFinished(state.order.id, false),
                    );
              }
              tabController.animateTo(tabController.index + 1);
            });

          case PaymentMethod.yoco || PaymentMethod.splitYoco:
            context.router
                .push(
              YocoPaymentRoute(
                reference: state.response.orderId!,
                amount: state.response.outstandingAmount,
              ),
            )
                .then((value) {
              if (value == false) {
                _restartCheckout(state.order, context);
              } else {
                Navigator.of(context).pop(true);
              }
            });
          //Ignored
          case PaymentMethod.retailWallet:
        }
      }
    }, builder: (context, state) {
      Order? newOrder;
      double? total;

      if (state is CurrentCheckout) {
        newOrder = state.newOrder;
        total = state.totalToPay();
        // totalProfit = state.profit();
      }
      return ListView(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const Text('Order Summary'),
                20.sH,
                _LineTile(
                  label: 'Payment method',
                  value: newOrder?.paymentMethod.toString() ?? "No selected",
                ),
                // _LineTile(
                //   label: 'Discount',
                //   value: 'R${discount.toStringAsFixed(2)}',
                // ),
                _LineTile(
                  label: 'Subtotal',
                  value: 'R${newOrder?.value.toStringAsFixed(2) ?? '0.00'}',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LineTile(
                      label: 'Card fee',
                      isVisible: newOrder?.cardFee != null,
                      value:
                          'R${newOrder?.cardFee?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                    if (newOrder?.paymentMethod != PaymentMethod.retailWallet)
                      GestureDetector(
                        onTap: () {
                          final value =
                              !(newOrder?.payFeesWithRetailWallet ?? false);
                          context
                              .read<CheckoutBloc>()
                              .add(PayFeesWithWalletUpdated(value));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '**Tap to Pay the fee with you Retail wallet',
                                  style: context.textTheme.labelSmall?.copyWith(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              Checkbox(
                                value:
                                    newOrder?.payFeesWithRetailWallet ?? false,
                                onChanged: (value) {
                                  context.read<CheckoutBloc>().add(
                                        PayFeesWithWalletUpdated(
                                            value ?? false),
                                      );
                                },
                                visualDensity: VisualDensity.compact,
                              ),
                            ],
                          ),
                        ),
                      ),
                    15.sH,
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                _LineTile(
                  label: 'Delivery fee',
                  value:
                      "R${newOrder?.deliveryFee?.toStringAsFixed(2) ?? 0.00}",
                ),
                _LineTile(
                  label: 'Total',
                  value: "R${total?.toStringAsFixed(2) ?? 0.00}",
                  isBold: true,
                ),
              ],
            ),
          ),
          Image.asset("assets/images/receipt_bottom.png"),
          30.sH,
          ElevatedButton(
            onPressed: () {
              context.read<CheckoutBloc>().add(OrderPlaced());
            },
            child: const Text("Place order"),
          )
        ],
      );
    });
  }

  void _restartCheckout(Order order, BuildContext context) {
    context.read<CheckoutBloc>().add(
          CheckoutStarted(
            order.products,
          ),
        );
    tabController.animateTo(0);
  }

  MerchantTransaction? _getInstapayTransaction(OrderResponse response) {
    var formatter = DateFormat('yyyy-MM-dd');
    final merchantId = dotenv.env['INSTA_PAY_MERCHANT_ID'];
    final accountUUid = dotenv.env['INSTA_PAY_ACCOUNT_ID'];
    final authKey = dotenv.env['INSTAPAY_AUTH_KEY'];

    final secret = dotenv.env['INSTA_PAY_SECRET'];
    final sendbox = dotenv.env['INSTAPAY_SENDBOX'];
    final successUrl = dotenv.env['INSAPAY_SUCCESS_URL'];
    final failedUrl = dotenv.env['INSAPAY_FAILED_URL'];
    final notifyUrl = dotenv.env['INSAPAY_NOTIFY_URL'];

    if (merchantId == null ||
        accountUUid == null ||
        authKey == null ||
        secret == null ||
        sendbox == null ||
        successUrl == null ||
        failedUrl == null ||
        notifyUrl == null) {
      return null;
    }

    return MerchantTransaction(
      mUuid: merchantId,
      mAccountUuid: accountUUid,
      mTxOrderNr: response.secondaryId!,
      mTxId: response.paymentId!,
      mTxCurrency: 'ZAR',
      mCategory1: response.orderId.toString(),
      mCategory2: 'Order',
      mCategory3: authKey,
      mTxAmount: response.outstandingAmount.toStringAsFixed(2),
      mTxItemName: 'Order ${response.orderId}',
      mTxItemDescription: 'Order ${response.orderId}',
      secret: secret,
      mEftAllowed: true,
      mCardAllowed: true,
      mPassAllowed: false,
      mChipsAllowed: false,
      mPayatAllowed: false,
      mTridentAllowed: false,
      mTxDueDate: formatter.format(DateTime.now()),
      mMessage: 'Payment for order ${response.orderId}',
      mSiteName: 'EESUp',
      mReturnUrl: successUrl,
      mBack2shopUrl: failedUrl,
      mNotifyUrl: notifyUrl,
      sendboxUrl: sendbox,
    );
  }
}

class _LineTile extends StatelessWidget {
  const _LineTile({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isVisible = true,
  });
  final String label;
  final String value;
  final bool isBold;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return 0.sW;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 13,
                  fontWeight: isBold ? FontWeight.bold : null,
                ),
              ),
              Text(
                value,
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 13,
                  fontWeight: isBold ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
          const Divider(height: 30, thickness: .35),
        ],
      ),
    );
  }
}
