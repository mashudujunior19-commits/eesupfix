import 'package:auto_route/auto_route.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen(
      {super.key, required this.order, required this.privilage});
  final Order order;
  final OrderEditPrivilage privilage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text('Order  #${order.id}'),
        ),
        body: Container(
          width: context.width,
          height: context.height,
          decoration: context.bgImage,
          child: ListView(
            children: [],
          ),
        ),
      ),
    );
  }
}
