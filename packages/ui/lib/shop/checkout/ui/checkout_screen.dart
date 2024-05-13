import 'package:auto_route/auto_route.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:ui/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/shop/checkout/bloc/checkout_bloc.dart';
import 'package:ui/shop/checkout/ui/steps/address_selection_step.dart';
import 'package:ui/shop/checkout/ui/steps/collection_step.dart';
import 'package:ui/shop/checkout/ui/steps/payment_method_step.dart';
import 'package:ui/shop/checkout/ui/steps/results_step.dart';
import 'package:ui/shop/checkout/ui/steps/summary_step.dart';
import 'package:ui/shop/checkout/ui/widgets/steps_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ..add(CheckoutStarted(widget.products)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                if (index > 0 && index != 4) {
                  _tabController.animateTo(index - 1);
                } else if (index == 4) {
                  Navigator.pop(context, true);
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
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    if (state is! CheckoutCompleted) {
                      return StepIndicator(activeStep: index);
                    }
                    return 0.sW;
                  },
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      AddressSelectionStep(tabController: _tabController),
                      CollectionStep(tabController: _tabController),
                      PaymentMethodStep(tabController: _tabController),
                      SummaryStep(tabController: _tabController),
                      const ResultStep(),
                    ],
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
