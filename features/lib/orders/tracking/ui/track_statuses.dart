import 'package:data_sources/orders/models/order.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/orders/tracking/ui/status_tile.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TrackStatuses extends StatelessWidget {
  const TrackStatuses({
    super.key,
    required this.order,
    required this.previlage,
  });
  final Order order;
  final OrderEditPrivilage previlage;
  bool hasPrevilage(OrderEditPrivilage funprevilage) {
    if (previlage == OrderEditPrivilage.all) {
      return true;
    }
    if (previlage == funprevilage) {
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
              // final products = order.products;
              // if (products.isEmpty) return;
              // reviewProductsDialog(
              //   context,
              //   products: products,
              //   isOwner: isOwner(ref),
              //   previlage: previlage,
              // ).then((value) {
              //   if (hasPrevilage(OrderEditPrivilage.packer)) {
              //     if (value == true && value != null) {
              //       updateTracker(
              //         ref,
              //         order.copyWith(
              //           status: OrderStatus.packaged,
              //           packagedAt: order.packagedAt ?? DateTime.now(),
              //         ),
              //       );
              //     } else {
              //       updateTracker(
              //         ref,
              //         order.copyWith(
              //           status: OrderStatus.placed,
              //           packagedAt: null,
              //           readyAt: null,
              //           collectedAt: null,
              //         ),
              //       );
              //     }
              //   }
              // });
            },
            label: order.status == OrderStatus.placed
                ? 'Tap to package'
                : 'Packaged',
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
              // if (hasPrevilage(OrderEditPrivilage.collector)) {
              //   if (order.status == OrderStatus.ready) {
              //     updateTracker(
              //       ref,
              //       order.copyWith(
              //         status: OrderStatus.packaged,
              //         readyAt: null,
              //       ),
              //     );
              //     return;
              //   } else {
              //     updateTracker(
              //       ref,
              //       order.copyWith(
              //         packagedAt: order.packagedAt ?? DateTime.now(),
              //         readyAt: DateTime.now(),
              //         status: OrderStatus.ready,
              //       ),
              //     );
              //   }
              // }
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
            label: previlage == OrderEditPrivilage.owner
                ? 'Tap to Review products'
                : order.status == OrderStatus.ready
                    ? 'Tap to Confirm collection'
                    : 'Collected',
            isLast: true,
            icon: Icons.done_all,
            isVisible: order.cancelledAt == null,
            //canEdit: order.readyAt != null && hasCollectprevilage(ref),
            canEdit: false,
            onTap: () {
              // if (previlage == OrderEditPrivilage.owner &&
              //     order.status == OrderStatus.ready) {
              //   reviewProductsDialog(
              //     context,
              //     products: order.products,
              //     isOwner: true,
              //     previlage: previlage,
              //   ).then((value) {
              //     if (value == true) {
              //       orderScretePinDialog(context,
              //           pin: order.secretPin.toString());
              //     }
              //   });
              // } else if (hasPrevilage(OrderEditPrivilage.collector) &&
              //     order.status == OrderStatus.ready) {
              //   confirmOrderCollectionDialog(
              //     context,
              //     pin: order.secretPin.toString(),
              //   ).then((value) {
              //     if (value == true) {
              //       if (order.status == OrderStatus.collected) {
              //         updateTracker(
              //           ref,
              //           order.copyWith(
              //             status: OrderStatus.ready,
              //             collectedAt: null,
              //           ),
              //         );
              //       } else {
              //         updateTracker(
              //           ref,
              //           order.copyWith(
              //             readyAt: order.readyAt ?? DateTime.now(),
              //             packagedAt: order.packagedAt ?? DateTime.now(),
              //             collectedAt: DateTime.now(),
              //             status: OrderStatus.collected,
              //           ),
              //         );
              //       }
              //     }
              //   });
              //   }
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
