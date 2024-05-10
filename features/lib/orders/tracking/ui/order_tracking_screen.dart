import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:either_dart/either.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:features/orders/tracking/bloc/order_tracking_bloc.dart';
import 'package:features/orders/tracking/ui/ord_primary_info.dart';
import 'package:features/orders/tracking/ui/ord_products.dart';
import 'package:features/orders/tracking/ui/track_statuses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:repository/orders/order_repository.dart';

// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();
//   return directory.path;
// }

// Future<File> get _localFile async {
//   final path = await _localPath;
//   return File('$path/counter.txt');
// }

@RoutePage()
class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({
    super.key,
    required this.params,
    required this.privilage,
  });
  final Either<int, Order> params;
  final OrderEditPrivilage privilage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderTrackingBloc(context.read<OrderRepository>())
        ..add(OrderLoaded(params)),
      child: BlocBuilder<OrderTrackingBloc, OrderTrackingState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: params.fold((left) {
                  return Text('Order  #$left');
                }, (right) {
                  return Text('Order  #${right.id}');
                }),
                actions: [
                  IconButton(
                    onPressed: () async {
                      // final doc = pw.Document();

                      // doc.addPage(
                      //   pw.Page(
                      //     pageFormat: PdfPageFormat.a4,
                      //     build: (pw.Context context) {
                      //       return pw.Center(
                      //         child: pw.Text('Hello World'),
                      //       ); // Center
                      //     },
                      //   ),
                      // );

                      // print(doc.document.);
                    },
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
                        TrackStatuses(order: order, previlage: privilage)
                      ],
                    );
                  } else if (state is OrderTrackingInitial) {
                    return const FullScreenLoadingShimmer();
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
