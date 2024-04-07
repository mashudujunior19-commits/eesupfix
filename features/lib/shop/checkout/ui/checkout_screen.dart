import 'package:auto_route/auto_route.dart';
import 'package:data_sources/finance/models/payment_method.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:data_sources/orders/models/order_product.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_alerts_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/navigation/app_route.gr.dart';
import 'package:features/finances/payments/yoco/yoco_payment_screen.dart';
import 'package:features/shop/checkout/bloc/checkout_bloc.dart';
import 'package:features/shop/checkout/ui/steps/address_selection_step.dart';
import 'package:features/shop/checkout/ui/steps/collection_step.dart';
import 'package:features/shop/checkout/ui/steps/payment_method_step.dart';
import 'package:features/shop/checkout/ui/steps/results_step.dart';
import 'package:features/shop/checkout/ui/steps/summary_step.dart';
import 'package:features/shop/checkout/ui/widgets/steps_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:instapay_flutter/data/merchant_transaction.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repository/orders/order_repository.dart';

@RoutePage()
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.products,
    required this.total,
  });
  final double total;
  final List<OrderProduct> products;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(context.read<OrderRepository>())
        ..add(
          CheckoutStarted(widget.total, widget.products),
        ),
      child: BlocListener<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }

          if (state is CheckoutError) {
            context.snackBarError(state.exception.message);
          }

          if (state is OutstandingPayment) {
            final method = state.paymentMethod;

            switch (method) {
              case PaymentMethod.ozow || PaymentMethod.splitOzow:
                context.router.push(
                  OzowRoute(
                    reference: state.response.orderId!,
                    amount: state.response.outstandingAmount,
                    type: "Order",
                    bankRef: "${state.response.orderId} EESUp",
                  ),
                );

              case PaymentMethod.instapay || PaymentMethod.splitInstapay:
                final transaction = _getInstapayTransaction(state.response);
                if (transaction == null) {
                  if (kDebugMode) {
                    print('Insta pay transactions is : $transaction');
                  }
                  return;
                }
                context.router.push(InstapayRoute(transaction: transaction));
              case PaymentMethod.yoco || PaymentMethod.splitYoco:
                context.router.push(
                  YocoPaymentRoute(
                    reference: state.response.orderId!,
                    amount: state.response.outstandingAmount,
                  ),
                );
              //Ignored
              case PaymentMethod.retailWallet:
            }
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  if (index > 0) {
                    _tabController.animateTo(index - 1);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              title: const Text('Checkout'),
            ),
            body: Container(
              height: context.height,
              width: context.width,
              decoration: context.bgImage,
              child: Column(
                children: [
                  StepIndicator(activeStep: index),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        AddressSelectionStep(tabController: _tabController),
                        CollectionStep(tabController: _tabController),
                        PaymentMethodStep(tabController: _tabController),
                        SummaryStep(tabController: _tabController),
                        ResultStep(tabController: _tabController),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  MerchantTransaction? _getInstapayTransaction(OrderResponse response) {
    // var formatter = DateFormat('yyyy-MM-dd');
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
      mTxDueDate: secret,
      mMessage: 'Payment for order ${response.orderId}',
      mSiteName: 'EESUp',
      mReturnUrl: successUrl,
      mBack2shopUrl: failedUrl,
      mNotifyUrl: notifyUrl,
      sendboxUrl: sendbox,
    );
  }
}
