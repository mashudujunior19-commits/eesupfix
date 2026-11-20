import 'package:auto_route/auto_route.dart';
import 'package:data/orders/models/order.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/views/kasipool_timeline/ui/kasipool_order_timeline.dart';
import 'package:ui/src/views/order_confirmation/ui/confirm_order_screen.dart';
import 'package:ui/src/views/orders/tracking/bloc/order_tracking_bloc.dart';
import 'package:ui/src/views/orders/tracking/ui/collection_pin_widgets.dart';
import 'package:ui/src/views/orders/tracking/ui/confirm_order_collection.dart';
import 'package:ui/src/views/orders/tracking/ui/order_secret_pin_dialog.dart';
import 'package:ui/src/views/orders/tracking/ui/status_tile.dart';
import 'package:ui/src/views/pool_progress/ui/pool_progress_timeline.dart';
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

  /// KasiPool member orders are packed from the Packer's checklist and handed
  /// over with the customer's secret collection PIN (checked by the server).
  bool get isPoolOrder => order.eesupoolOrderId != null;

  bool get isCollected => order.collectedAt != null;

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
              // Ticking every item on the checklist packs the order and
              // issues the customer's collection PIN.
              if (isPoolOrder &&
                  !isCollected &&
                  privilage != OrderEditPrivilage.owner &&
                  hasPrevilage(OrderEditPrivilage.packer)) {
                return 'Tap to open the packing checklist';
              }
              if (privilage != OrderEditPrivilage.owner &&
                  order.status == OrderStatus.placed) {
                return 'Tap to pack';
              } else {
                return 'Packaged';
              }
            }(),
            icon: MdiIcons.packageVariantPlus,
            isVisible: order.cancelledAt == null,
            canEdit: !isPoolOrder &&
                order.placedAt != null &&
                order.readyAt == null &&
                hasPrevilage(OrderEditPrivilage.packer),
            // Pool orders: the Packer opens the order's packing checklist
            // (the Centre may already have marked it Packaged / Ready).
            onTap: isPoolOrder &&
                    !isCollected &&
                    order.placedAt != null &&
                    privilage != OrderEditPrivilage.owner &&
                    hasPrevilage(OrderEditPrivilage.packer)
                ? () => context.router.push(RoleChecklistRoute(
                      eesupoolOrderId: order.eesupoolOrderId!,
                      orderId: order.id,
                      title: 'Order #${order.id}',
                      role: privilage.label,
                    ))
                : null,
          ),
          StatusTile(
            status: OrderStatus.ready,
            date: order.readyAt,
            onChanged: (status) {
              if (hasPrevilage(OrderEditPrivilage.dispatcher)) {
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
            label: isPoolOrder ? 'Ready for collection' : 'Ready for dispatching',
            icon: MdiIcons.packageVariantClosedCheck,
            isVisible: order.cancelledAt == null,
            // Pool orders become Ready when their packing checklist is done.
            canEdit: !isPoolOrder &&
                order.packagedAt != null &&
                order.collectedAt == null &&
                hasPrevilage(OrderEditPrivilage.dispatcher),
          ),
          StatusTile(
            status: OrderStatus.dispatched,
            date: order.collectedAt,
            onChanged: (status) {},
            label: () {
              if (isPoolOrder) {
                if (isCollected) return 'Collected';
                if (privilage != OrderEditPrivilage.owner &&
                    hasPrevilage(OrderEditPrivilage.dispatcher) &&
                    order.status == OrderStatus.ready) {
                  return "Tap to enter the customer's PIN";
                }
                return 'Collected';
              }
              if (privilage == OrderEditPrivilage.owner &&
                  order.status == OrderStatus.ready) {
                return 'Tap to Review products';
              } else if (privilage != OrderEditPrivilage.owner &&
                  order.status == OrderStatus.ready) {
                return 'Tap to Confirm collection';
              } else {
                return 'Dispatched';
              }
            }(),
            isLast: true,
            icon: Icons.done_all,
            isVisible: order.cancelledAt == null,
            canEdit: false,
            onTap: () {
              if (isPoolOrder) {
                if (!isCollected &&
                    privilage != OrderEditPrivilage.owner &&
                    hasPrevilage(OrderEditPrivilage.dispatcher) &&
                    order.status == OrderStatus.ready &&
                    order.id != null) {
                  // The server marks the order collected; the tracking
                  // stream picks the change up.
                  context.showBottomSheetDialog(
                      child: CollectionPinEntryDialog(orderId: order.id!));
                }
                return;
              }
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
                              status: OrderStatus.dispatched,
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
                  child: OrderSecretPinDialog(
                    pin: order.secretPin.toString(),
                    products: order.products,
                  ),
                )
                    .then((value) {
                  if (value == true) {
                    context.read<OrderTrackingBloc>().add(
                          OrderStatusUpdated(
                            order.copyWith(
                              status: OrderStatus.dispatched,
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
          if (isPoolOrder &&
              privilage == OrderEditPrivilage.owner &&
              order.id != null &&
              order.cancelledAt == null)
            MyCollectionPinCard(
              orderId: order.id!,
              refreshKey:
                  '${order.status}|${order.packagedAt}|${order.readyAt}|${order.collectedAt}',
            ),
          if (order.eesupoolOrderId != null)
            PoolProgressTimeline(eesupoolOrderId: order.eesupoolOrderId!),
          if (order.eesupoolOrderId != null) ...[
            const Divider(height: 24),
            KasiPoolOrderTimeline(
              eesupoolOrderId: order.eesupoolOrderId!,
              highlightOrderId: order.id,
              showMemberOrders: false,
            ),
          ],
          if (privilage == OrderEditPrivilage.owner &&
              order.eesupoolOrderId != null &&
              order.id != null &&
              order.status == OrderStatus.ready)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context)
                      .push(ConfirmOrderScreen.route(order.id!)),
                  icon: const Icon(Icons.fact_check_outlined),
                  label: const Text('Confirm what I received'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
