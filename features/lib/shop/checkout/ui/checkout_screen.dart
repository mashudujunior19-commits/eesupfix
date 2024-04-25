import 'package:auto_route/auto_route.dart';
import 'package:data_sources/orders/models/order_product.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/shop/checkout/bloc/checkout_bloc.dart';
import 'package:features/shop/checkout/ui/steps/address_selection_step.dart';
import 'package:features/shop/checkout/ui/steps/collection_step.dart';
import 'package:features/shop/checkout/ui/steps/payment_method_step.dart';
import 'package:features/shop/checkout/ui/steps/results_step.dart';
import 'package:features/shop/checkout/ui/steps/summary_step.dart';
import 'package:features/shop/checkout/ui/widgets/steps_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        ..add(CheckoutStarted(widget.products)),
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
                      ResultStep(),
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
