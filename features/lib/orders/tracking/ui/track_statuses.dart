import 'package:auto_route/auto_route.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:features/app_route.gr.dart';
import 'package:features/core/extensions/bottom_sheet_context_ext.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/orders/tracking/bloc/order_tracking_bloc.dart';
import 'package:features/orders/tracking/ui/confirm_order_collection.dart';
import 'package:features/orders/tracking/ui/order_secret_pin_dialog.dart';
import 'package:features/orders/tracking/ui/status_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TrackStatuses extends StatelessWidget {
  const TrackStatuses({
    super.key,
    required this.order,
    required this.privilage,
  });
  final Order order;
  final OrderEditPrivilage privilage;

  bool hasPrevilage(OrderEditPrivilage p) {
    if (privilage == OrderEditPrivilage.all) {
      return true;
    }
    if (privilage == p) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blueGrey.shade100,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.track_changes,
                size: 14,
                color: context.colorScheme.primary,
              ),
              5.sW,
              Text('Track', style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
          StatusTile(
            status: OrderStatus.placed,
            date: order.placedAt,
            onChanged: (status) {},
            label: 'Order Placed',
            icon: Icons.done,
            isVisible: order.cancelledAt == null,
          ),
          StatusTile(
            status: OrderStatus.packaged,
            date: order.packagedAt,
            onChanged: (status) {
              if (hasPrevilage(OrderEditPrivilage.packer)) {
                if (order.status == OrderStatus.placed) {
                  context.router
                      .push(ReviewProductsRoute(
                          order: order, privilage: privilage))
                      .then((value) {
                    if (value == true) {
                      context.read<OrderTrackingBloc>().add(
                            OrderStatusUpdated(
                              order.copyWith(
                                status: OrderStatus.packaged,
                                packagedAt: DateTime.now(),
                              ),
                            ),
                          );
                    }
                  });
                } else {
                  context.read<OrderTrackingBloc>().add(
                        OrderStatusUpdated(
                          order.copyWith(
                            status: OrderStatus.placed,
                            packagedAt: null,
                          ),
                        ),
                      );
                }
              }
            },
            label: () {
              if (privilage != OrderEditPrivilage.owner &&
                  order.status == OrderStatus.placed) {
                return 'Tap to pack';
              } else {
                return 'Packaged';
              }
            }(),
            icon: MdiIcons.packageVariantPlus,
            isVisible: order.cancelledAt == null,
            canEdit: order.placedAt != null &&
                order.readyAt == null &&
                hasPrevilage(OrderEditPrivilage.packer),
          ),
          StatusTile(
            status: OrderStatus.ready,
            date: order.readyAt,
            onChanged: (status) {
              if (hasPrevilage(OrderEditPrivilage.collector)) {
                if (order.status == OrderStatus.packaged) {
                  context.read<OrderTrackingBloc>().add(
                        OrderStatusUpdated(
                          order.copyWith(
                            status: OrderStatus.ready,
                            readyAt: DateTime.now(),
                          ),
                        ),
                      );
                } else {
                  context.read<OrderTrackingBloc>().add(
                        OrderStatusUpdated(
                          order.copyWith(
                            status: OrderStatus.packaged,
                            readyAt: null,
                          ),
                        ),
                      );
                }
              }
            },
            label: 'Ready for collection',
            icon: MdiIcons.packageVariantClosedCheck,
            isVisible: order.cancelledAt == null,
            canEdit: order.packagedAt != null &&
                order.collectedAt == null &&
                hasPrevilage(OrderEditPrivilage.collector),
          ),
          StatusTile(
            status: OrderStatus.collected,
            date: order.collectedAt,
            onChanged: (status) {},
            label: () {
              if (privilage == OrderEditPrivilage.owner &&
                  order.status == OrderStatus.ready) {
                return 'Tap to Review products';
              } else if (privilage != OrderEditPrivilage.owner &&
                  order.status == OrderStatus.ready) {
                return 'Tap to Confirm collection';
              } else {
                return 'Collected';
              }
            }(),
            isLast: true,
            icon: Icons.done_all,
            isVisible: order.cancelledAt == null,
            canEdit: false,
            onTap: () {
              if (privilage != OrderEditPrivilage.owner &&
                  order.status == OrderStatus.ready) {
                context
                    .showBottomSheetDialog(
                        child: ConfirmOrderCollectionDialog(
                            pin: order.secretPin.toString()))
                    .then((value) {
                  if (value == true) {
                    context.read<OrderTrackingBloc>().add(
                          OrderStatusUpdated(
                            order.copyWith(
                              status: OrderStatus.collected,
                              collectedAt: DateTime.now(),
                            ),
                          ),
                        );
                  }
                });
              } else if (privilage == OrderEditPrivilage.owner &&
                  order.status == OrderStatus.ready) {
                context
                    .showBottomSheetDialog(
                  child: OrderSecretPinDialog(pin: order.secretPin.toString()),
                )
                    .then((value) {
                  if (value == true) {
                    context.read<OrderTrackingBloc>().add(
                          OrderStatusUpdated(
                            order.copyWith(
                              status: OrderStatus.collected,
                              collectedAt: DateTime.now(),
                            ),
                          ),
                        );
                  }
                });
              }
            },
          ),
          StatusTile(
            status: OrderStatus.cancelled,
            date: order.collectedAt,
            onChanged: (status) {},
            label: 'Cancelled',
            isLast: true,
            icon: Icons.close,
            isVisible: order.cancelledAt != null,
          ),
        ],
      ),
    );
  }
}
