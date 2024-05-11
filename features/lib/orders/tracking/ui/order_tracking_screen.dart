import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:either_dart/either.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/widgets/fullscreen_error_widget.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/orders/tracking/bloc/order_tracking_bloc.dart';
import 'package:features/orders/tracking/ui/ord_primary_info.dart';
import 'package:features/orders/tracking/ui/ord_products.dart';
import 'package:features/orders/tracking/ui/track_statuses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/orders/order_repository.dart';

@RoutePage()
class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen(
      {super.key, required this.id, required this.privilage});
  final OrderEditPrivilage privilage;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderTrackingBloc(context.read<OrderRepository>())
        ..add(OrderLoaded(id)),
      child: BlocBuilder<OrderTrackingBloc, OrderTrackingState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: Text('Order  #$id'),
                actions: [
                  IconButton(
                    onPressed: () async {},
                    icon: Icon(
                      BootstrapIcons.printer,
                      color: Colors.grey.shade900,
                      size: 20,
                    ),
                  ),
                  2.sW,
                ],
              ),
              body: Container(
                width: context.width,
                height: context.height,
                decoration: context.bgImage,
                child: () {
                  if (state is CurrentOrderTracking) {
                    final order = state.order;
                    return ListView(
                      padding: const EdgeInsets.only(bottom: 300),
                      children: [
                        OrdPrimaryInfo(order: order),
                        OrdProducts(order: order),
                        TrackStatuses(order: order, privilage: privilage)
                      ],
                    );
                  } else if (state is OrderTrackingInitial) {
                    return const FullScreenLoadingShimmer();
                  } else if (state is CurrentOrderTrackingError) {
                    return FullScreenError(exception: state.error);
                  } else {
                    return 0.sW;
                  }
                }(),
              ),
            ),
          );
        },
      ),
    );
  }
}
